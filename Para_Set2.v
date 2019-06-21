//********************学校：山东科技大学*****************************//
//********************专业：电子信息科学与技术***********************//
//********************姓名：巩光众***********************************//
//********************指导教师：张小军*******************************//
//********************题目：CNN算法的FPGA加速器实现******************//
//********************日期：2019.06.01*******************************//
//********************未经允许，禁止转载*****************************//

//第二个卷积层参数
module Para_Set2(
	clk,
	rst,

	filt2,
	bias2
);

input clk;
input rst;

output reg [47:0]  filt2;
output reg [15:0]  bias2;

//第二个卷积层深度为4，共四个卷积核四个偏移量，输出四幅图像
reg [287:0] filt2_1;
reg [287:0] filt2_2;
reg [287:0] filt2_3;
reg [287:0] filt2_4;

reg [15:0] bias2_1;
reg [15:0] bias2_2;
reg [15:0] bias2_3;
reg [15:0] bias2_4;

integer count;

always @(posedge clk)
begin
	if(rst) begin
		count = 0;
		filt2_1[15:0] = 16'h6;
		filt2_2[15:0] = 16'h2;
		filt2_3[15:0] = 16'h22;
		filt2_4[15:0] = 16'h18;
		filt2_1[31:16] = 16'h36;
		filt2_2[31:16] = 16'h41;
		filt2_3[31:16] = 16'h10;
		filt2_4[31:16] = 16'h36;
		filt2_1[47:32] = 16'h18;
		filt2_2[47:32] = 16'h10;
		filt2_3[47:32] = 16'h19;
		filt2_4[47:32] = 16'h26;
		filt2_1[63:48] = 16'h39;
		filt2_2[63:48] = 16'h21;
		filt2_3[63:48] = 16'h32;
		filt2_4[63:48] = 16'h35;
		filt2_1[79:64] = 16'h48;
		filt2_2[79:64] = 16'h21;
		filt2_3[79:64] = 16'h44;
		filt2_4[79:64] = 16'h3;
		filt2_1[95:80] = 16'h36;
		filt2_2[95:80] = 16'h30;
		filt2_3[95:80] = 16'h39;
		filt2_4[95:80] = 16'h28;
		filt2_1[111:96] = 16'h10;
		filt2_2[111:96] = 16'h15;
		filt2_3[111:96] = 16'h35;
		filt2_4[111:96] = 16'h12;
		filt2_1[127:112] = 16'h9;
		filt2_2[127:112] = 16'h29;
		filt2_3[127:112] = 16'h29;
		filt2_4[127:112] = 16'h33;
		filt2_1[143:128] = 16'h16;
		filt2_2[143:128] = 16'h14;
		filt2_3[143:128] = 16'h29;
		filt2_4[143:128] = 16'h20;
		filt2_1[159:144] = 16'h36;
		filt2_2[159:144] = 16'h31;
		filt2_3[159:144] = 16'h34;
		filt2_4[159:144] = 16'h12;
		filt2_1[175:160] = 16'h29;
		filt2_2[175:160] = 16'h5;
		filt2_3[175:160] = 16'h41;
		filt2_4[175:160] = 16'h46;
		filt2_1[191:176] = 16'h48;
		filt2_2[191:176] = 16'h44;
		filt2_3[191:176] = 16'h48;
		filt2_4[191:176] = 16'h27;
		filt2_1[207:192] = 16'h22;
		filt2_2[207:192] = 16'h38;
		filt2_3[207:192] = 16'h30;
		filt2_4[207:192] = 16'h7;
		filt2_1[223:208] = 16'h43;
		filt2_2[223:208] = 16'h44;
		filt2_3[223:208] = 16'h46;
		filt2_4[223:208] = 16'h44;
		filt2_1[239:224] = 16'h18;
		filt2_2[239:224] = 16'h4;
		filt2_3[239:224] = 16'h0;
		filt2_4[239:224] = 16'h26;
		filt2_1[255:240] = 16'h39;
		filt2_2[255:240] = 16'h5;
		filt2_3[255:240] = 16'h15;
		filt2_4[255:240] = 16'h49;
		filt2_1[271:256] = 16'h16;
		filt2_2[271:256] = 16'h19;
		filt2_3[271:256] = 16'h30;
		filt2_4[271:256] = 16'h16;
		filt2_1[287:272] = 16'h26;
		filt2_2[287:272] = 16'h31;
		filt2_3[287:272] = 16'h36;
		filt2_4[287:272] = 16'h4;
		bias2_1 = 16'h36;
		bias2_2 = 16'h36;
		bias2_3 = 16'h36;
		bias2_4 = 16'h36;
	end

	else begin
		if(count==2) begin
			filt2 = filt2_1[47:0];
			bias2 = bias2_1;
			count = 3;
		end
		
		else if(count==3) begin
			filt2 = filt2_1[95:48];
			bias2 = bias2_1;
			count = 4;
		end
		
		else if(count==4) begin
			filt2 = filt2_1[143:96];
			bias2 = bias2_1;
			count = 5;
		end
		
		else if(count==5) begin
			filt2 = filt2_2[47:0];
			bias2 = bias2_2;
			count = 6;
		end
		
		else if(count==6) begin
			filt2 = filt2_2[95:48];
			bias2 = bias2_2;
			count = 7;
		end
		
		else if(count==7) begin
			filt2 = filt2_2[143:96];
			bias2 = bias2_2;
			count = 8;
		end
		
		else if(count==8) begin
			filt2 = filt2_3[47:0];
			bias2 = bias2_3;
			count = 9;
		end
		
		else if(count==9) begin
			filt2 = filt2_3[95:48];
			bias2 = bias2_3;
			count = 10;
		end
		
		else if(count==10) begin
			filt2 = filt2_3[143:96];
			bias2 = bias2_3;
			count = 11;
		end
		
		else if(count==11) begin
			filt2 = filt2_4[47:0];
			bias2 = bias2_4;
			count = 12;
		end
		
		else if(count==12) begin
			filt2 = filt2_4[95:48];
			bias2 = bias2_4;
			count = 13;
		end
		
		else if(count==13) begin
			filt2 = filt2_4[143:96];
			bias2 = bias2_4;
			count = 14;
		end
		
		else if(count==14) begin
			filt2 = filt2_1[191:144];
			bias2 = bias2_1;
			count = 15;
		end
		
		else if(count==15) begin
			filt2 = filt2_1[239:192];
			bias2 = bias2_1;
			count = 16;
		end
		
		else if(count==16) begin
			filt2 = filt2_1[287:240];
			bias2 = bias2_1;
			count = 17;
		end
		
		else if(count==17) begin
			filt2 = filt2_2[191:144];
			bias2 = bias2_2;
			count = 18;
		end
		
		else if(count==18) begin
			filt2 = filt2_2[239:192];
			bias2 = bias2_2;
			count = 19;
		end
		
		else if(count==19) begin
			filt2 = filt2_2[287:240];
			bias2 = bias2_2;
			count = 20;
		end
		
		else if(count==20) begin
			filt2 = filt2_3[191:144];
			bias2 = bias2_3;
			count = 21;
		end
		
		else if(count==21) begin
			filt2 = filt2_3[239:192];
			bias2 = bias2_3;
			count = 22;
		end
		
		else if(count==22) begin
			filt2 = filt2_3[287:240];
			bias2 = bias2_3;
			count = 23;
		end
		
		else if(count==23) begin
			filt2 = filt2_4[191:144];
			bias2 = bias2_4;
			count = 24;
		end
		
		else if(count==24) begin
			filt2 = filt2_4[239:192];
			bias2 = bias2_4;
			count = 25;
		end
		
		else if(count==25) begin
			filt2 = filt2_4[287:240];
			bias2 = bias2_4;
			count = 0;
		end
		
		else begin
			count = count + 1;
		end
		
	end
end


endmodule