module sram #(
    parameter ADDR_DEPTH = 4,
    parameter DATA_WIDTH = 8,
    parameter DATA_DEPTH = 16
)(
	input					clk,
    input					rst_n,
    input					w_en,
    input					r_en,
    input [ADDR_DEPTH-1:0]	addr,
    input [DATA_WIDTH-1:0]	din,
    output reg [DATA_WIDTH-1:0] dout
);
    
    reg [DATA_WIDTH-1:0] mem [DATA_DEPTH-1:0];

    integer i;
	always @(posedge clk) begin
        if (!rst_n)begin
            for (i = 0; i < DATA_DEPTH; i=i+1) begin
                mem[i] <= 0;
            end
        end
        else if (w_en) begin
            mem[addr] <= din;
        end
    end

    always @(posedge clk) begin
        if (!rst_n) begin
            dout <= 0;
        end
        else if (r_en) begin
            dout <= mem[addr];
        end
    end

endmodule


