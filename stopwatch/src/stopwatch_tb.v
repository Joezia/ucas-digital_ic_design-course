`timescale 1ns/1ns
module stopwatch_tb();

initial begin            
    $dumpfile("../stopwatch_tb.vcd"); 
    $dumpvars; 
end

reg			start_stop = 0;
reg			clear	= 0;
reg			rst_n	= 0;
reg			clk		= 0;
always #5	clk		= ~clk;

wire	[3:0]	hr_h;
wire	[3:0]	hr_l;
wire	[3:0]	min_h;
wire	[3:0]	min_l;
wire	[3:0]	sec_h;
wire	[3:0]	sec_l;

initial begin
	#10		rst_n		<= 1'b1;
	#203	start_stop	<= 1'b1;
	#13		start_stop	<= 0;
	#3000
	#4		clear		<= 1'b1;
	#9		clear		<= 0;
	#20000
	#3		start_stop	<= 1'b1;
	#15		start_stop	<= 0;
	#3000
	#4		clear		<= 1'b1;
	#9		clear		<= 0;
	#100
	#3		start_stop	<= 1'b1;
	#15		start_stop	<= 0;
	#100000
	$finish;
end

stopwatch dut(
	.clk				(clk),
    .rst_n				(rst_n),
    .clear				(clear),
    .start_stop			(start_stop),
    .hr_h				(hr_h),
    .hr_l				(hr_l),
    .min_h				(min_h),
    .min_l				(min_l),
    .sec_h				(sec_h),
    .sec_l				(sec_l)
);

endmodule
