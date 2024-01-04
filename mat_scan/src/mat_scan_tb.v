`timescale 1ps/1ps
module mat_scan_tb();
    reg			clk, rst_n, vld_in;
    reg [9:0]	din;
    wire		vld_out;
    wire [9:0] dout;

	reg	[6:0]	cnt;

	initial begin        
        $dumpfile("../mat_scan_tb.vcd");
        $dumpvars;           
    end      
    initial begin
        clk		<= 0;
        rst_n	<= 0;
        din		<= 0;
        vld_in	<= 0;
		cnt		<= 7'd64;
        #3
        rst_n	<= 1'b1;
		#300
		$finish;
    end

    always #1 clk <= ~clk;

    always @(posedge clk) begin
		if(rst_n)begin
			if (cnt == 0)begin
				vld_in	<= 0;
			end
			else begin
				vld_in	<= 1'b1;
				din		<= din + 1'b1;
				cnt		<= cnt - 6'd1;
        	end
		end
    end

    mat_scan u_mat_scan(
        .clk		(clk),
        .rst_n		(rst_n),
        .vld_in		(vld_in),
        .din		(din),
        .vld_out	(vld_out),
        .dout		(dout)
    );

endmodule
