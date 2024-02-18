module mul_tc_16_16(
	input	[15:0]	a,
	input	[15:0]	b,
	output	[31:0]	product
);

wire	[31:0]	pp[7:0];
genvar i_gen;
generate 
	for(i_gen = 0; i_gen < 8; i_gen = i_gen + 1)begin
		if(i_gen == 0)
			booth_g4_pp_gen_16 pp(
				.a			(a),
				.enc		({b[1:0],1'b0}),
				.pp_16_16	(pp[i_gen])
			);	
		else
			booth_g4_pp_gen_16 pp(
				.a			(a),
				.enc		(b[i_gen*2+1 : i_gen*2-1]),
				.pp_16_16	(pp[i_gen])
			);	
	end
endgenerate

wallace_tree_16_16 u_wallace_tree_adder(
	.pp_0		(pp[0]),
	.pp_1		(pp[1] << 2),
	.pp_2		(pp[2] << 4),
	.pp_3		(pp[3] << 6),
	.pp_4		(pp[4] << 8),
	.pp_5		(pp[5] << 10),
	.pp_6		(pp[6] << 12),
	.pp_7		(pp[7] << 14),
	.product	(product)
);

endmodule
