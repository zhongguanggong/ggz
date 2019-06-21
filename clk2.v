//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module clk2(
	clk,
	rst,
	out_convl1,
	
	in_pool1_1,
	in_pool1_2
);

input clk;
input rst;
input [447:0] out_convl1; //第一个卷积层的输出（一次传过来一幅图像，共两幅图像）
 
output reg [447:0] in_pool1_1; //第一个卷积层输出图像1
output reg [447:0] in_pool1_2; ////第一个卷积层输出图像2

integer count;

always @(posedge clk)
begin
	if(rst) count = 0;

	else begin
		if(out_convl1>=0) begin
			if(count==2) begin
				in_pool1_1 = out_convl1;
				count = 3;
				//$display("in_pool1_1 = %h", in_pool1_1);
			end
			
			else if(count==14) begin
				in_pool1_2 = out_convl1;
				count = 15;
				//$display("in_pool1_2 = %h", in_pool1_2);
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