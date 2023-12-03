`timescale 1ns/1ns
module add_tc_16_16_tb();
initial begin
	$dumpfile("../add_tc_16_16_tb.vcd");
	$dumpvars;
end

reg	[15:0] a,b;
initial begin
	a	<= {$random}%65536;
	b	<= {$random}%65536;
	#1
	a	<= {$random}%65536;
	b	<= {$random}%65536;
	#1
	a	<= {$random}%65536;
	b	<= {$random}%65536;
	#1
	a	<= {$random}%65536;
	b	<= {$random}%65536;
	#1
	$finish;
end

wire [16:0] sum;
add_tc_16_16 dut(
	.a		(a),
	.b		(b),
	.sum	(sum)
);

wire [16:0] bench = a + b; 

endmodule
