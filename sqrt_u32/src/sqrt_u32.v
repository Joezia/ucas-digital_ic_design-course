module partial_cal(
	input	[31:0]	x_i,
	input			valid_i,
	input	[15:0]	q_i,
	input	[16:0]	s_i,

	output	[31:0]	x_o,
	output			valid_o,
	output	[15:0]	q_o,
	output	[16:0]	s_o
);
	wire [17:0]	tmp = (q_i << 2) + 1;
	wire [16:0]	diff = s_i - tmp;
	
	assign x_o		= x_i << 2;
	assign valid_o	= valid_i;
	assign q_o		= (!(tmp > s_i)) ? {q_i[14:0] , 1'b1} : {q_i[14:0] , 1'b0};
	assign s_o		= (!(tmp > s_i)) ? {diff[14:0],x_i[29:28]} : {s_i[14:0],x_i[29:28]};
	
endmodule

// top module
module sqrt_u32(
	input			clk,
	input			rst_n,
	input			vld_in,
	input	[31:0]	x,
	output			vld_out,
	output	[15:0]	y
);

reg		[31:0]	x_reg	[15:0];
reg		[15:0]	valid_reg;
reg		[15:0]	q_reg	[15:0];
reg		[16:0]	s_reg	[15:0];
wire	[31:0]	x_o	[15:0];
wire	[15:0]	valid_o;
wire	[15:0]	q_o	[15:0];
wire	[16:0]	s_o	[15:0];
genvar i_gen;
generate 
	for(i_gen = 0; i_gen < 16; i_gen = i_gen + 1)begin
		if(i_gen == 0)begin
			always @(posedge clk)begin
				if(!rst_n)begin
					x_reg[0]		<= 0;
					valid_reg[0]	<= 0;
					q_reg[0]		<= 0;
					s_reg[0]		<= 0;
				end
				else begin
					x_reg[0]		<= x_o[0];
					valid_reg[0]	<= valid_o[0];
					q_reg[0]		<= q_o[0];
					s_reg[0]		<= s_o[0];
				end
			end 

			partial_cal pc_0(
				.x_i		(x),
				.valid_i	(vld_in),
				.q_i		(16'b0),
				.s_i		({15'b0,x[31:30]}),
				.x_o		(x_o[0]),
				.valid_o	(valid_o[0]),
				.q_o		(q_o[0]),
				.s_o		(s_o[0])	
			);
		
		end
		else begin
			always @(posedge clk)begin
				if(!rst_n)begin
					x_reg[i_gen]		<= 0;
					valid_reg[i_gen]	<= 0;
					q_reg[i_gen]		<= 0;
					s_reg[i_gen]		<= 0;
				end
				else begin
					x_reg[i_gen]		<= x_o[i_gen];
					valid_reg[i_gen]	<= valid_o[i_gen];
					q_reg[i_gen]		<= q_o[i_gen];
					s_reg[i_gen]		<= s_o[i_gen];
				end
			end 
			
			partial_cal pc_i(
				.x_i		(x_reg[i_gen - 1]),
				.valid_i	(valid_reg[i_gen - 1]),
				.q_i		(q_reg[i_gen - 1]),
				.s_i		(s_reg[i_gen - 1]),
				.x_o		(x_o[i_gen]),
				.valid_o	(valid_o[i_gen]),
				.q_o		(q_o[i_gen]),
				.s_o		(s_o[i_gen])	
			);
		end
	end
endgenerate
	
	assign vld_out  = valid_reg[15];
	assign y		= q_reg[15];

endmodule
