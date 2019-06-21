//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module PoolLay1(
	clk,
	rst,
	in_pool1_1,
	in_pool1_2,
	
	out_pool1_1,
	out_pool1_2
);

input clk;
input rst;
input [447:0] in_pool1_1;
input [447:0] in_pool1_2;

//深度与第一个卷积层相同
output reg [223:0] out_pool1_1;
output reg [223:0] out_pool1_2;

reg [223:0] out_mid1;
reg [223:0] out_mid2;

//同步
integer line;
integer count;

//取最大值
function [15:0] max_data;
	input [15:0] in1;
	input [15:0] in2;
	begin
		max_data = in1 > in2 ? in1 : in2;
	end
endfunction

generate 
	genvar i;
	for(i=0;i<14;i=i+1) begin: ggz
		always @(posedge clk) 
		begin
			if(rst) begin
				if(i==13) begin
					line  = 5'd1;
					count = 2;
				end
			end
			
			else begin
				if(in_pool1_1>=0) begin
					if(line==1 || line==2) begin
						if(i==13) begin
							if(count==2) out_pool1_1 = 224'h0;
							else if(count==14) out_pool1_2 = 224'h0;
							if(count==25) line = line+1;
						end
					end
					
					else if(line==3 || line==5 || line==7 || line==9 || line==11 || line==13 || line==29
					|| line==15 || line==17 || line==19 || line==21 || line==23 || line==25 || line==27) begin
						if(count==2)	out_mid1[i*16+15:i*16] = max_data(in_pool1_1[i*32+15:i*32], in_pool1_1[i*32+31:i*32+16]);
						if(count==14)	out_mid2[i*16+15:i*16] = max_data(in_pool1_2[i*32+15:i*32], in_pool1_2[i*32+31:i*32+16]);
						if(i==13) begin
							if(count==25) line = line+1; 
						end
					end
					
					else begin
						if(count==2) begin
							out_mid1[i*16+15:i*16] = max_data(out_mid1[i*16+15:i*16], in_pool1_1[i*32+15:i*32]);
							out_mid1[i*16+15:i*16] = max_data(out_mid1[i*16+15:i*16], in_pool1_1[i*32+31:i*32+16]);
						end
						
						if(count==14) begin
							out_mid2[i*16+15:i*16] = max_data(out_mid2[i*16+15:i*16], in_pool1_2[i*32+15:i*32]);
							out_mid2[i*16+15:i*16] = max_data(out_mid2[i*16+15:i*16], in_pool1_2[i*32+31:i*32+16]);
						end
						
						if(i==13) begin
							if(count==2) out_pool1_1 = out_mid1;
							else if(count==14) out_pool1_2 = out_mid2;
							
							/*if(count==25) begin
								$display("out_pool1_1 = %h", out_pool1_1);
							end*/
							
							if(line == 30 && count==25) begin 
								line = 5'd1;
								//$display("\n");
							end
							else begin
								if(count==25) line = line + 1;
							end
						end
					end
					
					if(i==13) begin
						count = count + 1;
						if(count==26) begin
							 count = 0;
							 //$display("out_pool1_1 = %h", out_pool1_1);
						end
					end
					
				end
			end
		end
	end

endgenerate


endmodule