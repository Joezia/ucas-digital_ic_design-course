module S011HD1P_BW(
    Q, CLK, CEN, WEN, BWEN, A, D
);
parameter Bits = 32;
parameter Word_Depth = 4096;
parameter Add_Width = 12;
parameter Wen_Width = 32;

output reg [Bits-1:0] Q;
input                 CLK;
input                 CEN;
input                 WEN;
input [Wen_Width-1:0] BWEN;
input [Add_Width-1:0] A;		//address
input [Bits-1:0]      D;		//data_write input 

wire					cen  = ~CEN;
wire					wen  = ~WEN;
wire [Wen_Width-1:0]	bwen = ~BWEN;

reg [Bits-1:0] ram [0:Word_Depth-1];

always @(posedge CLK) begin
    if(cen && wen) begin
        ram[A]	<= (D & bwen) | (ram[A] & ~bwen);
    end
		Q <= cen && !wen ? ram[A] : Q;
end

endmodule
