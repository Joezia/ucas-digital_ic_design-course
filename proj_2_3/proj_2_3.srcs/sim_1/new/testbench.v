`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 11:52:34 PM
// Design Name: 
// Module Name: testbench
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


module testbench(
    );
    reg [7:0]   bin_in;
    wire [9:0]  bcd_out;
    
    initial begin
        bin_in = 8'b10100101;
        #5
        bin_in = 8'b11110000;
        #5
        bin_in = 8'b01100011;
        #5
        bin_in = 8'b00010001;  
    end
    
    bin2bcd dut(
        .bin_in     (bin_in),
        .bcd_out    (bcd_out)
    );
    
endmodule
