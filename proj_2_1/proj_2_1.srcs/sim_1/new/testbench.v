`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 06:31:04 PM
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
    
    reg [31:0]  data_in_test;
    wire [5:0]  pos_out_test;
    
    initial begin
        data_in_test = 32'b00011000_10000000_00000000_00000000;
        #5
        data_in_test = 32'b00000000_11111111_00000000_00000000;
        #5
        data_in_test = 32'b00000000_00000000_00000000_00001010;   
        #5
        data_in_test = 32'b0;
        #5
        data_in_test = 32'b00000000_00000000_00010000_00000000;
    end
    
    vector_leading_1_detector dut(
        .data_in        (data_in_test),
        .pos_out        (pos_out_test)
    );
endmodule
