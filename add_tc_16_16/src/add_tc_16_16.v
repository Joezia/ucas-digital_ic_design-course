module add_tc_16_16(
	input	[15:0]	a,
	input	[15:0]	b,
	output	[16:0]	sum
);

	wire		C0 = 0;
	wire [3:0]	cout;
	wire [3:0]	P_g;
	wire [3:0]	G_g;
	add_tc_4 add4_0(
		.a		(a[3:0]),
		.b		(b[3:0]),
		.cin	(C0),
		.s		(sum[3:0]),
		.cout	(),
		.P_g	(P_g[0]),
		.G_g	(G_g[0])
	);
	add_tc_4 add4_1(
		.a		(a[7:4]),
		.b		(b[7:4]),
		.cin	(cout[0]),
		.s		(sum[7:4]),
		.cout	(),
		.P_g	(P_g[1]),
		.G_g	(G_g[1])
	);
	add_tc_4 add4_2(
		.a		(a[11:8]),
		.b		(b[11:8]),
		.cin	(cout[1]),
		.s		(sum[11:8]),
		.cout	(),
		.P_g	(P_g[2]),
		.G_g	(G_g[2])
	);
	add_tc_4 add4_3(
		.a		(a[15:12]),
		.b		(b[15:12]),
		.cin	(cout[2]),
		.s		(sum[15:12]),
		.cout	(),
		.P_g	(P_g[3]),
		.G_g	(G_g[3])
	);
	
	assign cout[0] = G_g[0] | (P_g[0] & C0);
	assign cout[1] = G_g[1] | (P_g[1] & cout[0]);
	assign cout[2] = G_g[2] | (P_g[2] & cout[1]);
	assign cout[3] = G_g[3] | (P_g[3] & cout[2]);

	assign sum[16] = cout[3];
endmodule
