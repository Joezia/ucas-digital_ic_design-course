module csa_32(
	input	[31:0]	x,
	input	[31:0]	y,
	input	[31:0]	z,
	output	[31:0]	s,
	output	[31:0]	c
);

assign c[0] = 0;
genvar i_gen;
generate
	for(i_gen = 0; i_gen < 32; i_gen = i_gen +1)begin
		if(i_gen == 31)
			csa_1 u_csa(
				.a		(x[i_gen]),
				.b		(y[i_gen]),
				.cin	(z[i_gen]),
				.s		(s[i_gen]),
				.cout	()
			);
		else
			csa_1 u_csa(
				.a		(x[i_gen]),
				.b		(y[i_gen]),
				.cin	(z[i_gen]),
				.s		(s[i_gen]),
				.cout	(c[i_gen+1])
			);
	end	
endgenerate

endmodule
