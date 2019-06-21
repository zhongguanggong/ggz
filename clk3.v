//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module clk3(
	clk,
	rst,
	out_pool1_1,
	out_pool1_2,

	in_conv2_1,
	in_conv2_2
);

input clk;
input rst;
input [223:0] out_pool1_1;
input [223:0] out_pool1_2;

output reg [223:0] in_conv2_1;
output reg [223:0] in_conv2_2;

integer count;

always @(posedge clk)
begin
	if(rst) count = 2;

	else begin
		if(out_pool1_1>=0) begin
			if(count==2) begin
				in_conv2_1 = out_pool1_1;
				count = 3;
				//$display("in_conv2_1 = %h", in_conv2_1);
			end
			
			else if(count==14) begin
				in_conv2_2 = out_pool1_2;
				count = 15;
				//$display("in_conv2_2 = %h", in_conv2_2);
			end
			
			else begin
				count = count + 1;
				if(count==26) begin
					count = 0;
				end
			end
		end
	end
end

endmodule