`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2023 11:04:02 PM
// Design Name: 
// Module Name: vector_leading_1_detector
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


module vector_leading_1_detector(
    input   [31:0]  data_in,
    output  [5:0]   pos_out
    );
    
    wire [5:0] pos_out_tmp;
    
    assign pos_out_tmp[4] = (!(data_in[31:16])) ? 1'b1 : 1'b0;
    wire [15:0] data_1 = pos_out_tmp[4] ? data_in[15:0] : data_in[31:16];
    
    assign pos_out_tmp[3] = (!(data_1[15: 8])) ? 1'b1 : 1'b0;
    wire [7:0] data_2 = pos_out_tmp[3] ? data_1[7:0] : data_1[15:8];
    
    assign pos_out_tmp[2] = (!(data_2[7: 4])) ? 1'b1 : 1'b0;
    wire [3:0] data_3 = pos_out_tmp[2] ? data_2[3:0] : data_2[7: 4];
    
    assign pos_out_tmp[1] = (!(data_3[3 : 2])) ? 1'b1 : 1'b0;
    wire [1:0] data_4 = pos_out_tmp[1] ? data_3[1:0] : data_3[3:2];
    
    assign pos_out_tmp[0] = (!(data_4[1])) ? 1'b1 : 1'b0;
    wire data_5 = pos_out_tmp[0] ? data_4[0] : data_4[1];
    
    assign pos_out_tmp[5] = !data_5 ? 1'b1 : 1'b0; 
        
    assign pos_out = pos_out_tmp[5] ? 6'd32 : pos_out_tmp;

endmodule

