`timescale 1ns/10ps
module tb();

reg clk;
reg rst;
reg [223:0] input_data;
reg [223:0] pic_data [2799:0];
reg [63:0] redu_data [1:0];

wire [447:0] output_data;

integer file_id;
integer read_id;
integer i,j;

initial begin
	clk <= 0;
	forever #5 clk <= ~clk;
end

initial begin
	i <= 12'b0;
	j <= 12'b1;
	rst <= 1;
	#20 rst<= 0;
end

initial begin
	file_id = $fopen("train-images.idx3-ubyte", "rb");
	read_id = $fread(redu_data, file_id);
	read_id = $fread(pic_data, file_id);
	$fclose(file_id);
end

always @(posedge clk)
begin
	if(rst) begin
		input_data <= 224'b0;
	end
	
	else begin
		if(j%30 == 1) begin
			input_data <= 224'b0;
			j <= j+12'b1;
		end
		
		else if(j%30 == 0) begin
			input_data <= 224'b0;
			if(j == 12'd3000) $stop;
			j <= j+12'b1;
		end
		
		else begin
			input_data = pic_data[i];
			i = i+12'b1;
			j = j+12'b1;
		end	
	end
	
	//$display("input_data = %h", input_data);
	$display("output_data = %h",output_data);
	if(j%30 == 1) $display("\n");
	
end

Conv Conv_Inst(
	.clk(clk),
	.rst(rst),
	.input_data(input_data),
	.output_data(output_data)
);

endmodule




















/*reg clk;
reg rst;
reg [63:0]  redu_data [1:0];
reg [223:0] row_data [2799:0];

reg [223:0] pic_data_row1;
reg [223:0] pic_data_row2;
reg [223:0] pic_data_row3;
reg [223:0] pic_data_row4;
reg [223:0] pic_data_row5;
reg [223:0] pic_data_row6;
reg [223:0] pic_data_row7;
reg [223:0] pic_data_row8;
reg [223:0] pic_data_row9;
reg [223:0] pic_data_row10;
reg [223:0] pic_data_row11;
reg [223:0] pic_data_row12;
reg [223:0] pic_data_row13;
reg [223:0] pic_data_row14;
reg [223:0] pic_data_row15;
reg [223:0] pic_data_row16;
reg [223:0] pic_data_row17;
reg [223:0] pic_data_row18;
reg [223:0] pic_data_row19;
reg [223:0] pic_data_row20;
reg [223:0] pic_data_row21;
reg [223:0] pic_data_row22;
reg [223:0] pic_data_row23;
reg [223:0] pic_data_row24;
reg [223:0] pic_data_row25;
reg [223:0] pic_data_row26;
reg [223:0] pic_data_row27;
reg [223:0] pic_data_row28;

wire [415:0]out_data_row1;
wire [415:0]out_data_row2;
wire [415:0]out_data_row3;
wire [415:0]out_data_row4;
wire [415:0]out_data_row5;
wire [415:0]out_data_row6;
wire [415:0]out_data_row7;
wire [415:0]out_data_row8;
wire [415:0]out_data_row9;
wire [415:0]out_data_row10;
wire [415:0]out_data_row11;
wire [415:0]out_data_row12;
wire [415:0]out_data_row13;
wire [415:0]out_data_row14;
wire [415:0]out_data_row15;
wire [415:0]out_data_row16;
wire [415:0]out_data_row17;
wire [415:0]out_data_row18;
wire [415:0]out_data_row19;
wire [415:0]out_data_row20;
wire [415:0]out_data_row21;
wire [415:0]out_data_row22;
wire [415:0]out_data_row23;
wire [415:0]out_data_row24;
wire [415:0]out_data_row25;
wire [415:0]out_data_row26;

integer pic_id;
integer read_id;
//integer i,j,k;
integer i;

initial begin
	clk <= 0;
	forever #5 clk <= ~clk;
end

initial begin
	i <= 12'b0;
	rst <= 1;
	#10 rst <= 0;
end

initial begin
	pic_id  = $fopen("train-images.idx3-ubyte","rb"); 
	read_id = $fread(redu_data,pic_id);
	read_id = $fread(row_data,pic_id);
	$fclose(pic_id);
end

initial begin
	$monitor("out_data_row10 = %h",out_data_row10);
end

always @(posedge clk)
begin
	if(rst) begin
		pic_data_row1 = 224'b0;
		pic_data_row2 = 224'b0;
		pic_data_row3 = 224'b0;
		pic_data_row4 = 224'b0;
		pic_data_row5 = 224'b0;
		pic_data_row6 = 224'b0;
		pic_data_row7 = 224'b0;
		pic_data_row8 = 224'b0;
		pic_data_row9 = 224'b0;
		pic_data_row10 = 224'b0;
		pic_data_row11 = 224'b0;
		pic_data_row12 = 224'b0;
		pic_data_row13 = 224'b0;
		pic_data_row14 = 224'b0;
		pic_data_row15 = 224'b0;
		pic_data_row16 = 224'b0;
		pic_data_row17 = 224'b0;
		pic_data_row18 = 224'b0;
		pic_data_row19 = 224'b0;
		pic_data_row20 = 224'b0;
		pic_data_row21 = 224'b0;
		pic_data_row22 = 224'b0;
		pic_data_row23 = 224'b0;
		pic_data_row24 = 224'b0;
		pic_data_row25 = 224'b0;
		pic_data_row26 = 224'b0;
		pic_data_row27 = 224'b0;
		pic_data_row28 = 224'b0;
	end
	
	else begin
		#100;
		pic_data_row1 = row_data[i];
		i = i+12'd1;
		pic_data_row2 = row_data[i];
		i = i+12'd1;
		pic_data_row3 = row_data[i];
		i = i+12'd1;
		pic_data_row4 = row_data[i];
		i = i+12'd1;
		pic_data_row5 = row_data[i];
		i = i+12'd1;
		pic_data_row6 = row_data[i];
		i = i+12'd1;
		pic_data_row7 = row_data[i];
		i = i+12'd1;
		pic_data_row8 = row_data[i];
		i = i+12'd1;
		pic_data_row9 = row_data[i];
		i = i+12'd1;
		pic_data_row10 = row_data[i];
		i = i+12'd1;
		pic_data_row11 = row_data[i];
		i = i+12'd1;
		pic_data_row12 = row_data[i];
		i = i+12'd1;
		pic_data_row13 = row_data[i];
		i = i+12'd1;
		pic_data_row14 = row_data[i];
		i = i+12'd1;
		pic_data_row15 = row_data[i];
		i = i+12'd1;
		pic_data_row16 = row_data[i];
		i = i+12'd1;
		pic_data_row17 = row_data[i];
		i = i+12'd1;
		pic_data_row18 = row_data[i];
		i = i+12'd1;
		pic_data_row19 = row_data[i];
		i = i+12'd1;
		pic_data_row20 = row_data[i];
		i = i+12'd1;
		pic_data_row21 = row_data[i];
		i = i+12'd1;
		pic_data_row22 = row_data[i];
		i = i+12'd1;
		pic_data_row23 = row_data[i];
		i = i+12'd1;
		pic_data_row24 = row_data[i];
		i = i+12'd1;
		pic_data_row25 = row_data[i];
		i = i+12'd1;
		pic_data_row26 = row_data[i];
		i = i+12'd1;
		pic_data_row27 = row_data[i];
		i = i+12'd1;
		pic_data_row28 = row_data[i];
		i = i+12'd1;
		if(i>2799) begin
			$stop;
		end
	end
end

Conv Conv_Inst(
	.pic_data_row1(pic_data_row1),
	.pic_data_row2(pic_data_row2),
	.pic_data_row3(pic_data_row3),
	.pic_data_row4(pic_data_row4),
	.pic_data_row5(pic_data_row5),
	.pic_data_row6(pic_data_row6),
	.pic_data_row7(pic_data_row7),
	.pic_data_row8(pic_data_row8),
	.pic_data_row9(pic_data_row9),
	.pic_data_row10(pic_data_row10),
	.pic_data_row11(pic_data_row11),
	.pic_data_row12(pic_data_row12),
	.pic_data_row13(pic_data_row13),
	.pic_data_row14(pic_data_row14),
	.pic_data_row15(pic_data_row15),
	.pic_data_row16(pic_data_row16),
	.pic_data_row17(pic_data_row17),
	.pic_data_row18(pic_data_row18),
	.pic_data_row19(pic_data_row19),
	.pic_data_row20(pic_data_row20),
	.pic_data_row21(pic_data_row21),
	.pic_data_row22(pic_data_row22),
	.pic_data_row23(pic_data_row23),
	.pic_data_row24(pic_data_row24),
	.pic_data_row25(pic_data_row25),
	.pic_data_row26(pic_data_row26),
	.pic_data_row27(pic_data_row27),
	.pic_data_row28(pic_data_row28),
	
	.out_data_row1(out_data_row1),
	.out_data_row2(out_data_row2),
	.out_data_row3(out_data_row3),
	.out_data_row4(out_data_row4),
	.out_data_row5(out_data_row5),
	.out_data_row6(out_data_row6),
	.out_data_row7(out_data_row7),
	.out_data_row8(out_data_row8),
	.out_data_row9(out_data_row9),
	.out_data_row10(out_data_row10),
	.out_data_row11(out_data_row11),
	.out_data_row12(out_data_row12),
	.out_data_row13(out_data_row13),
	.out_data_row14(out_data_row14),
	.out_data_row15(out_data_row15),
	.out_data_row16(out_data_row16),
	.out_data_row17(out_data_row17),
	.out_data_row18(out_data_row18),
	.out_data_row19(out_data_row19),
	.out_data_row20(out_data_row20),
	.out_data_row21(out_data_row21),
	.out_data_row22(out_data_row22),
	.out_data_row23(out_data_row23),
	.out_data_row24(out_data_row24),
	.out_data_row25(out_data_row25),
	.out_data_row26(out_data_row26)
);


endmodule*/
