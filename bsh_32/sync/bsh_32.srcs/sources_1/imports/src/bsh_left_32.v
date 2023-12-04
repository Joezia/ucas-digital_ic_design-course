module bsh_left_32(
	input	[31:0]	data_in,
	input	[4:0]	sh,
	output	[31:0]	data_out
);

wire [31:0] data_4 = sh[4] ? {data_in[15:0],data_in[31:16]} : data_in;
wire [31:0] data_3 = sh[3] ? {data_4[23:0],data_4[31:24]}	: data_4;
wire [31:0] data_2 = sh[2] ? {data_3[27:0],data_3[31:28]}	: data_3;
wire [31:0] data_1 = sh[1] ? {data_2[29:0],data_2[31:30]}	: data_2;
wire [31:0] data_0 = sh[0] ? {data_1[30:0],data_1[31]}		: data_1;

assign data_out = data_0;

endmodule
