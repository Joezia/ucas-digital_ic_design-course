`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2023 04:28:37 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input			sys_clk_p,
    input			sys_clk_n,
    input           rst,
    output reg [9:0]   out
    );
    wire clk;
    IBUFGDS CLK_U(
        .I(sys_clk_p),
        .IB(sys_clk_n),
        .O(clk)
    );
    
    reg [7:0] bin_in;
    wire [9:0]bcd_out;
    always @(posedge clk)begin
        if(rst) begin
            bin_in <= 8'b1001_0100;
            out <= 0;
        end
        else begin
            bin_in <= {bin_in[6:0],bin_in[7]};
            out <= bcd_out;
        end
    end
    
    bin2bcd dut(
        .bin_in     (bin_in),
        .bcd_out    (bcd_out)
    );
endmodule
