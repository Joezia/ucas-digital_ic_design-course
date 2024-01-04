`timescale 1ps/1ps
module sort_32_u8_tb();
    reg clk,rst_n,vld_in;
    reg [7:0] din_0,din_1,din_2,din_3,din_4,din_5,din_6,din_7,din_8,din_9,din_10,din_11,din_12,din_13,din_14,din_15,din_16,din_17,din_18,din_19,din_20,din_21,din_22,din_23,din_24,din_25,din_26,din_27,din_28,din_29,din_30,din_31;    
    wire vld_out;
    wire [7:0] dout_0,dout_1,dout_2,dout_3,dout_4,dout_5,dout_6,dout_7,dout_8,dout_9,dout_10,dout_11,dout_12,dout_13,dout_14,dout_15,dout_16,dout_17,dout_18,dout_19,dout_20,dout_21,dout_22,dout_23,dout_24,dout_25,dout_26,dout_27,dout_28,dout_29,dout_30,dout_31;

	initial begin
        $dumpfile("../sort_32_u8_tb.vcd");
        $dumpvars;
    end

    always #2 clk <= ~clk;
    initial begin
        rst_n <= 1'b0;
		clk	<= 0;
        vld_in <= 1'b0;
        din_0  <= $random%32;
        din_1  <= $random%32;
        din_2  <= $random%32;
        din_3  <= $random%32;
        din_4  <= $random%32;
        din_5  <= $random%32;
        din_6  <= $random%32;
        din_7  <= $random%32;
        din_8  <= $random%32;
        din_9  <= $random%32;
        din_10 <= $random%32;
        din_11 <= $random%32;
        din_12 <= $random%32;
        din_13 <= $random%32;
        din_14 <= $random%32;
        din_15 <= $random%32;
        din_16 <= $random%32;
        din_17 <= $random%32;
        din_18 <= $random%32;
        din_19 <= $random%32;
        din_20 <= $random%32;
        din_21 <= $random%32;
        din_22 <= $random%32;
        din_23 <= $random%32;
        din_24 <= $random%32;
        din_25 <= $random%32;
        din_26 <= $random%32;
        din_27 <= $random%32;
        din_28 <= $random%32;
        din_29 <= $random%32;
        din_30 <= $random%32;
        din_31 <= $random%32;
        #4
        rst_n <= 1'b1;
        vld_in <= 1'b1;
        #6
        vld_in <= 1'b0;
		#900
		$finish;
    end


    sort_32_u8 u_sort(
        clk,
        rst_n,
        vld_in,
        din_0,din_1,din_2,din_3,din_4,din_5,din_6,din_7,din_8,din_9,din_10,din_11,din_12,din_13,din_14,din_15,din_16,din_17,din_18,din_19,din_20,din_21,din_22,din_23,din_24,din_25,din_26,din_27,din_28,din_29,din_30,din_31,
        vld_out,
        dout_0,dout_1,dout_2,dout_3,dout_4,dout_5,dout_6,dout_7,dout_8,dout_9,dout_10,dout_11,dout_12,dout_13,dout_14,dout_15,dout_16,dout_17,dout_18,dout_19,dout_20,dout_21,dout_22,dout_23,dout_24,dout_25,dout_26,dout_27,dout_28,dout_29,dout_30,dout_31
    );

endmodule
