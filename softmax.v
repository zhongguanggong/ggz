//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module softmax(
	clk,
	rst,
	in_SoftMax1,
	in_SoftMax2,
	in_SoftMax3,
	in_SoftMax4,
	in_SoftMax5,
	in_SoftMax6,
	in_SoftMax7,
	in_SoftMax8,
	in_SoftMax9,
	in_SoftMax10,
	
	result
);

input clk;
input rst;
input [15:0] in_SoftMax1;
input [15:0] in_SoftMax2;
input [15:0] in_SoftMax3;
input [15:0] in_SoftMax4;
input [15:0] in_SoftMax5;
input [15:0] in_SoftMax6;
input [15:0] in_SoftMax7;
input [15:0] in_SoftMax8;
input [15:0] in_SoftMax9;
input [15:0] in_SoftMax10;

output reg [7:0] result;
reg [7:0] result_indeed;

integer line;
integer count;

function [7:0] max_data;
	input [15:0] in1;
	input [15:0] in2;
	input [15:0] in3;
	input [15:0] in4;
	input [15:0] in5;
	input [15:0] in6;
	input [15:0] in7;
	input [15:0] in8;
	input [15:0] in9;
	input [15:0] in10;
	reg [7:0] i;
	reg [15:0] j;
	begin
		j = in1;
		i = 8'd1;
		i = in2>j ? 8'd2 : i;
		j = in2>j ? in2 : j;
		i = in3>j ? 8'd3 : i;
		j = in3>j ? in3 : j;
		i = in4>j ? 8'd4 : i;
		j = in4>j ? in4 : j;
		i = in5>j ? 8'd5 : i;
		j = in5>j ? in5 : j;
		i = in6>j ? 8'd6 : i;
		j = in6>j ? in6 : j;
		i = in7>j ? 8'd7 : i;
		j = in7>j ? in7 : j;
		i = in8>j ? 8'd8 : i;
		j = in8>j ? in8 : j;
		i = in9>j ? 8'd9 : i;
		j = in9>j ? in9 : j;
		i = in10>j ? 8'd10 : i;
		j = in10>j ? in10 : j;
		max_data = i;
	end
endfunction


always @(posedge clk)
begin
	if(rst) begin
		line  = 5'd1;
		count = 9;
	end
	
	else begin
		if(in_SoftMax10>=0) begin
			if(line==1 && count==9) begin
				//$display("in_SoftMax10 = %d", in_SoftMax10);
				result_indeed = max_data(in_SoftMax1,in_SoftMax2,in_SoftMax3,in_SoftMax4
			  ,in_SoftMax5,in_SoftMax6,in_SoftMax7,in_SoftMax8,in_SoftMax9,in_SoftMax10);
			  count = 10;
			  case(result_indeed) 
			  	8'd0: result = 8'hC0;
			  	8'd1: result = 8'hF9;
			  	8'd2: result = 8'hA4;
			  	8'd3: result = 8'hB0;
			  	8'd4: result = 8'h99;
			  	8'd5: result = 8'h92;
			  	8'd6: result = 8'h82;
			  	8'd7: result = 8'hF8;
			  	8'd8: result = 8'h80;
			  	8'd9: result = 8'h90;
			  	default: ;
			  endcase
			  //$display("result = %d", result);
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



