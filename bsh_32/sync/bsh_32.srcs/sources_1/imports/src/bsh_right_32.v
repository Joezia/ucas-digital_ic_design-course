module bsh_right_32(
	input	[31:0]	data_in,
	input	[4:0]	sh,
	output	[31:0]	data_out
);

wire [31:0] data_4 = sh[4] ? {data_in[15:0],data_in[31:16]} : data_in;
wire [31:0] data_3 = sh[3] ? {data_4[7:0],data_4[31:8]}		: data_4;
wire [31:0] data_2 = sh[2] ? {data_3[3:0],data_3[31:4]}		: data_3;
wire [31:0] data_1 = sh[1] ? {data_2[1:0],data_2[31:2]}		: data_2;
wire [31:0] data_0 = sh[0] ? {data_1[0],data_1[31:1]}		: data_1;

assign data_out = data_0;

endmodule
