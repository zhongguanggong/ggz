//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module ConvLay1(
	clk,
	rst,
	filt,
	bias,
	pic_data,
	
	out_convl1
);

input clk;
input rst;
//Para_Set1传入的参数
input [47:0]  filt;
input [15:0]  bias;

//上一级传入的图像数据
input [223:0] pic_data;

//输出的一行数据
output reg [447:0] out_convl1;

wire [15:0] filt1 [2:0];

//16位定点数乘法的中间值，最终要从中取出16位作为输出的一个像素点
reg  [31:0]  mid_data;

//通过设置缓存可以实现层内复用及流水线
//滤波器1的缓冲器
reg  [447:0] out_mid1_1;
reg  [447:0] out_mid1_2;
reg  [447:0] out_mid1_3;

//滤波器2的缓冲器
reg  [447:0] out_mid2_1;
reg  [447:0] out_mid2_2;
reg  [447:0] out_mid2_3;

//对图片进行扩展，保留边缘数据，并保持卷积前后图片大小不变
wire [239:0] input_plus;

//输入图片的行数
integer line;
integer count;

assign input_plus = {8'b0, pic_data, 8'b0};
assign filt1[0] = filt[15:0];
assign filt1[1] = filt[31:16];
assign filt1[2] = filt[47:32];



generate 
	genvar i;
	for(i=0;i<28;i=i+1) begin: ggz
		always @(posedge clk)
		begin
			if(rst) begin
				if(i==27) begin //参数初始化
					line = 5'd1;
					count = 0;
				end
			end
			
			else begin
				if(pic_data>=0) begin
					//复用
					mid_data = filt1[0]*input_plus[i*8+7:i*8] + filt1[1]*input_plus[i*8+15:i*8+8] +filt1[2]*input_plus[i*8+23:i*8+16];
					
					if(line == 1) begin
						if(count==0) out_mid1_1[i*16+15:i*16] = 16'h0;
						else if(count==12) out_mid2_1[i*16+15:i*16] = mid_data[24:10];
						if(i==27) begin
							if(count==2 || count==14) begin
								out_convl1 = 448'h0;
							end
							
							else if(count==25) begin
								line = line+1; //26个clk处理一行
							end
						end
					end
					
					else if(line == 2) begin
						if(count==0) out_mid1_2[i*16+15:i*16] = mid_data[24:10];
						else if(count==12) out_mid2_2[i*16+15:i*16] = mid_data[24:10];
			
					  if(count==1) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10];
					  else if(count==13) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10];
						
						if(i==27) begin
							if(count==2 || count==14) begin
								out_convl1 = 448'h0;
							end
							
							else if(count==25) begin
								line = line+1;
							end
						end
					end
					
					else if(line == 29) begin
						if(count==1) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==13) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10];
						
						if(count==2) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16+15:i*16]+mid_data[24:10]+bias;
						else if(count==14) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16+15:i*16]+mid_data[24:10]+bias;
				
						if(count==2) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16+15]<1 ? out_mid1_3[i*16+15:i*16] : 16'h0; //relu激活
						else if(count==14) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16+15]<1 ? out_mid2_3[i*16+15:i*16] : 16'h0;
						
						if(i==27) begin
							if(count==25) line = line+1;
							if(count==2) out_convl1 = out_mid1_3;
							else if(count==14) out_convl1 = out_mid2_3;
						end
						
					end
					
					else if(line == 30) begin
						if(count==2) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10]+bias;
						else if(count==14) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10]+bias;
				
						if(count==2) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15]<1 ? out_mid1_1[i*16+15:i*16] : 16'h0;
						else if(count==14) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15]<1 ? out_mid2_1[i*16+15:i*16] : 16'h0;
						
						if(i==27) begin
							if(count==25) line = 5'd1;
							if(count==2) out_convl1 = out_mid1_1;
							else if(count==14) out_convl1 = out_mid2_1;
						end
					end
					
					else if(line==3 || line==6 || line==9 || line==12 || line==15 || line==18 || line==21 || line==24 || line==27) begin
						if(count==0) out_mid1_3[i*16+15:i*16] = mid_data[24:10];
						else if(count==12) out_mid2_3[i*16+15:i*16] = mid_data[24:10];
						
						if(count==1) out_mid1_2[i*16+15:i*16] = out_mid1_2[i*16+15:i*16]+mid_data[24:10];
						else if(count==13) out_mid2_2[i*16+15:i*16] = out_mid2_2[i*16+15:i*16]+mid_data[24:10];
						
						if(count==2) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10]+bias;
						else if(count==14) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10]+bias;
						
						if(count==2) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15]<1 ? out_mid1_1[i*16+15:i*16] : 16'h0;
						else if(count==14) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15]<1 ? out_mid2_1[i*16+15:i*16] : 16'h0;

						if(i==27) begin
							if(count==25) line = line+1;
							if(count==2) begin
								out_convl1 = out_mid1_1;
								//$display("out_convl1 = %h", out_convl1);
							end
							else if(count==14)begin
								out_convl1 = out_mid2_1;
								//$display("out_convl1 = %h", out_convl1);
							end
						end
					end
					
					else if(line==4 || line==7 || line==10 || line==13 || line==16 || line==19 || line==22 || line==25 || line==28) begin
						if(count==0) out_mid1_1[i*16+15:i*16] = mid_data[24:10];
						else if(count==12) out_mid2_1[i*16+15:i*16] = mid_data[24:10];
						
						if(count==1) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16+15:i*16]+mid_data[24:10];
						else if(count==13) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16+15:i*16]+mid_data[24:10];

						if(count==2) out_mid1_2[i*16+15:i*16] = out_mid1_2[i*16+15:i*16]+mid_data[24:10]+bias;
						else if(count==14) out_mid2_2[i*16+15:i*16] = out_mid2_2[i*16+15:i*16]+mid_data[24:10]+bias;
	
						if(count==2) out_mid1_2[i*16+15:i*16] = out_mid1_2[i*16+15]<1 ? out_mid1_2[i*16+15:i*16] : 16'h0;
						else if(count==14) out_mid2_2[i*16+15:i*16] = out_mid2_2[i*16+15]<1 ? out_mid2_2[i*16+15:i*16] : 16'h0;

						if(i==27) begin
							if(count==25) line = line+1;
							if(count==2) out_convl1 = out_mid1_2;
							else if(count==14) out_convl1 = out_mid2_2;
						end
					end
					
					else begin
						if(count==0) out_mid1_2[i*16+15:i*16] = mid_data[24:10];
						else if(count==12) out_mid2_2[i*16+15:i*16] = mid_data[24:10];
						
						if(count==1) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==13) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10];
					
						if(count==2) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16+15:i*16]+mid_data[24:10]+bias;
						else if(count==14) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16+15:i*16]+mid_data[24:10]+bias;

						if(count==2) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16+15]<1 ? out_mid1_3[i*16+15:i*16] : 16'h0;
						else if(count==14) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16+15]<1 ? out_mid2_3[i*16+15:i*16] : 16'h0;
						
						if(i==27) begin
							if(count==25) line = line+1;
							if(count==2) out_convl1 = out_mid1_3;
							else if(count==14) out_convl1 = out_mid2_3;
						end
					end
					
					if(i==27) begin
						/*if(count==2 || count==14) begin
							$display("out_convl1 = %h", out_convl1);
							if(line==30 && count==14) $display("\n");
						end*/
						
						count = count + 1;
						if(count==26) count = 0;
					end
					
				end
			
			end
		end
	end
endgenerate


endmodule