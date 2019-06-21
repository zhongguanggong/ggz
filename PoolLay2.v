//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module PoolLay2(
	clk,
	rst,
	in_pool2_1,
	in_pool2_2,
	in_pool2_3,
	in_pool2_4,
	
	out_pool2_1,
	out_pool2_2,
	out_pool2_3,
	out_pool2_4
);

input clk;
input rst;
input [223:0] in_pool2_1;
input [223:0] in_pool2_2;
input [223:0] in_pool2_3;
input [223:0] in_pool2_4;

output reg [111:0] out_pool2_1;
output reg [111:0] out_pool2_2;
output reg [111:0] out_pool2_3;
output reg [111:0] out_pool2_4;

reg [111:0] out_mid1;
reg [111:0] out_mid2;
reg [111:0] out_mid3;
reg [111:0] out_mid4;

integer line;
integer count;

function [15:0] max_data;
	input [15:0] in1;
	input [15:0] in2;
	begin
		max_data = in1 > in2 ? in1 : in2;
	end
endfunction

generate 
	genvar i;
	for(i=0;i<7;i=i+1) begin: ggz
		always @(posedge clk) 
		begin
			if(rst) begin
				if(i==6) begin
					line  = 5'd4;
					count = 16;
				end
			end
			
			else begin
				if(in_pool2_1>=0) begin
					if(line==1 || line==2) begin
						if(i==6) begin
							count = count + 1;
							if(count>25) begin
								count = 0;
								line = line + 1;
							end
						end
					end
					
					else if(line==3 || line==5 || line==7 || line==9 || line==11 || line==13 || line==29
					|| line==15 || line==17 || line==19 || line==21 || line==23 || line==25 || line==27) begin
						if(i==6) begin
							count = count + 1;
							if(count>25) begin
								count = 0;
								line = line + 1;
							end
						end
					end
					
					else if(line==4 || line==8 || line==12 || line==16 || line==20 || line==24 || line==28) begin
						if(count==16) begin
							out_mid1[i*16+15:i*16] = max_data(in_pool2_1[i*32+15:i*32], in_pool2_1[i*32+31:i*32+16]);
							if(i==6) count = 17;
						end
						
						else if(count==19) begin
							out_mid2[i*16+15:i*16] = max_data(in_pool2_2[i*32+15:i*32], in_pool2_2[i*32+31:i*32+16]);
							if(i==6) count = 20;
						end
						
						else if(count==22) begin
							out_mid3[i*16+15:i*16] = max_data(in_pool2_3[i*32+15:i*32], in_pool2_3[i*32+31:i*32+16]);
							if(i==6) count = 23;
						end
						
						else if(count==25) begin
							out_mid4[i*16+15:i*16] = max_data(in_pool2_4[i*32+15:i*32], in_pool2_4[i*32+31:i*32+16]);
							if(i==6) begin
								count = 0;
								line = line + 1;
							end
						end
						
						else begin
							if(i==6) count = count + 1;
						end
					end
					
					else begin
						if(count==16) begin
							out_mid1[i*16+15:i*16] = max_data(out_mid1[i*16+15:i*16], in_pool2_1[i*32+15:i*32]);
							out_mid1[i*16+15:i*16] = max_data(out_mid1[i*16+15:i*16], in_pool2_1[i*32+31:i*32+16]);
							//if(i==6) count = 17;
						end
						
						else if(count==19) begin
							out_mid2[i*16+15:i*16] = max_data(out_mid2[i*16+15:i*16], in_pool2_2[i*32+15:i*32]);
							out_mid2[i*16+15:i*16] = max_data(out_mid2[i*16+15:i*16], in_pool2_2[i*32+31:i*32+16]);
							//if(i==6) count = 20;
						end
						
						else if(count==22) begin
							out_mid3[i*16+15:i*16] = max_data(out_mid3[i*16+15:i*16], in_pool2_3[i*32+15:i*32]);
							out_mid3[i*16+15:i*16] = max_data(out_mid3[i*16+15:i*16], in_pool2_3[i*32+31:i*32+16]);
							//if(i==6) count = 23;
						end
						
						else if(count==25) begin
							out_mid4[i*16+15:i*16] = max_data(out_mid4[i*16+15:i*16], in_pool2_4[i*32+15:i*32]);
							out_mid4[i*16+15:i*16] = max_data(out_mid4[i*16+15:i*16], in_pool2_4[i*32+31:i*32+16]);
							
						end
						
						if(i==6) begin
							if(count==16) begin
								out_pool2_1 = out_mid1;
								count = 17;
								//$display("out_pool2_1 = %h", out_pool2_1);
							end
							
							else if(count==19) begin
								out_pool2_2 = out_mid2;
								count = 20;
							end
							
							else if(count==22) begin
								out_pool2_3 = out_mid3;
								count = 23;
							end
							
							else if(count==25) begin
								count = 0;
								out_pool2_4 = out_mid4;
								//$display("out_pool2_4 = %h", out_pool2_4);
								if(line==30) begin
									 line = 5'd1;
									 //$display("\n");
								end
								
								else line = line + 1;
							end
							
							else count = count + 1;
							
						end
					end
					
				end
			end
		end
	end

endgenerate


endmodule