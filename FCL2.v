//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module FCL2(
	clk,
	rst,
	in_FCL2_1,
	in_FCL2_2,
	in_FCL2_3,
	in_FCL2_4,
	in_FCL2_5,
	in_FCL2_6,
	in_FCL2_7,
	in_FCL2_8,
	in_FCL2_9,
	in_FCL2_10,
	in_FCL2_11,
	in_FCL2_12,
	in_FCL2_13,
	in_FCL2_14,
	in_FCL2_15,
	in_FCL2_16,
	
	out_FCL2_1,
	out_FCL2_2,
	out_FCL2_3,
	out_FCL2_4,
	out_FCL2_5,
	out_FCL2_6,
	out_FCL2_7,
	out_FCL2_8,
	out_FCL2_9,
	out_FCL2_10
);

input clk;
input rst;
input [15:0] in_FCL2_1;
input [15:0] in_FCL2_2;
input [15:0] in_FCL2_3;
input [15:0] in_FCL2_4;
input [15:0] in_FCL2_5;
input [15:0] in_FCL2_6;
input [15:0] in_FCL2_7;
input [15:0] in_FCL2_8;
input [15:0] in_FCL2_9;
input [15:0] in_FCL2_10;
input [15:0] in_FCL2_11;
input [15:0] in_FCL2_12;
input [15:0] in_FCL2_13;
input [15:0] in_FCL2_14;
input [15:0] in_FCL2_15;
input [15:0] in_FCL2_16;

output reg [15:0] out_FCL2_1;
output reg [15:0] out_FCL2_2;
output reg [15:0] out_FCL2_3;
output reg [15:0] out_FCL2_4;
output reg [15:0] out_FCL2_5;
output reg [15:0] out_FCL2_6;
output reg [15:0] out_FCL2_7;
output reg [15:0] out_FCL2_8;
output reg [15:0] out_FCL2_9;
output reg [15:0] out_FCL2_10;

reg [255:0] filt1;
reg [255:0] filt2;
reg [255:0] filt3;
reg [255:0] filt4;
reg [255:0] filt5;
reg [255:0] filt6;
reg [255:0] filt7;
reg [255:0] filt8;
reg [255:0] filt9;
reg [255:0] filt10;

reg [31:0] mid_data;//ע��relu
reg [255:0] para;

integer count;
integer line;

function [255:0] sele_para;
	//input [31:0] in1;
	input [4:0]  in1;
	input [255:0] in2;
	input [255:0] in3;
	input [255:0] in4;
	input [255:0] in5;
	input [255:0] in6;
	input [255:0] in7;
	input [255:0] in8;
	input [255:0] in9;
	input [255:0] in10;
	input [255:0] in11;
	
	begin
		//if(in1==1) begin
			if(in1==0) sele_para = in2;
			else if(in1==1) sele_para = in3;
			else if(in1==2) sele_para = in4;
			else if(in1==3) sele_para = in5;
			else if(in1==4) sele_para = in6;
			else if(in1==5) sele_para = in7;
			else if(in1==6) sele_para = in8;
			else if(in1==7) sele_para = in9;
			else if(in1==8) sele_para = in10;
			else if(in1==9) sele_para = in11;
		//end
	end
endfunction

always @(posedge clk)
begin
	if(rst) begin
		count = 25;
		line  = 30; 
		filt1[15:0] = 16'h31;
		filt1[31:16] = 16'h33;
		filt1[47:32] = 16'h33;
		filt1[63:48] = 16'h34;
		filt1[79:64] = 16'h35;
		filt1[95:80] = 16'h34;
		filt1[111:96] = 16'h33;
		filt1[127:112] = 16'h33;
		filt1[143:128] = 16'h34;
		filt1[159:144] = 16'h31;
		filt1[175:160] = 16'h35;
		filt1[191:176] = 16'h31;
		filt1[207:192] = 16'h34;
		filt1[223:208] = 16'h33;
		filt1[239:224] = 16'h34;
		filt1[255:240] = 16'h35;
		filt2[15:0] = 16'h33;
		filt2[31:16] = 16'h35;
		filt2[47:32] = 16'h33;
		filt2[63:48] = 16'h32;
		filt2[79:64] = 16'h33;
		filt2[95:80] = 16'h33;
		filt2[111:96] = 16'h33;
		filt2[127:112] = 16'h34;
		filt2[143:128] = 16'h34;
		filt2[159:144] = 16'h33;
		filt2[175:160] = 16'h34;
		filt2[191:176] = 16'h34;
		filt2[207:192] = 16'h34;
		filt2[223:208] = 16'h33;
		filt2[239:224] = 16'h34;
		filt2[255:240] = 16'h33;
		filt3[15:0] = 16'h33;
		filt3[31:16] = 16'h32;
		filt3[47:32] = 16'h33;
		filt3[63:48] = 16'h34;
		filt3[79:64] = 16'h35;
		filt3[95:80] = 16'h33;
		filt3[111:96] = 16'h33;
		filt3[127:112] = 16'h33;
		filt3[143:128] = 16'h34;
		filt3[159:144] = 16'h33;
		filt3[175:160] = 16'h33;
		filt3[191:176] = 16'h33;
		filt3[207:192] = 16'h34;
		filt3[223:208] = 16'h34;
		filt3[239:224] = 16'h35;
		filt3[255:240] = 16'h35;
		filt4[15:0] = 16'h33;
		filt4[31:16] = 16'h35;
		filt4[47:32] = 16'h33;
		filt4[63:48] = 16'h35;
		filt4[79:64] = 16'h34;
		filt4[95:80] = 16'h33;
		filt4[111:96] = 16'h34;
		filt4[127:112] = 16'h35;
		filt4[143:128] = 16'h34;
		filt4[159:144] = 16'h33;
		filt4[175:160] = 16'h31;
		filt4[191:176] = 16'h35;
		filt4[207:192] = 16'h33;
		filt4[223:208] = 16'h33;
		filt4[239:224] = 16'h34;
		filt4[255:240] = 16'h33;
		filt5[15:0] = 16'h33;
		filt5[31:16] = 16'h34;
		filt5[47:32] = 16'h33;
		filt5[63:48] = 16'h34;
		filt5[79:64] = 16'h33;
		filt5[95:80] = 16'h34;
		filt5[111:96] = 16'h33;
		filt5[127:112] = 16'h33;
		filt5[143:128] = 16'h34;
		filt5[159:144] = 16'h33;
		filt5[175:160] = 16'h35;
		filt5[191:176] = 16'h34;
		filt5[207:192] = 16'h33;
		filt5[223:208] = 16'h34;
		filt5[239:224] = 16'h33;
		filt5[255:240] = 16'h35;
		filt6[15:0] = 16'h34;
		filt6[31:16] = 16'h34;
		filt6[47:32] = 16'h35;
		filt6[63:48] = 16'h34;
		filt6[79:64] = 16'h34;
		filt6[95:80] = 16'h33;
		filt6[111:96] = 16'h33;
		filt6[127:112] = 16'h34;
		filt6[143:128] = 16'h33;
		filt6[159:144] = 16'h33;
		filt6[175:160] = 16'h34;
		filt6[191:176] = 16'h33;
		filt6[207:192] = 16'h33;
		filt6[223:208] = 16'h34;
		filt6[239:224] = 16'h34;
		filt6[255:240] = 16'h33;
		filt7[15:0] = 16'h34;
		filt7[31:16] = 16'h34;
		filt7[47:32] = 16'h31;
		filt7[63:48] = 16'h35;
		filt7[79:64] = 16'h32;
		filt7[95:80] = 16'h33;
		filt7[111:96] = 16'h35;
		filt7[127:112] = 16'h34;
		filt7[143:128] = 16'h33;
		filt7[159:144] = 16'h34;
		filt7[175:160] = 16'h33;
		filt7[191:176] = 16'h31;
		filt7[207:192] = 16'h34;
		filt7[223:208] = 16'h35;
		filt7[239:224] = 16'h33;
		filt7[255:240] = 16'h35;
		filt8[15:0] = 16'h34;
		filt8[31:16] = 16'h33;
		filt8[47:32] = 16'h35;
		filt8[63:48] = 16'h33;
		filt8[79:64] = 16'h33;
		filt8[95:80] = 16'h33;
		filt8[111:96] = 16'h33;
		filt8[127:112] = 16'h34;
		filt8[143:128] = 16'h33;
		filt8[159:144] = 16'h34;
		filt8[175:160] = 16'h33;
		filt8[191:176] = 16'h34;
		filt8[207:192] = 16'h34;
		filt8[223:208] = 16'h34;
		filt8[239:224] = 16'h35;
		filt8[255:240] = 16'h33;
		filt9[15:0] = 16'h35;
		filt9[31:16] = 16'h34;
		filt9[47:32] = 16'h34;
		filt9[63:48] = 16'h33;
		filt9[79:64] = 16'h34;
		filt9[95:80] = 16'h32;
		filt9[111:96] = 16'h33;
		filt9[127:112] = 16'h33;
		filt9[143:128] = 16'h34;
		filt9[159:144] = 16'h34;
		filt9[175:160] = 16'h34;
		filt9[191:176] = 16'h33;
		filt9[207:192] = 16'h34;
		filt9[223:208] = 16'h33;
		filt9[239:224] = 16'h34;
		filt9[255:240] = 16'h33;
		filt10[15:0] = 16'h35;
		filt10[31:16] = 16'h33;
		filt10[47:32] = 16'h35;
		filt10[63:48] = 16'h33;
		filt10[79:64] = 16'h35;
		filt10[95:80] = 16'h35;
		filt10[111:96] = 16'h31;
		filt10[127:112] = 16'h33;
		filt10[143:128] = 16'h34;
		filt10[159:144] = 16'h33;
		filt10[175:160] = 16'h33;
		filt10[191:176] = 16'h35;
		filt10[207:192] = 16'h33;
		filt10[223:208] = 16'h33;
		filt10[239:224] = 16'h33;
		filt10[255:240] = 16'h34;
	end
	
	else begin
		if(in_FCL2_1>=0) begin		 
			if(line==1) begin
				para = sele_para(count, filt1, filt2, filt3, filt4, filt5, filt6, filt7, filt8, filt9, filt10);
				mid_data = para[15:0]*in_FCL2_1 + para[31:16]*in_FCL2_2 + para[47:32]*in_FCL2_3
							 + para[63:48]*in_FCL2_4 + para[79:64]*in_FCL2_5 + para[95:80]*in_FCL2_6
							 + para[111:96]*in_FCL2_7 + para[127:112]*in_FCL2_8 + para[143:128]*in_FCL2_9
							 + para[159:144]*in_FCL2_10 + para[175:160]*in_FCL2_11 + para[191:176]*in_FCL2_12
							 + para[207:192]*in_FCL2_13 + para[223:208]*in_FCL2_14 + para[239:224]*in_FCL2_15
							 + para[255:240]*in_FCL2_16;
				if(count==0) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data; //relu
					out_FCL2_1 = mid_data[24:10];
					//$display("out_FCL2_1 = %h", out_FCL2_1);
				end
				
				else if(count==1) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data;
					out_FCL2_2 = mid_data[24:10];
				end
				
				else if(count==2) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data;
					out_FCL2_3 = mid_data[24:10];
				end
				
				else if(count==3) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data;
					out_FCL2_4 = mid_data[24:10];
				end
				
				else if(count==4) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data;
					out_FCL2_5 = mid_data[24:10];
				end
				
				else if(count==5) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data;
					out_FCL2_6 = mid_data[24:10];
				end
				
				else if(count==6) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data;
					out_FCL2_7 = mid_data[24:10];
				end
				
				else if(count==7) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data;
					out_FCL2_8 = mid_data[24:10];
				end
				
				else if(count==8) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data;
					out_FCL2_9 = mid_data[24:10];
				end
				
				else if(count==9) begin
					mid_data = mid_data[30] > 0 ? 32'h0 : mid_data;
					out_FCL2_10 = mid_data[24:10];
					//$display("out_FCL2_1 = %h", out_FCL2_1);
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