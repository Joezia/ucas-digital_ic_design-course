`timescale 1ns/1ns
module mul_tc_16_16_tb();

initial begin
	$dumpfile("../mul_tc_16_16_tb.vcd");
	$dumpvars;
end

reg [15:0]	a,b;
wire [31:0]	product;
initial begin
	a	<= $random%65536;
	b	<= $random%65536; 
	#1
	a	<= $random%65536;
	b	<= $random%65536; 
	#1
	a	<= $random%65536;
	b	<= $random%65536; 
	#1
	a	<= $random%65536;
	b	<= $random%65536; 
	#1

	$finish;
end

mul_tc_16_16 dut(
	.a			(a),
	.b			(b),
	.product	(product)
);

wire [31:0] bench =  $signed(a)*$signed(b);

endmodule
