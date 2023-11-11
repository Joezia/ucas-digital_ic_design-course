`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2023 10:28:34 AM
// Design Name: 
// Module Name: vld_test
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


module vld_test(
    input			sys_clk_p,
    input			sys_clk_n,
    input           rst,
    output reg [5:0]pos_out
    );

    wire clk;
    IBUFGDS CLK_U(
        .I(sys_clk_p),
        .IB(sys_clk_n),
        .O(clk)
    );
        
    reg [31:0]  data_in_test;
    wire [5:0]  pos_out_test;
    always @(posedge clk)begin
        if(rst) begin
            data_in_test <= 32'h07f3_5984;
            pos_out     <= 0;
        end
        else begin
            data_in_test <= {data_in_test[28:0],data_in_test[31:29]};
            pos_out     <= pos_out_test;
        end
    end
    
    vector_leading_1_detector dut(
        .data_in        (data_in_test),
        .pos_out        (pos_out_test)
    );
endmodule
