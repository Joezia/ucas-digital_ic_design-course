`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2023 03:57:26 PM
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
    output          result
    );
    
    wire clk;
    IBUFGDS CLK_U(
        .I(sys_clk_p),
        .IB(sys_clk_n),
        .O(clk)
    );
    
    reg [17:0] seq;
    always @(posedge clk)begin
        if(rst) seq <= 18'b0011_1000_1101_1100_00; 
        else begin
            seq <= {seq[16:0], seq[17]};
        end
    end
    
    seq_detector dut(
        .clk      (clk),
        .rst_n    (!rst),
        .din_vld  (1'b1),
        .din      (seq[17]),
        .result   (result)  
);
endmodule
