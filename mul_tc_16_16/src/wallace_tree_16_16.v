module wallace_tree_16_16(
	input	[31:0]	pp_0,
	input	[31:0]	pp_1,
	input	[31:0]	pp_2,
	input	[31:0]	pp_3,
	input	[31:0]	pp_4,
	input	[31:0]	pp_5,
	input	[31:0]	pp_6,
	input	[31:0]	pp_7,

	output	[31:0]	product
);
	
	wire [31:0] s_00,s_01,s_10,s_11,s_20,s_30;
	wire [31:0] c_00,c_01,c_10,c_11,c_20,c_30;
	csa_32 csa_00(
		.x		(pp_0),
		.y		(pp_1),
		.z		(pp_2),
		.s		(s_00),
		.c		(c_00)
	);
	csa_32 csa_01(
		.x		(pp_3),
		.y		(pp_4),
		.z		(pp_5),
		.s		(s_01),
		.c		(c_01)
	);
	csa_32 csa_10(
		.x		(s_00),
		.y		(c_00),
		.z		(s_01),
		.s		(s_10),
		.c		(c_10)
	);
	csa_32 csa_11(
		.x		(c_01),
		.y		(pp_6),
		.z		(pp_7),
		.s		(s_11),
		.c		(c_11)
	);
	csa_32 csa_20(
		.x		(s_10),
		.y		(c_10),
		.z		(s_11),
		.s		(s_20),
		.c		(c_20)
	);
	csa_32 csa_30(
		.x		(s_20),
		.y		(c_20),
		.z		(c_11),
		.s		(s_30),
		.c		(c_30)
	);

	assign	product = s_30 + c_30;

endmodule
