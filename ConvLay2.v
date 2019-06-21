//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module ConvLay2(
	clk,
	rst,
	filt,
	bias,
	in_conv2_1,
	in_conv2_2,
	
	out_convl2
);

input clk;
input rst;
input [223:0] in_conv2_1;
input [223:0] in_conv2_2;
input [47:0] filt;
input [15:0] bias;

//输出一行数据
output reg [223:0] out_convl2;

wire [15:0] filt1 [2:0];

reg  [31:0]  mid_data;

//滤波器1的缓冲器
reg  [223:0] out_mid1_1;
reg  [223:0] out_mid1_2;
reg  [223:0] out_mid1_3;

reg  [223:0] out_mid2_1;
reg  [223:0] out_mid2_2;
reg  [223:0] out_mid2_3;

reg  [223:0] out_mid3_1;
reg  [223:0] out_mid3_2;
reg  [223:0] out_mid3_3;

reg  [223:0] out_mid4_1;
reg  [223:0] out_mid4_2;
reg  [223:0] out_mid4_3;

wire [255:0] input_plus1;
wire [255:0] input_plus2;

//输入图片的行数
integer line;
integer count;

assign input_plus1 = {16'b0, in_conv2_1, 16'b0}; //图片扩展
assign input_plus2 = {16'b0, in_conv2_2, 16'b0};

assign	filt1[0]  = filt[15:0];
assign	filt1[1]  = filt[31:16];
assign	filt1[2]  = filt[47:32];	

generate 
	genvar i;
	for(i=0;i<14;i=i+1) begin: ggz
		always @(posedge clk)
		begin
			if(rst) begin
				if(i==13) begin //参数初始化
					line = 5'd1;
					count = 2;
				end
			end
			
			else begin
				if(in_conv2_1>=0) begin
					//复用
					mid_data = filt1[0]*(count<14 ? input_plus1[i*16+15:i*16] : input_plus2[i*16+15:i*16]) 
									 + filt1[1]*(count<14 ? input_plus1[i*16+31:i*16+16] : input_plus2[i*16+31:i*16+16]) 
									 + filt1[2]*(count<14 ? input_plus1[i*16+47:i*16+32] : input_plus2[i*16+47:i*16+32]);
					
					if(line == 1) begin
						if(count==2) out_mid1_1[i*16+15:i*16] = mid_data[24:10]; ////*****写完建工程试一下语法
						else if(count==14) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16] + mid_data[24:10];
						else if(count==5)  out_mid2_1[i*16+15:i*16] = mid_data[24:10];
						else if(count==17) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16] + mid_data[24:10];
						else if(count==8)  out_mid3_1[i*16+15:i*16] = mid_data[24:10];
						else if(count==20) out_mid3_1[i*16+15:i*16] = out_mid3_1[i*16+15:i*16] + mid_data[24:10];
						else if(count==11) out_mid4_1[i*16+15:i*16] = mid_data[24:10];
						else if(count==23) out_mid4_1[i*16+15:i*16] = out_mid4_1[i*16+15:i*16] + mid_data[24:10];
						
						if(i==13) begin
							if(count==25) begin
								 line = line + 1;
								 //out_convl2 = 448'h0;
							end
							//if(count==16 || count==19 || count==22) out_convl2 = 448'h0;
						end
					end
					
					else if(line == 2) begin
						if(count==2) out_mid1_2[i*16+15:i*16] = mid_data[24:10]; ////*****写完建工程试一下语法
						else if(count==14) out_mid1_2[i*16+15:i*16] = out_mid1_2[i*16+15:i*16] + mid_data[24:10];
						else if(count==5)  out_mid2_2[i*16+15:i*16] = mid_data[24:10];
						else if(count==17) out_mid2_2[i*16+15:i*16] = out_mid2_2[i*16+15:i*16] + mid_data[24:10];
						else if(count==8)  out_mid3_2[i*16+15:i*16] = mid_data[24:10];
						else if(count==20) out_mid3_2[i*16+15:i*16] = out_mid3_2[i*16+15:i*16] + mid_data[24:10];
						else if(count==11) out_mid4_2[i*16+15:i*16] = mid_data[24:10];
						else if(count==23) out_mid4_2[i*16+15:i*16] = out_mid4_2[i*16+15:i*16] + mid_data[24:10];
					
						if(count==3 || count==15) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==6 || count==18)  out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==9 || count==21) out_mid3_1[i*16+15:i*16] = out_mid3_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==12 || count==24) out_mid4_1[i*16+15:i*16] = out_mid4_1[i*16+15:i*16]+mid_data[24:10];
						
						if(i==13) begin
							if(count==25) begin
								 line = line + 1;
								 //out_convl2 = 448'h0;
							end
							//if(count==16 || count==19 || count==22) out_convl2 = 448'h0;
						end
					end
					
					else if(line == 29) begin
						if(count==3 || count==15) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==6 || count==18) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==9 || count==21) out_mid3_1[i*16+15:i*16] = out_mid3_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==12 || count==24) out_mid4_1[i*16+15:i*16] = out_mid4_1[i*16+15:i*16]+mid_data[24:10];
						
						if(count==4 || count==16) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==7 || count==19) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==10 || count==22) out_mid3_3[i*16+15:i*16] = out_mid3_3[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==13 || count==25) out_mid4_3[i*16+15:i*16] = out_mid4_3[i*16+15:i*16]+mid_data[24:10] + bias;
						
						if(count==16) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16] < 1 ? out_mid1_3[i*16+15:i*16] : 16'h0;
						else if(count==19)  out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16] < 1 ? out_mid2_3[i*16+15:i*16] : 16'h0;
						else if(count==22) out_mid3_3[i*16+15:i*16] = out_mid3_3[i*16] < 1 ? out_mid3_3[i*16+15:i*16] : 16'h0;
						else if(count==25) out_mid4_3[i*16+15:i*16] = out_mid4_3[i*16] < 1 ? out_mid4_3[i*16+15:i*16] : 16'h0;
						
						if(i==13) begin
							if(count==25) begin
								line = line + 1;
								out_convl2 = out_mid4_3;
							end
							
							if(count==16) out_convl2 = out_mid1_3;
							else if(count==19) out_convl2 = out_mid2_3;
							else if(count==22) out_convl2 = out_mid3_3;
						end
					end
					
					else if(line == 30) begin
						if(count==4 || count==16) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==7 || count==19) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==10 || count==22) out_mid3_1[i*16+15:i*16] = out_mid3_1[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==13 || count==25) out_mid4_1[i*16+15:i*16] = out_mid4_1[i*16+15:i*16]+mid_data[24:10] + bias;
						
						if(count==4 || count==16) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16] < 1 ? out_mid1_1[i*16+15:i*16] : 16'h0;
						else if(count==7 || count==19) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16] < 1 ? out_mid2_1[i*16+15:i*16] : 16'h0;
						else if(count==10 || count==22) out_mid3_1[i*16+15:i*16] = out_mid3_1[i*16] < 1 ? out_mid3_1[i*16+15:i*16] : 16'h0;
						else if(count==13 || count==25) out_mid4_1[i*16+15:i*16] = out_mid4_1[i*16] < 1 ? out_mid4_1[i*16+15:i*16] : 16'h0;
						
						if(i==13) begin
							if(count==25) begin
								line = 5'd1;
								out_convl2 = out_mid4_1;
							end
							
							if(count==16) out_convl2 = out_mid1_1;
							else if(count==19) out_convl2 = out_mid2_1;
							else if(count==22) out_convl2 = out_mid3_1;
 
						end
					end
					
					//没有数据进来，不做处理
					else if(line==3 || line==5 || line==7 || line==9 || line==11 || line==13 
					|| line==15 || line==17 || line==19 || line==21 || line==23 || line==25 || line==27) begin
						if(i==13 && count==25) line = line+1;
					end
					
					else if(line==4 || line==10 || line==16 || line==22 || line==28) begin
						if(count==2) out_mid1_3[i*16+15:i*16] = mid_data[24:10]; ////*****写完建工程试一下语法
						else if(count==14) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16+15:i*16] + mid_data[24:10];
						else if(count==5)  out_mid2_3[i*16+15:i*16] = mid_data[24:10];
						else if(count==17) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16+15:i*16] + mid_data[24:10];
						else if(count==8)  out_mid3_3[i*16+15:i*16] = mid_data[24:10];
						else if(count==20) out_mid3_3[i*16+15:i*16] = out_mid3_3[i*16+15:i*16] + mid_data[24:10];
						else if(count==11) out_mid4_3[i*16+15:i*16] = mid_data[24:10];
						else if(count==23) out_mid4_3[i*16+15:i*16] = out_mid4_3[i*16+15:i*16] + mid_data[24:10];
					
						if(count==3 || count==15) out_mid1_2[i*16+15:i*16] = out_mid1_2[i*16+15:i*16]+mid_data[24:10];
						else if(count==6 || count==18) out_mid2_2[i*16+15:i*16] = out_mid2_2[i*16+15:i*16]+mid_data[24:10];
						else if(count==9 || count==21) out_mid3_2[i*16+15:i*16] = out_mid3_2[i*16+15:i*16]+mid_data[24:10];
						else if(count==12 || count==24) out_mid4_2[i*16+15:i*16] = out_mid4_2[i*16+15:i*16]+mid_data[24:10];
						
						if(count==4 || count==16) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==7 || count==19) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==10 || count==22) out_mid3_1[i*16+15:i*16] = out_mid3_1[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==13 || count==25) out_mid4_1[i*16+15:i*16] = out_mid4_1[i*16+15:i*16]+mid_data[24:10] + bias;
						
						if(count==4 || count==16) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16] < 1 ? out_mid1_1[i*16+15:i*16] : 16'h0;
						else if(count==7 || count==19) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16] < 1 ? out_mid2_1[i*16+15:i*16] : 16'h0;
						else if(count==10 || count==22) out_mid3_1[i*16+15:i*16] = out_mid3_1[i*16] < 1 ? out_mid3_1[i*16+15:i*16] : 16'h0;
						else if(count==13 || count==25) out_mid4_1[i*16+15:i*16] = out_mid4_1[i*16] < 1 ? out_mid4_1[i*16+15:i*16] : 16'h0;
					
						if(i==13) begin
							if(count==25) begin
								line = line + 1;
								out_convl2 = out_mid4_1;
							end
							
							if(count==16) out_convl2 = out_mid1_1;
							else if(count==19) out_convl2 = out_mid2_1;
							else if(count==22) out_convl2 = out_mid3_1;
						end
					end
					
					else if(line==6 || line==12 || line==18 || line==24) begin
						if(count==2) out_mid1_1[i*16+15:i*16] = mid_data[24:10]; ////*****写完建工程试一下语法
						else if(count==14) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16] + mid_data[24:10];
						else if(count==5)  out_mid2_1[i*16+15:i*16] = mid_data[24:10];
						else if(count==17) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16] + mid_data[24:10];
						else if(count==8)  out_mid3_1[i*16+15:i*16] = mid_data[24:10];
						else if(count==20) out_mid3_1[i*16+15:i*16] = out_mid3_1[i*16+15:i*16] + mid_data[24:10];
						else if(count==11) out_mid4_1[i*16+15:i*16] = mid_data[24:10];
						else if(count==23) out_mid4_1[i*16+15:i*16] = out_mid4_1[i*16+15:i*16] + mid_data[24:10];
					
						if(count==3 || count==15) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16+15:i*16]+mid_data[24:10];
						else if(count==6 || count==18) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16+15:i*16]+mid_data[24:10];
						else if(count==9 || count==21) out_mid3_3[i*16+15:i*16] = out_mid3_3[i*16+15:i*16]+mid_data[24:10];
						else if(count==12 || count==24) out_mid4_3[i*16+15:i*16] = out_mid4_3[i*16+15:i*16]+mid_data[24:10];
						
						if(count==4 || count==16) out_mid1_2[i*16+15:i*16] = out_mid1_2[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==7 || count==19) out_mid2_2[i*16+15:i*16] = out_mid2_2[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==10 || count==22) out_mid3_2[i*16+15:i*16] = out_mid3_2[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==13 || count==25) out_mid4_2[i*16+15:i*16] = out_mid4_2[i*16+15:i*16]+mid_data[24:10] + bias;
						
						if(count==4 || count==16) out_mid1_2[i*16+15:i*16] = out_mid1_2[i*16] < 1 ? out_mid1_2[i*16+15:i*16] : 16'h0;
						else if(count==7 || count==19) out_mid2_2[i*16+15:i*16] = out_mid2_2[i*16] < 1 ? out_mid2_2[i*16+15:i*16] : 16'h0;
						else if(count==10 || count==22) out_mid3_2[i*16+15:i*16] = out_mid3_2[i*16] < 1 ? out_mid3_2[i*16+15:i*16] : 16'h0;
						else if(count==13 || count==25) out_mid4_2[i*16+15:i*16] = out_mid4_2[i*16] < 1 ? out_mid4_2[i*16+15:i*16] : 16'h0;
					
						if(i==13) begin
							if(count==25) begin
								line = line + 1;
								out_convl2 = out_mid4_2;
							end
							
							if(count==16) out_convl2 = out_mid1_2;
							else if(count==19) out_convl2 = out_mid2_2;
							else if(count==22) out_convl2 = out_mid3_2;
						end
					end
					
					else begin
						if(count==2) out_mid1_2[i*16+15:i*16] = mid_data[24:10]; ////*****写完建工程试一下语法
						else if(count==14) out_mid1_2[i*16+15:i*16] = out_mid1_2[i*16+15:i*16] + mid_data[24:10];
						else if(count==5)  out_mid2_2[i*16+15:i*16] = mid_data[24:10];
						else if(count==17) out_mid2_2[i*16+15:i*16] = out_mid2_2[i*16+15:i*16] + mid_data[24:10];
						else if(count==8)  out_mid3_2[i*16+15:i*16] = mid_data[24:10];
						else if(count==20) out_mid3_2[i*16+15:i*16] = out_mid3_2[i*16+15:i*16] + mid_data[24:10];
						else if(count==11) out_mid4_2[i*16+15:i*16] = mid_data[24:10];
						else if(count==23) out_mid4_2[i*16+15:i*16] = out_mid4_2[i*16+15:i*16] + mid_data[24:10];
					
						if(count==3 || count==15) out_mid1_1[i*16+15:i*16] = out_mid1_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==6 || count==18) out_mid2_1[i*16+15:i*16] = out_mid2_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==9 || count==21) out_mid3_1[i*16+15:i*16] = out_mid3_1[i*16+15:i*16]+mid_data[24:10];
						else if(count==12 || count==24) out_mid4_1[i*16+15:i*16] = out_mid4_1[i*16+15:i*16]+mid_data[24:10];
						
						if(count==4 || count==16) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==7 || count==19) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==10 || count==22) out_mid3_3[i*16+15:i*16] = out_mid3_3[i*16+15:i*16]+mid_data[24:10] + bias;
						else if(count==13 || count==25) out_mid4_3[i*16+15:i*16] = out_mid4_3[i*16+15:i*16]+mid_data[24:10] + bias;
						
						if(count==4 || count==16) out_mid1_3[i*16+15:i*16] = out_mid1_3[i*16] < 1 ? out_mid1_3[i*16+15:i*16] : 16'h0;
						else if(count==7 || count==19) out_mid2_3[i*16+15:i*16] = out_mid2_3[i*16] < 1 ? out_mid2_3[i*16+15:i*16] : 16'h0;
						else if(count==10 || count==22) out_mid3_3[i*16+15:i*16] = out_mid3_3[i*16] < 1 ? out_mid3_3[i*16+15:i*16] : 16'h0;
						else if(count==13 || count==25) out_mid4_3[i*16+15:i*16] = out_mid4_3[i*16] < 1 ? out_mid4_3[i*16+15:i*16] : 16'h0;
					
						if(i==13) begin
							if(count==25) begin
								line = line + 1;
								out_convl2 = out_mid4_3;
							end
							
							if(count==16) out_convl2 = out_mid1_3;
							else if(count==19) out_convl2 = out_mid2_3;
							else if(count==22) out_convl2 = out_mid3_3;
						end
					end
					
					if(i==13) begin
						count = count + 1;
						if(count==26) begin
							count = 0;
						end
						
						//else if(count==16) $display("out_convl2 = %h", out_convl2);
					end
					
				end
			end
		end
	end
endgenerate


endmodule