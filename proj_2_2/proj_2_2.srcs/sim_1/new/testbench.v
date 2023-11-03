`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 07:31:53 PM
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


module testbench();

reg [17:0] seq;
reg     clk;
reg     rst_n;
reg     din_vld;
wire    result;

initial begin
    clk     = 1;
    rst_n   = 0;
    din_vld = 0;
    seq = 18'b0011_1000_1101_1100_00; 
    #15
    rst_n   = 1'b1;
    din_vld = 1'b1;
end

always #5   clk = !clk;
always #10  seq = {seq[16:0], seq[17]};

wire din = seq[17];
seq_detector dut(
  .clk      (clk),
  .rst_n    (rst_n),
  .din_vld  (din_vld),
  .din      (din),
  .result   (result)  
);

endmodule
