module Conv(
	clk,
	rst,
	input_data,
	output_data
);

input  clk;
input  rst;
input  [223:0] input_data;
output reg [447:0] output_data;

wire [239:0]input_data_plus;

reg [30:0] mid_data;

reg [447:0] out_mid_data1;
reg [447:0] out_mid_data2;
reg [447:0] out_mid_data3;

reg [15:0] filt_lin_1 [2:0];
reg [15:0] filt_lin_2 [2:0];
reg [15:0] filt_lin_3 [2:0];

integer line;

assign input_data_plus = {8'b0,input_data,8'b0};

always @(posedge clk)
begin
	if(rst) begin
		line <= 5'd1; 
		output_data <= 448'b0;
		out_mid_data1 <= 448'b0;
		out_mid_data2 <= 448'b0;
		out_mid_data3 <= 448'b0;
		filt_lin_1[0] <= 16'h66;
		filt_lin_1[1] <= 16'h66;
		filt_lin_1[2] <= 16'h66;
		filt_lin_2[0] <= 16'h66;
		filt_lin_2[1] <= 16'h66;
		filt_lin_2[2] <= 16'h66;
		filt_lin_3[0] <= 16'h66;
		filt_lin_3[1] <= 16'h66;
		filt_lin_3[2] <= 16'h66;
	end
end

generate
	genvar i;
	for(i=0;i<28;i=i+5'b1) begin: ggz
		always @(posedge clk)
		begin
			if(!rst) begin
					if(line == 5'd1) begin //padding = 2
						mid_data = filt_lin_1[0]*input_data_plus[i*8+7:i*8]+filt_lin_1[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_1[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data1[i*16+15:i*16] = out_mid_data1[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						if(i == 27) begin
							output_data = 448'b0;
					  	line = line+5'd1;
						end
					end
					
					else if(line == 5'd2) begin
						mid_data = filt_lin_1[0]*input_data_plus[i*8+7:i*8]+filt_lin_1[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_1[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data2[i*16+15:i*16] = out_mid_data2[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						mid_data = filt_lin_2[0]*input_data_plus[i*8+7:i*8]+filt_lin_2[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_2[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data1[i*16+15:i*16] = out_mid_data1[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						if(i == 27) begin
							output_data = 448'b0;
					  	line = line+5'd1;
						end
					end
					
					else if(line == 5'd29) begin
						mid_data = filt_lin_2[0]*input_data_plus[i*8+7:i*8]+filt_lin_2[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_2[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data1[i*16+15:i*16] = out_mid_data1[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						mid_data = filt_lin_3[0]*input_data_plus[i*8+7:i*8]+filt_lin_3[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_3[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data3[i*16+15:i*16] = out_mid_data3[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						if(i == 27) begin
							output_data = out_mid_data3;
					  	out_mid_data3 = 448'b0;
					  	line = line+5'd1;
						end
					end
					
					else if(line == 5'd30) begin //padding = 2
						mid_data = filt_lin_3[0]*input_data_plus[i*8+7:i*8]+filt_lin_3[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_3[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data1[i*16+15:i*16] = out_mid_data1[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						if(i == 27) begin
							output_data = out_mid_data1;
					  	out_mid_data1 = 448'b0;
					  	line = 5'd1;
						end
					end
					
					else if(line%3 == 0) begin
						mid_data = filt_lin_1[0]*input_data_plus[i*8+7:i*8]+filt_lin_1[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_1[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data3[i*16+15:i*16] = out_mid_data3[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						mid_data = filt_lin_2[0]*input_data_plus[i*8+7:i*8]+filt_lin_2[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_2[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data2[i*16+15:i*16] = out_mid_data2[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						mid_data = filt_lin_3[0]*input_data_plus[i*8+7:i*8]+filt_lin_3[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_3[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data1[i*16+15:i*16] = out_mid_data1[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						if(i == 27) begin
							output_data = out_mid_data1;
			 		  	out_mid_data1 = 448'b0;
					  	line = line+5'd1;
						end
					end
					
					else if(line%3 == 1) begin
						mid_data = filt_lin_1[0]*input_data_plus[i*8+7:i*8]+filt_lin_1[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_1[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data1[i*16+15:i*16] = out_mid_data1[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						mid_data = filt_lin_2[0]*input_data_plus[i*8+7:i*8]+filt_lin_2[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_2[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data3[i*16+15:i*16] = out_mid_data3[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						mid_data = filt_lin_3[0]*input_data_plus[i*8+7:i*8]+filt_lin_3[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_3[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data2[i*16+15:i*16] = out_mid_data2[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						if(i == 27) begin
							output_data = out_mid_data2;
					  	out_mid_data2 = 448'b0;
					  	line = line+5'd1;
						end
					end
					
					else begin
						mid_data = filt_lin_1[0]*input_data_plus[i*8+7:i*8]+filt_lin_1[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_1[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data2[i*16+15:i*16] = out_mid_data2[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						mid_data = filt_lin_2[0]*input_data_plus[i*8+7:i*8]+filt_lin_2[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_2[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data1[i*16+15:i*16] = out_mid_data1[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						mid_data = filt_lin_3[0]*input_data_plus[i*8+7:i*8]+filt_lin_3[1]*input_data_plus[i*8+15:i*8+8]+filt_lin_3[2]*input_data_plus[i*8+23:i*8+16];
						out_mid_data3[i*16+15:i*16] = out_mid_data3[i*16+15:i*16]+{1'b0,mid_data[24:10]};//relu+point_cacu
						if(i == 27) begin
							output_data = out_mid_data3;
					  	out_mid_data3 = 448'b0;
					  	line = line+5'd1;
						end
					end
					
			end
				
				
		end
	end

	
endgenerate


endmodule