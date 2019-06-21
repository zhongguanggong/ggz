//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module FCL1(
	clk,
	rst,
	filt1,
	filt2,
	filt3,
	filt4,
	filt5,
	filt6,
	filt7,
	filt8,
	filt9,
	filt10,
	filt11,
	filt12,
	filt13,
	filt14,
	filt15,
	filt16,
	bias1,
	bias2,
	bias3,
	bias4,
	bias5,
	bias6,
	bias7,
	bias8,
	bias9,
	bias10,
	bias11,
	bias12,
	bias13,
	bias14,
	bias15,
	bias16,
	in_FCL1_1,
	in_FCL1_2,
	in_FCL1_3,
	in_FCL1_4,
	
	out_FCL1_1,
	out_FCL1_2,
	out_FCL1_3,
	out_FCL1_4,
	out_FCL1_5,
	out_FCL1_6,
	out_FCL1_7,
	out_FCL1_8,
	out_FCL1_9,
	out_FCL1_10,
	out_FCL1_11,
	out_FCL1_12,
	out_FCL1_13,
	out_FCL1_14,
	out_FCL1_15,
	out_FCL1_16
);

input clk;
input rst;
input [111:0] filt1;
input [111:0] filt2;
input [111:0] filt3;
input [111:0] filt4;
input [111:0] filt5;
input [111:0] filt6;
input [111:0] filt7;
input [111:0] filt8;
input [111:0] filt9;
input [111:0] filt10;
input [111:0] filt11;
input [111:0] filt12;
input [111:0] filt13;
input [111:0] filt14;
input [111:0] filt15;
input [111:0] filt16;
input [15:0] bias1;
input [15:0] bias2;
input [15:0] bias3;
input [15:0] bias4;
input [15:0] bias5;
input [15:0] bias6;
input [15:0] bias7;
input [15:0] bias8;
input [15:0] bias9;
input [15:0] bias10;
input [15:0] bias11;
input [15:0] bias12;
input [15:0] bias13;
input [15:0] bias14;
input [15:0] bias15;
input [15:0] bias16;
input [111:0] in_FCL1_1;
input [111:0] in_FCL1_2;
input [111:0] in_FCL1_3;
input [111:0] in_FCL1_4;

output reg [15:0] out_FCL1_1;
output reg [15:0] out_FCL1_2;
output reg [15:0] out_FCL1_3;
output reg [15:0] out_FCL1_4;
output reg [15:0] out_FCL1_5;
output reg [15:0] out_FCL1_6;
output reg [15:0] out_FCL1_7;
output reg [15:0] out_FCL1_8;
output reg [15:0] out_FCL1_9;
output reg [15:0] out_FCL1_10;
output reg [15:0] out_FCL1_11;
output reg [15:0] out_FCL1_12;
output reg [15:0] out_FCL1_13;
output reg [15:0] out_FCL1_14;
output reg [15:0] out_FCL1_15;
output reg [15:0] out_FCL1_16;

reg [31:0] mid_data1;
reg [31:0] mid_data2;
reg [31:0] mid_data3;
reg [31:0] mid_data4;
reg [31:0] mid_data5;
reg [31:0] mid_data6;
reg [31:0] mid_data7;
reg [31:0] mid_data8;
reg [31:0] mid_data9;
reg [31:0] mid_data10;
reg [31:0] mid_data11;
reg [31:0] mid_data12;
reg [31:0] mid_data13;
reg [31:0] mid_data14;
reg [31:0] mid_data15;
reg [31:0] mid_data16;

integer line;
integer count;

function [15:0] sele_data;
	input [15:0] in1;
	input [15:0] in2;
	input [15:0] in3;
	input [15:0] in4;
	begin
		if(count<=16) begin
			sele_data = in1;
		end
		
		else if(count<=19) begin
			sele_data = in2;
		end
		
		else if(count<=22) begin
			sele_data = in3;
		end
		
		else if(count<=25) begin
			sele_data = in4;
		end
	end
endfunction

always @(posedge clk)
begin
	if(rst) begin
			line = 6;
			count = 16;
	end
	
	else begin
		if(in_FCL1_1>=0) begin
			if(line==6 || line==10 || line==14 || line==18 || line==22 || line==26 || line==30) begin
				//if(count==16) $display("filt16l = %h line = %d", filt16, line);
				mid_data1 = filt1[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt1[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt1[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt1[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt1[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt1[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt1[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				mid_data2 = filt2[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt2[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt2[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt2[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt2[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt2[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt2[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
			  mid_data3 = filt3[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt3[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt3[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt3[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt3[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt3[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt3[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);    
				mid_data4 = filt4[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt4[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt4[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt4[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt4[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt4[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt4[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);      
				mid_data5 = filt5[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt5[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt5[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt5[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt5[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt5[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt5[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				mid_data6 = filt6[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt6[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt6[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt6[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt6[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt6[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt6[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				mid_data7 = filt7[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt7[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt7[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt7[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt7[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt7[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt7[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				mid_data8 = filt8[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt8[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt8[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt8[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt8[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt8[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt8[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				mid_data9 = filt9[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt9[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt9[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt9[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt9[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt9[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt9[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				mid_data10 = filt10[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt10[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt10[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt10[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt10[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt10[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt10[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
			  mid_data11 = filt11[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt11[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt11[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt11[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt11[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt11[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt11[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);    
				mid_data12 = filt12[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt12[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt12[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt12[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt12[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt12[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt12[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);      
				mid_data13 = filt13[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt13[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt13[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt13[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt13[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt13[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt13[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				mid_data14 = filt14[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt14[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt14[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt14[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt14[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt14[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt14[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				mid_data15 = filt15[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt15[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt15[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt15[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt15[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt15[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt15[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				mid_data16 = filt16[15:0]*sele_data(in_FCL1_1[15:0], in_FCL1_2[15:0], in_FCL1_3[15:0], in_FCL1_4[15:0])
				           +filt16[31:16]*sele_data(in_FCL1_1[31:16], in_FCL1_2[31:16], in_FCL1_3[31:16], in_FCL1_4[31:16])
				           +filt16[47:32]*sele_data(in_FCL1_1[47:32], in_FCL1_2[47:32], in_FCL1_3[47:32], in_FCL1_4[47:32])
				           +filt16[63:48]*sele_data(in_FCL1_1[63:48], in_FCL1_2[63:48], in_FCL1_3[63:48], in_FCL1_4[63:48])
				           +filt16[79:64]*sele_data(in_FCL1_1[79:64], in_FCL1_2[79:64], in_FCL1_3[79:64], in_FCL1_4[79:64])
				           +filt16[95:80]*sele_data(in_FCL1_1[95:80], in_FCL1_2[95:80], in_FCL1_3[95:80], in_FCL1_4[95:80])
				           +filt16[111:96]*sele_data(in_FCL1_1[111:96], in_FCL1_2[111:96], in_FCL1_3[111:96], in_FCL1_4[111:96]);
				//if(count==16) $display("mid_data16 = %h", mid_data16);
				//if(count==25) $display("in_FCL1_4 = %h", in_FCL1_4);
				if(count==16) begin
					//if(line==30) $display("mid_data16 = %h", mid_data16);
					if(line==6) begin
						out_FCL1_1 = mid_data1[24:10];
						out_FCL1_2 = mid_data2[24:10];
						out_FCL1_3 = mid_data3[24:10];
						out_FCL1_4 = mid_data4[24:10];
						out_FCL1_5 = mid_data5[24:10];
						out_FCL1_6 = mid_data6[24:10];
						out_FCL1_7 = mid_data7[24:10];
						out_FCL1_8 = mid_data8[24:10];
						out_FCL1_9 = mid_data9[24:10];
						out_FCL1_10 = mid_data10[24:10];
						out_FCL1_11 = mid_data11[24:10];
						out_FCL1_12 = mid_data12[24:10];
						out_FCL1_13 = mid_data13[24:10];
						out_FCL1_14 = mid_data14[24:10];
						out_FCL1_15 = mid_data15[24:10];
						out_FCL1_16 = mid_data16[24:10];
						//$display("out_FCL1_16 = %h", out_FCL1_16);
					end
					
					else begin
						out_FCL1_1 = out_FCL1_1 + mid_data1[24:10];
						out_FCL1_2 = out_FCL1_2 + mid_data2[24:10];
						out_FCL1_3 = out_FCL1_3 + mid_data3[24:10];
						out_FCL1_4 = out_FCL1_4 + mid_data4[24:10];
						out_FCL1_5 = out_FCL1_5 + mid_data5[24:10];
						out_FCL1_6 = out_FCL1_6 + mid_data6[24:10];
						out_FCL1_7 = out_FCL1_7 + mid_data7[24:10];
						out_FCL1_8 = out_FCL1_8 + mid_data8[24:10];
						out_FCL1_9 = out_FCL1_9 + mid_data9[24:10];
						out_FCL1_10 = out_FCL1_10 + mid_data10[24:10];
						out_FCL1_11 = out_FCL1_11 + mid_data11[24:10];
						out_FCL1_12 = out_FCL1_12 + mid_data12[24:10];
						out_FCL1_13 = out_FCL1_13 + mid_data13[24:10];
						out_FCL1_14 = out_FCL1_14 + mid_data14[24:10];
						out_FCL1_15 = out_FCL1_15 + mid_data15[24:10];
						//$display("out_FCL1_16 = %h", out_FCL1_16);
						out_FCL1_16 = out_FCL1_16 + mid_data16[24:10];
						//$display("out_FCL1_16 = %h", out_FCL1_16);
					end
					
					count = 17;
				end
				
				else if(count==19) begin
					//$display("mid_data2 = %h", mid_data2);
					out_FCL1_1 = out_FCL1_1 + mid_data1[24:10];
					out_FCL1_2 = out_FCL1_2 + mid_data2[24:10];
					out_FCL1_3 = out_FCL1_3 + mid_data3[24:10];
					out_FCL1_4 = out_FCL1_4 + mid_data4[24:10];
					out_FCL1_5 = out_FCL1_5 + mid_data5[24:10];
					out_FCL1_6 = out_FCL1_6 + mid_data6[24:10];
					out_FCL1_7 = out_FCL1_7 + mid_data7[24:10];
					out_FCL1_8 = out_FCL1_8 + mid_data8[24:10];
					out_FCL1_9 = out_FCL1_9 + mid_data9[24:10];
					out_FCL1_10 = out_FCL1_10 + mid_data10[24:10];
					out_FCL1_11 = out_FCL1_11 + mid_data11[24:10];
					out_FCL1_12 = out_FCL1_12 + mid_data12[24:10];
					out_FCL1_13 = out_FCL1_13 + mid_data13[24:10];
					out_FCL1_14 = out_FCL1_14 + mid_data14[24:10];
					out_FCL1_15 = out_FCL1_15 + mid_data15[24:10];
					//$display("out_FCL1_16 = %h", out_FCL1_16);
					out_FCL1_16 = out_FCL1_16 + mid_data16[24:10];
					count = 20;
				end
				
				else if(count==22) begin
					out_FCL1_1 = out_FCL1_1 + mid_data1[24:10];
					out_FCL1_2 = out_FCL1_2 + mid_data2[24:10];
					out_FCL1_3 = out_FCL1_3 + mid_data3[24:10];
					out_FCL1_4 = out_FCL1_4 + mid_data4[24:10];
					out_FCL1_5 = out_FCL1_5 + mid_data5[24:10];
					out_FCL1_6 = out_FCL1_6 + mid_data6[24:10];
					out_FCL1_7 = out_FCL1_7 + mid_data7[24:10];
					out_FCL1_8 = out_FCL1_8 + mid_data8[24:10];
					out_FCL1_9 = out_FCL1_9 + mid_data9[24:10];
					out_FCL1_10 = out_FCL1_10 + mid_data10[24:10];
					out_FCL1_11 = out_FCL1_11 + mid_data11[24:10];
					out_FCL1_12 = out_FCL1_12 + mid_data12[24:10];
					out_FCL1_13 = out_FCL1_13 + mid_data13[24:10];
					out_FCL1_14 = out_FCL1_14 + mid_data14[24:10];
					out_FCL1_15 = out_FCL1_15 + mid_data15[24:10];
					out_FCL1_16 = out_FCL1_16 + mid_data16[24:10];
					count = 23;
				end
				
				else if(count==25) begin
					//$display("out_FCL1_16 = %h", out_FCL1_16);
					if(line<30) begin
						out_FCL1_1 = out_FCL1_1 + mid_data1[24:10];
						out_FCL1_2 = out_FCL1_2 + mid_data2[24:10];
						out_FCL1_3 = out_FCL1_3 + mid_data3[24:10];
						out_FCL1_4 = out_FCL1_4 + mid_data4[24:10];
						out_FCL1_5 = out_FCL1_5 + mid_data5[24:10];
						out_FCL1_6 = out_FCL1_6 + mid_data6[24:10];
						out_FCL1_7 = out_FCL1_7 + mid_data7[24:10];
						out_FCL1_8 = out_FCL1_8 + mid_data8[24:10];
						out_FCL1_9 = out_FCL1_9 + mid_data9[24:10];
						out_FCL1_10 = out_FCL1_10 + mid_data10[24:10];
						out_FCL1_11 = out_FCL1_11 + mid_data11[24:10];
						out_FCL1_12 = out_FCL1_12 + mid_data12[24:10];
						out_FCL1_13 = out_FCL1_13 + mid_data13[24:10];
						out_FCL1_14 = out_FCL1_14 + mid_data14[24:10];
						out_FCL1_15 = out_FCL1_15 + mid_data15[24:10];
						out_FCL1_16 = out_FCL1_16 + mid_data16[24:10];
					end
					
					else begin
						out_FCL1_1 = (out_FCL1_1 + mid_data1[24:10] + bias1) > 16'h8000 ? 16'h0 : (out_FCL1_1 + mid_data1[24:10] + bias1);
						out_FCL1_2 = (out_FCL1_2 + mid_data2[24:10] + bias2) > 16'h8000 ? 16'h0 : (out_FCL1_2 + mid_data2[24:10] + bias2);
						out_FCL1_3 = (out_FCL1_3 + mid_data3[24:10] + bias3) > 16'h8000 ? 16'h0 : (out_FCL1_3 + mid_data3[24:10] + bias3);
						out_FCL1_4 = (out_FCL1_4 + mid_data4[24:10] + bias4) > 16'h8000 ? 16'h0 : (out_FCL1_4 + mid_data4[24:10] + bias4);
						out_FCL1_5 = (out_FCL1_5 + mid_data5[24:10] + bias5) > 16'h8000 ? 16'h0 : (out_FCL1_5 + mid_data5[24:10] + bias5);
						out_FCL1_6 = (out_FCL1_6 + mid_data6[24:10] + bias6) > 16'h8000 ? 16'h0 : (out_FCL1_6 + mid_data6[24:10] + bias6);
						out_FCL1_7 = (out_FCL1_7 + mid_data7[24:10] + bias7) > 16'h8000 ? 16'h0 : (out_FCL1_7 + mid_data7[24:10] + bias7);
						out_FCL1_8 = (out_FCL1_8 + mid_data8[24:10] + bias8) > 16'h8000 ? 16'h0 : (out_FCL1_8 + mid_data8[24:10] + bias8);
						out_FCL1_9 = (out_FCL1_9 + mid_data9[24:10] + bias9) > 16'h8000 ? 16'h0 : (out_FCL1_9 + mid_data9[24:10] + bias9);
						out_FCL1_10 = (out_FCL1_10 + mid_data10[24:10] + bias10) > 16'h8000 ? 16'h0 : (out_FCL1_10 + mid_data10[24:10] + bias10);
						out_FCL1_11 = (out_FCL1_11 + mid_data11[24:10] + bias11) > 16'h8000 ? 16'h0 : (out_FCL1_11 + mid_data11[24:10] + bias11);
						out_FCL1_12 = (out_FCL1_12 + mid_data12[24:10] + bias12) > 16'h8000 ? 16'h0 : (out_FCL1_12 + mid_data12[24:10] + bias12);
						out_FCL1_13 = (out_FCL1_13 + mid_data13[24:10] + bias13) > 16'h8000 ? 16'h0 : (out_FCL1_13 + mid_data13[24:10] + bias13);
						out_FCL1_14 = (out_FCL1_14 + mid_data14[24:10] + bias14) > 16'h8000 ? 16'h0 : (out_FCL1_14 + mid_data14[24:10] + bias14);
						out_FCL1_15 = (out_FCL1_15 + mid_data15[24:10] + bias15) > 16'h8000 ? 16'h0 : (out_FCL1_15 + mid_data15[24:10] + bias15);
						out_FCL1_16 = (out_FCL1_16 + mid_data16[24:10] + bias16) > 16'h8000 ? 16'h0 : (out_FCL1_16 + mid_data16[24:10] + bias16);
						//line = 1;
					end
					
					count = 0;
					line = line + 1;
					if(line>30) begin
						 line = 1;
						 //$display("out_FCL1_16 = %h", out_FCL1_16);
					end
				end
				
				else begin
					count = count + 1;
				end
			end
			
			else begin
				count = count + 1;
				if(count>25) begin
					count = 0;
					line = line + 1;
				end
			end
		end
	end
end


endmodule