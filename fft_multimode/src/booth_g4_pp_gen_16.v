module booth_g4_pp_gen_16(
	input	[15:0]	a,
	input	[2:0]	enc,
	output	[31:0]	pp_16_16
);	
	
	wire [31:0] a_pos	= {{16{a[15]}}, a};
	wire [31:0] a_neg	= ~a_pos + 1;
	wire [31:0]	a_pos_2	= a_pos << 1;
	wire [31:0] a_neg_2	= a_neg << 1;

	assign pp_16_16 =	{32{enc == 3'b000}} & 0			|
						{32{enc == 3'b001}} & a_pos		|
						{32{enc == 3'b010}} & a_pos		|
						{32{enc == 3'b011}} & a_pos_2	|
						{32{enc == 3'b100}} & a_neg_2	|
						{32{enc == 3'b101}} & a_neg		|
						{32{enc == 3'b110}} & a_neg		|
						{32{enc == 3'b111}} & 0			;

endmodule
