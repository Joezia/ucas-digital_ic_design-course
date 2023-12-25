`timescale 1ps/1ps
module testbench ();
    
    reg clk,rst_n,vld_in;
    reg [31:0] x;
    wire vld_out;
    wire [15:0] y;
	
	initial begin
	$dumpfile("../sqrt_u32_tb.vcd");
	$dumpvars;
	end

    initial begin
        clk <= 1'b0;
        rst_n <= 1'b0;
        vld_in <= 1'b0;
        x <= 0;
        #4
        rst_n <= 1'b1;
        vld_in <= 1'b1;
        x <= 32'h0000_0076;
		#2
		x <= 256;
        #2
        x <= 255;
        #2
        x <= 2147483648;
        #2
        x <= 4294967295;
		#2
		vld_in <= 1'b0;
		#10
		vld_in <= 1'b1;
		x	<= 1369;
		#2
		x	<= 1368;
		#2
		vld_in <= 1'b0;
		#40
		$finish;
    end

    always #1 clk <= ~clk;

    sqrt_u32 dut(
        .clk(clk),
        .rst_n(rst_n),
        .vld_in(vld_in),
        .x(x),
        .vld_out(vld_out),
        .y(y)
    );

endmodule
