//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

module CNN(
	refclk,
	rst_0,
	result
);

input  refclk;
input  rst_0;
output [7:0] result;

wire clk;
wire rst;

reg [8:0] addr;

wire [223:0] in_pic;
wire [223:0] pic_data;

wire [47:0] filt1;
wire [15:0] bias1;

wire [447:0] out_convl1;

wire [447:0] in_pool1_1;
wire [447:0] in_pool1_2;

wire [223:0] out_pool1_1;
wire [223:0] out_pool1_2;

wire [223:0] in_conv2_1;
wire [223:0] in_conv2_2;

wire [47:0] filt2;
wire [15:0] bias2;

wire [223:0] out_convl2;

wire [223:0] in_pool2_1;
wire [223:0] in_pool2_2;
wire [223:0] in_pool2_3;
wire [223:0] in_pool2_4;

wire [111:0] out_pool2_1;
wire [111:0] out_pool2_2;
wire [111:0] out_pool2_3;
wire [111:0] out_pool2_4;

wire [111:0] in_FCL1_1;
wire [111:0] in_FCL1_2;
wire [111:0] in_FCL1_3;
wire [111:0] in_FCL1_4;

wire [111:0] filtl1;
wire [111:0] filtl2;
wire [111:0] filtl3;
wire [111:0] filtl4;
wire [111:0] filtl5;
wire [111:0] filtl6;
wire [111:0] filtl7;
wire [111:0] filtl8;
wire [111:0] filtl9;
wire [111:0] filtl10;
wire [111:0] filtl11;
wire [111:0] filtl12;
wire [111:0] filtl13;
wire [111:0] filtl14;
wire [111:0] filtl15;
wire [111:0] filtl16;
wire [15:0]  biasl1;
wire [15:0]  biasl2;
wire [15:0]  biasl3;
wire [15:0]  biasl4;
wire [15:0]  biasl5;
wire [15:0]  biasl6;
wire [15:0]  biasl7;
wire [15:0]  biasl8;
wire [15:0]  biasl9;
wire [15:0]  biasl10;
wire [15:0]  biasl11;
wire [15:0]  biasl12;
wire [15:0]  biasl13;
wire [15:0]  biasl14;
wire [15:0]  biasl15;
wire [15:0]  biasl16;

wire [15:0] out_FCL1_1;
wire [15:0] out_FCL1_2;
wire [15:0] out_FCL1_3;
wire [15:0] out_FCL1_4;
wire [15:0] out_FCL1_5;
wire [15:0] out_FCL1_6;
wire [15:0] out_FCL1_7;
wire [15:0] out_FCL1_8;
wire [15:0] out_FCL1_9;
wire [15:0] out_FCL1_10;
wire [15:0] out_FCL1_11;
wire [15:0] out_FCL1_12;
wire [15:0] out_FCL1_13;
wire [15:0] out_FCL1_14;
wire [15:0] out_FCL1_15;
wire [15:0] out_FCL1_16;

wire [15:0] in_FCL2_1;
wire [15:0] in_FCL2_2;
wire [15:0] in_FCL2_3;
wire [15:0] in_FCL2_4;
wire [15:0] in_FCL2_5;
wire [15:0] in_FCL2_6;
wire [15:0] in_FCL2_7;
wire [15:0] in_FCL2_8;
wire [15:0] in_FCL2_9;
wire [15:0] in_FCL2_10;
wire [15:0] in_FCL2_11;
wire [15:0] in_FCL2_12;
wire [15:0] in_FCL2_13;
wire [15:0] in_FCL2_14;
wire [15:0] in_FCL2_15;
wire [15:0] in_FCL2_16;

wire [15:0] out_FCL2_1;
wire [15:0] out_FCL2_2;
wire [15:0] out_FCL2_3;
wire [15:0] out_FCL2_4;
wire [15:0] out_FCL2_5;
wire [15:0] out_FCL2_6;
wire [15:0] out_FCL2_7;
wire [15:0] out_FCL2_8;
wire [15:0] out_FCL2_9;
wire [15:0] out_FCL2_10;

wire [15:0] in_SoftMax1;
wire [15:0] in_SoftMax2;
wire [15:0] in_SoftMax3;
wire [15:0] in_SoftMax4;
wire [15:0] in_SoftMax5;
wire [15:0] in_SoftMax6;
wire [15:0] in_SoftMax7;
wire [15:0] in_SoftMax8;
wire [15:0] in_SoftMax9;
wire [15:0] in_SoftMax10;

integer count;

always @(posedge clk)
begin
	if(rst) begin
		count = 0;
		addr  = 0;
	end
	
	else begin
		count = count + 1;
		if(count>25) begin
			count = 0;
			addr = addr + 1;
			if(addr>299) begin
				addr = 299;
			end
		end
	end
end

clk clk_Inst(
	.refclk(refclk),   //  refclk.clk
	.rst(rst_0),      //   reset.reset
	.outclk_0(clk)  // outclk0.clk
);

rst_gen rst_gen_Inst(
	.clk(clk),
	.rst_0(rst_0),
	
	.rst(rst)
);

ROM ROM_Inst(
	.address(addr),
	.clock(clk),
	.rden(rst),
	.q(in_pic)
);

clk1 clk1_Inst(
	.clk(clk),
	.rst(rst),
	.in_pic(in_pic),
	.pic_data(pic_data)
);

Para_Set1 Para_Set1_Inst(
	.clk(clk),
	.rst(rst),
	.pic_data(pic_data),
	
	.filt1(filt1),
	.bias1(bias1)
);

ConvLay1 ConvLay1_Inst(
	.clk(clk),
	.rst(rst),
	.filt(filt1),
	.bias(bias1),
	.pic_data(pic_data),
	
	.out_convl1(out_convl1)
);

clk2 clk2_Inst(
	.clk(clk),
	.rst(rst),
	.out_convl1(out_convl1),

	.in_pool1_1(in_pool1_1),
	.in_pool1_2(in_pool1_2)
);

PoolLay1 PoolLay1_Inst(
	.clk(clk),
	.rst(rst),
	.in_pool1_1(in_pool1_1),
	.in_pool1_2(in_pool1_2),
	
	.out_pool1_1(out_pool1_1),
	.out_pool1_2(out_pool1_2)
);

clk3 clk3_Inst(
	.clk(clk),
	.rst(rst),
	.out_pool1_1(out_pool1_1),
	.out_pool1_2(out_pool1_2),

	.in_conv2_1(in_conv2_1),
	.in_conv2_2(in_conv2_2)
);

Para_Set2 Para_Set2_Inst(
	.clk(clk),
	.rst(rst),

	.filt2(filt2),
	.bias2(bias2)
);

ConvLay2 ConvLay2_Inst(
	.clk(clk),
	.rst(rst),
	.filt(filt1),
	.bias(bias1),
	.in_conv2_1(in_conv2_1),
	.in_conv2_2(in_conv2_2),
	
	.out_convl2(out_convl2)
);

clk4 clk4_Inst(
	.clk(clk),
	.rst(rst),
	.out_convl2(out_convl2),

	.in_pool2_1(in_pool2_1),
	.in_pool2_2(in_pool2_2),
	.in_pool2_3(in_pool2_3),
	.in_pool2_4(in_pool2_4)
);

PoolLay2 PoolLay2_Inst(
	.clk(clk),
	.rst(rst),
	.in_pool2_1(in_pool2_1),
	.in_pool2_2(in_pool2_2),
	.in_pool2_3(in_pool2_3),
	.in_pool2_4(in_pool2_4),
	
	.out_pool2_1(out_pool2_1),
	.out_pool2_2(out_pool2_2),
	.out_pool2_3(out_pool2_3),
	.out_pool2_4(out_pool2_4)
);

clk5 clk5_Inst(
	.clk(clk),
	.rst(rst),
	.out_pool2_1(out_pool2_1),
	.out_pool2_2(out_pool2_2),
	.out_pool2_3(out_pool2_3),
	.out_pool2_4(out_pool2_4),

	.in_FCL1_1(in_FCL1_1),
	.in_FCL1_2(in_FCL1_2),
	.in_FCL1_3(in_FCL1_3),
	.in_FCL1_4(in_FCL1_4)
);

FC_Para_Set1 FC_Para_Set1_Inst(
	.clk(clk),
	.rst(rst),
	
	.filt1(filtl1),
	.filt2(filtl2),
	.filt3(filtl3),
	.filt4(filtl4),
	.filt5(filtl5),
	.filt6(filtl6),
	.filt7(filtl7),
	.filt8(filtl8),
	.filt9(filtl9),
	.filt10(filtl10),
	.filt11(filtl11),
	.filt12(filtl12),
	.filt13(filtl13),
	.filt14(filtl14),
	.filt15(filtl15),
	.filt16(filtl16),
	
	.bias1(biasl1),
	.bias2(biasl2),
	.bias3(biasl3),
	.bias4(biasl4),
	.bias5(biasl5),
	.bias6(biasl6),
	.bias7(biasl7),
	.bias8(biasl8),
	.bias9(biasl9),
	.bias10(biasl10),
	.bias11(biasl11),
	.bias12(biasl12),
	.bias13(biasl13),
	.bias14(biasl14),
	.bias15(biasl15),
	.bias16(biasl16)
);

FCL1 FCL1_Inst(
	.clk(clk),
	.rst(rst),
	.filt1(filtl1),
	.filt2(filtl2),
	.filt3(filtl3),
	.filt4(filtl4),
	.filt5(filtl5),
	.filt6(filtl6),
	.filt7(filtl7),
	.filt8(filtl8),
	.filt9(filtl9),
	.filt10(filtl10),
	.filt11(filtl11),
	.filt12(filtl12),
	.filt13(filtl13),
	.filt14(filtl14),
	.filt15(filtl15),
	.filt16(filtl16),
	.bias1(biasl1),
	.bias2(biasl2),
	.bias3(biasl3),
	.bias4(biasl4),
	.bias5(biasl5),
	.bias6(biasl6),
	.bias7(biasl7),
	.bias8(biasl8),
	.bias9(biasl9),
	.bias10(biasl10),
	.bias11(biasl11),
	.bias12(biasl12),
	.bias13(biasl13),
	.bias14(biasl14),
	.bias15(biasl15),
	.bias16(biasl16),
	.in_FCL1_1(in_FCL1_1),
	.in_FCL1_2(in_FCL1_2),
	.in_FCL1_3(in_FCL1_3),
	.in_FCL1_4(in_FCL1_4),
	
	.out_FCL1_1(out_FCL1_1),
	.out_FCL1_2(out_FCL1_2),
	.out_FCL1_3(out_FCL1_3),
	.out_FCL1_4(out_FCL1_4),
	.out_FCL1_5(out_FCL1_5),
	.out_FCL1_6(out_FCL1_6),
	.out_FCL1_7(out_FCL1_7),
	.out_FCL1_8(out_FCL1_8),
	.out_FCL1_9(out_FCL1_9),
	.out_FCL1_10(out_FCL1_10),
	.out_FCL1_11(out_FCL1_11),
	.out_FCL1_12(out_FCL1_12),
	.out_FCL1_13(out_FCL1_13),
	.out_FCL1_14(out_FCL1_14),
	.out_FCL1_15(out_FCL1_15),
	.out_FCL1_16(out_FCL1_16)
);

clk6 clk6_Inst(
	.clk(clk),
	.rst(rst),
	.out_FCL1_1(out_FCL1_1),
	.out_FCL1_2(out_FCL1_2),
	.out_FCL1_3(out_FCL1_3),
	.out_FCL1_4(out_FCL1_4),
	.out_FCL1_5(out_FCL1_5),
	.out_FCL1_6(out_FCL1_6),
	.out_FCL1_7(out_FCL1_7),
	.out_FCL1_8(out_FCL1_8),
	.out_FCL1_9(out_FCL1_9),
	.out_FCL1_10(out_FCL1_10),
	.out_FCL1_11(out_FCL1_11),
	.out_FCL1_12(out_FCL1_12),
	.out_FCL1_13(out_FCL1_13),
	.out_FCL1_14(out_FCL1_14),
	.out_FCL1_15(out_FCL1_15),
	.out_FCL1_16(out_FCL1_16),
	
	.in_FCL2_1(in_FCL2_1),
	.in_FCL2_2(in_FCL2_2),
	.in_FCL2_3(in_FCL2_3),
	.in_FCL2_4(in_FCL2_4),
	.in_FCL2_5(in_FCL2_5),
	.in_FCL2_6(in_FCL2_6),
	.in_FCL2_7(in_FCL2_7),
	.in_FCL2_8(in_FCL2_8),
	.in_FCL2_9(in_FCL2_9),
	.in_FCL2_10(in_FCL2_10),
	.in_FCL2_11(in_FCL2_11),
	.in_FCL2_12(in_FCL2_12),
	.in_FCL2_13(in_FCL2_13),
	.in_FCL2_14(in_FCL2_14),
	.in_FCL2_15(in_FCL2_15),
	.in_FCL2_16(in_FCL2_16)
);

FCL2 FCL2_Inst(
	.clk(clk),
	.rst(rst),
	.in_FCL2_1(in_FCL2_1),
	.in_FCL2_2(in_FCL2_2),
	.in_FCL2_3(in_FCL2_3),
	.in_FCL2_4(in_FCL2_4),
	.in_FCL2_5(in_FCL2_5),
	.in_FCL2_6(in_FCL2_6),
	.in_FCL2_7(in_FCL2_7),
	.in_FCL2_8(in_FCL2_8),
	.in_FCL2_9(in_FCL2_9),
	.in_FCL2_10(in_FCL2_10),
	.in_FCL2_11(in_FCL2_11),
	.in_FCL2_12(in_FCL2_12),
	.in_FCL2_13(in_FCL2_13),
	.in_FCL2_14(in_FCL2_14),
	.in_FCL2_15(in_FCL2_15),
	.in_FCL2_16(in_FCL2_16),
	
	.out_FCL2_1(out_FCL2_1),
	.out_FCL2_2(out_FCL2_2),
	.out_FCL2_3(out_FCL2_3),
	.out_FCL2_4(out_FCL2_4),
	.out_FCL2_5(out_FCL2_5),
	.out_FCL2_6(out_FCL2_6),
	.out_FCL2_7(out_FCL2_7),
	.out_FCL2_8(out_FCL2_8),
	.out_FCL2_9(out_FCL2_9),
	.out_FCL2_10(out_FCL2_10)
);

clk7 clk7_Inst(
	.clk(clk),
	.rst(rst),
	.out_FCL2_1(out_FCL2_1),
	.out_FCL2_2(out_FCL2_2),
	.out_FCL2_3(out_FCL2_3),
	.out_FCL2_4(out_FCL2_4),
	.out_FCL2_5(out_FCL2_5),
	.out_FCL2_6(out_FCL2_6),
	.out_FCL2_7(out_FCL2_7),
	.out_FCL2_8(out_FCL2_8),
	.out_FCL2_9(out_FCL2_9),
	.out_FCL2_10(out_FCL2_10),
	
	.in_SoftMax1(in_SoftMax1),
	.in_SoftMax2(in_SoftMax2),
	.in_SoftMax3(in_SoftMax3),
	.in_SoftMax4(in_SoftMax4),
	.in_SoftMax5(in_SoftMax5),
	.in_SoftMax6(in_SoftMax6),
	.in_SoftMax7(in_SoftMax7),
	.in_SoftMax8(in_SoftMax8),
	.in_SoftMax9(in_SoftMax9),
	.in_SoftMax10(in_SoftMax10)
);

softmax softmax_Inst(
	.clk(clk),
	.rst(rst),
	.in_SoftMax1(in_SoftMax1),
	.in_SoftMax2(in_SoftMax2),
	.in_SoftMax3(in_SoftMax3),
	.in_SoftMax4(in_SoftMax4),
	.in_SoftMax5(in_SoftMax5),
	.in_SoftMax6(in_SoftMax6),
	.in_SoftMax7(in_SoftMax7),
	.in_SoftMax8(in_SoftMax8),
	.in_SoftMax9(in_SoftMax9),
	.in_SoftMax10(in_SoftMax10),
	
	.result(result)
);


endmodule