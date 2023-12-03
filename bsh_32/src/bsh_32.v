module bsh_32(
	input	[31:0]	data_in,
	input			dir,			// 0左1右
	input	[4:0]	sh,
	output	[31:0]	data_out
);
	wire [31:0] data_out_l;
	bsh_left_32	bsh_l(
		.data_in	(data_in),
		.sh			(sh),
		.data_out	(data_out_l)	
	);

	wire [31:0] data_out_r;
	bsh_right_32 bsh_r(
		.data_in	(data_in),
		.sh			(sh),
		.data_out	(data_out_r)	
	);

	assign data_out = dir ? data_out_r : data_out_l;

endmodule
