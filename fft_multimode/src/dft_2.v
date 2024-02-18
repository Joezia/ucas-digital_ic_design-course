module dft_2(
	input			clk,
	input			rst_n,
	input			inv,
	input	[15:0]	x1_r_i,
	input	[15:0]	x1_i_i,
	input	[15:0]	x2_r_i,
	input	[15:0]	x2_i_i,
	input	[15:0]	w_r,
	input	[15:0]	w_i,

	output	[15:0]	x1_r_o,
	output	[15:0]	x1_i_o,
	output	[15:0]	x2_r_o,
	output	[15:0]	x2_i_o
);

wire [31:0] pro_re_re;
wire [31:0] pro_im_im;
wire [31:0] pro_re_im;
wire [31:0] pro_im_re;
/*
mul_tc_16_16 re_re(
	.a			(x2_r_i),
	.b			(w_r),
	.product	(pro_re_re)
);
mul_tc_16_16 im_im(
	.a			(x2_i_i),
	.b			(w_i),
	.product	(pro_im_im)
);
mul_tc_16_16 re_im(
	.a			(x2_r_i),
	.b			(w_i),
	.product	(pro_re_im)
);
mul_tc_16_16 im_re(
	.a			(x2_i_i),
	.b			(w_r),
	.product	(pro_im_re)
);
*/

assign pro_re_re = $signed(x2_r_i) * $signed(w_r);
assign pro_im_im = $signed(x2_i_i) * $signed(w_i);
assign pro_re_im = $signed(x2_r_i) * $signed(w_i);
assign pro_im_re = $signed(x2_i_i) * $signed(w_r);

wire [31:0] pro_re = pro_re_re - pro_im_im;
wire [31:0] pro_im = pro_re_im + pro_im_re;

wire [15:0] x1_r = x1_r_i + pro_re[29:14];
wire [15:0] x1_i = x1_i_i + pro_im[29:14];
wire [15:0] x2_r = x1_r_i - pro_re[29:14];
wire [15:0] x2_i = x1_i_i - pro_im[29:14];

assign x1_r_o = /*inv ? {x1_r[15],x1_r[15:1]} :*/ x1_r;
assign x1_i_o = /*inv ? {x1_i[15],x1_i[15:1]} :*/ x1_i;
assign x2_r_o = /*inv ? {x2_r[15],x2_r[15:1]} :*/ x2_r;
assign x2_i_o = /*inv ? {x2_i[15],x2_i[15:1]} :*/ x2_i;

endmodule
