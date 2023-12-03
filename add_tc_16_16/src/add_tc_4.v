module add_tc_4(
	input	[3:0]	a,
	input	[3:0]	b,
	input			cin,
	output	[3:0]	s,
	output			cout,

	output			P_g,
	output			G_g
);

	wire [3:0] P = a ^ b;
	wire [3:0] G = a & b;
	
	wire [4:0] C;
	assign C[0]	=	cin;
	assign C[1]	=	G[0] | (P[0] & C[0]);
	assign C[2]	=	G[1] | (P[1] & (G[0] | (P[0] & C[0])));
	assign C[3]	=	G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & C[0])))));
	assign C[4]	=	G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & C[0])))))));	

	assign s	= P ^ C;
	assign cout	= C[4];

	assign P_g = &P;
	assign G_g = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
endmodule
