`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 07:16:07 PM
// Design Name: 
// Module Name: seq_detector
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


module seq_detector(
    input   clk,
    input   rst_n,
    input   din_vld,
    input   din,
    output  result
    );
    
    reg [5:0] seq_reg;
    always @(posedge clk)begin
        if(!rst_n)begin
            seq_reg <= 0;
        end
        else begin
            if(din_vld)begin
                seq_reg <= {seq_reg[4:0], din};
            end
        end
    end
    
    reg is_seq;
    always @(posedge clk)begin
        if(!rst_n)  is_seq <= 0;
        else        is_seq <= (!(seq_reg ^ 6'b111000)) | (!(seq_reg ^ 6'b101110));
    end
    assign result = is_seq;
    
endmodule
