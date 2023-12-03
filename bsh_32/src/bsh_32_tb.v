`timescale 1ns/1ns
module bsh_32_tb();
	initial begin            
		$dumpfile("../bsh_32_tb.vcd"); 
		$dumpvars; 
	end

	reg	[31:0]	data_in;
	reg			dir;
	reg	[4:0]	sh;
	reg [31:0]	bench;

	initial begin
		data_in	<= {$random}%4294967296;
		dir		<= {$random}%2;
		sh		<= {$random}%32;
		#2

		data_in	<= {$random}%4294967296;
		dir		<= {$random}%2;
		sh		<= {$random}%32;
		#2

		data_in	<= {$random}%4294967296;
		dir		<= {$random}%2;
		sh		<= {$random}%32;
		#2
		$finish;
	end
	wire correct = (bench == data_out);

	wire [31:0]data_out;
	bsh_32 dut(
		.data_in	(data_in),
		.dir		(dir),
		.sh			(sh),
		.data_out	(data_out)	
	);

endmodule
