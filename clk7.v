//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module clk7(
	clk,
	rst,
	out_FCL2_1,
	out_FCL2_2,
	out_FCL2_3,
	out_FCL2_4,
	out_FCL2_5,
	out_FCL2_6,
	out_FCL2_7,
	out_FCL2_8,
	out_FCL2_9,
	out_FCL2_10,
	
	in_SoftMax1,
	in_SoftMax2,
	in_SoftMax3,
	in_SoftMax4,
	in_SoftMax5,
	in_SoftMax6,
	in_SoftMax7,
	in_SoftMax8,
	in_SoftMax9,
	in_SoftMax10
);

input clk;
input rst;
input [15:0] out_FCL2_1;
input [15:0] out_FCL2_2;
input [15:0] out_FCL2_3;
input [15:0] out_FCL2_4;
input [15:0] out_FCL2_5;
input [15:0] out_FCL2_6;
input [15:0] out_FCL2_7;
input [15:0] out_FCL2_8;
input [15:0] out_FCL2_9;
input [15:0] out_FCL2_10;

output reg [15:0] in_SoftMax1;
output reg [15:0] in_SoftMax2;
output reg [15:0] in_SoftMax3;
output reg [15:0] in_SoftMax4;
output reg [15:0] in_SoftMax5;
output reg [15:0] in_SoftMax6;
output reg [15:0] in_SoftMax7;
output reg [15:0] in_SoftMax8;
output reg [15:0] in_SoftMax9;
output reg [15:0] in_SoftMax10;

integer count;
integer line;

always @(posedge clk)
begin
	if(rst) begin
		count = 9;
		line  = 1;
	end
	
	else begin
		if(out_FCL2_10>=0) begin
			if(line==1) begin
				if(count==9) begin
					in_SoftMax1 = out_FCL2_1;
					in_SoftMax2 = out_FCL2_2;
					in_SoftMax3 = out_FCL2_3;
					in_SoftMax4 = out_FCL2_4;
					in_SoftMax5 = out_FCL2_5;
					in_SoftMax6 = out_FCL2_6;
					in_SoftMax7 = out_FCL2_7;
					in_SoftMax8 = out_FCL2_8;
					in_SoftMax9 = out_FCL2_9;
					in_SoftMax10 = out_FCL2_10;
					//$display("in_SoftMax10 = %h", in_SoftMax10);
				end
				
				count = count + 1;
				if(count>25) begin
					count = 0;
					line = 2;
				end
			end
			
			else begin
				count = count + 1;
				if(count>25) begin
					count = 0;
					line = line + 1;
					if(line>30) line = 1;
				end
			end
		end
	end
end


endmodule