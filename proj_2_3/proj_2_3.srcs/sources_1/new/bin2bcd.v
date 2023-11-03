`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 08:18:34 PM
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd(
    input   [7:0]   bin_in,
    output  [9:0]   bcd_out
    );
	reg [3:0] ones;
	reg [3:0] tens;
	reg [1:0] hundreds;
	integer i;
	 
	always @(*)begin
		ones 		= 4'd0;
		tens 		= 4'd0;
		hundreds 	= 2'd0;
		
		for(i=7; i>=0; i=i-1)begin
			if (ones >= 4'b101) 		ones = ones + 4'd3;
			if (tens >= 4'b101) 		tens = tens + 4'd3;
	
			hundreds = {hundreds[0],tens[3]};
			tens	 = {tens[2:0],ones[3]};
			ones	 = {ones[2:0],bin_in[i]};
		end
	end	
	
	assign bcd_out = {hundreds, tens, ones};

endmodule
