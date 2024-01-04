`timescale 1ps/1ps
module sram_ctr_ahb_tb();
	parameter	[1:0]	IDLE	= 2'b00;
	parameter	[1:0]	BUSY	= 2'b01;
	parameter	[1:0]	NOSEQ	= 2'b10;
	parameter	[1:0]	SEQ		= 2'b11;

	reg			hclk;
    reg			hresetn;
    reg			hwrite;
    reg [1:0]	htrans;
    reg [2:0]	hsize;
    reg [31:0]	haddr;
    reg [2:0]	hburst;
    reg [31:0]	hwdata;
    wire		hready;
    wire [1:0]	hresp;
    wire [31:0]	hrdata;
    wire		sram_csn;
    wire		sram_wen;
    wire [11:0] sram_a;
    wire [31:0] sram_d;
    wire [31:0] sram_q;

	initial begin
		$dumpfile("../sram_ctr_ahb_tb.vcd");
		$dumpvars;
	end

    initial begin
        hclk	<= 1'b1;
        hresetn <= 1'b0;

		hwrite	<= 1'b1;
        haddr	<= 32'h0000_3ff0;
        htrans	<= NOSEQ;
		hburst	<= 3'b000;
        hsize	<= 3'b010;
        hwdata	<= 32'h00000000;
        #13
        hresetn	<= 1'b1;
		#7

		#1
		haddr	<= 32'h0000_3ffc;
		hwdata	<= 32'h1010_0101;
		#10

        hwdata	<= 32'h20200202;
		
		hwrite	<= 1'b0;
        haddr	<= 32'h0000_3ffc;
        htrans	<= NOSEQ;
		hburst	<= 3'b000;
        #10
		hwrite	<= 1'b0;
        haddr	<= 32'h0000_3ff0;
        htrans	<= NOSEQ;
		hburst	<= 3'b000;
		#10
		#10
		htrans	<= IDLE;
		#10

		hwrite	<= 1'b1;
        haddr	<= 32'h0000_0010;
        htrans	<= NOSEQ;
		hburst	<= 3'b001;
        hsize	<= 3'b010;
        hwdata	<= 32'h00000000;
		#10

		hwrite	<= 1'b1;
		haddr	<= 32'h0000_0014;
		htrans	<= SEQ;	
		hburst	<= 3'b001;
		hsize	<= 3'b010;
		hwdata	<= 32'h1111_1111;
		#10

		hwrite	<= 1'b1;
		haddr	<= 32'h0000_0018;
		htrans	<= SEQ;	
		hburst	<= 3'b001;
		hsize	<= 3'b010;
		hwdata	<= 32'h2222_2222;
		#10

		hwrite	<= 1'b1;
		haddr	<= 32'h0000_001c;
		htrans	<= SEQ;	
		hburst	<= 3'b001;
		hsize	<= 3'b010;
		hwdata	<= 32'h3333_3333;
		#10

		hwrite	<= 1'b0;
		haddr	<= 32'h0000_0010;
		htrans	<= NOSEQ;	
		hburst	<= 3'b001;
		hsize	<= 3'b010;
		hwdata	<= 32'h4444_4444;
		#10

		hwrite	<= 1'b0;
		haddr	<= 32'h0000_0014;
		htrans	<= SEQ;	
		hburst	<= 3'b001;
		hsize	<= 3'b010;
		hwdata	<= 32'h0;
		#10
		#10

		hwrite	<= 1'b0;
		haddr	<= 32'h0000_0018;
		htrans	<= SEQ;	
		hburst	<= 3'b001;
		hsize	<= 3'b010;
		#10

		hwrite	<= 1'b0;
		haddr	<= 32'h0000_001c;
		htrans	<= SEQ;	
		hburst	<= 3'b001;
		hsize	<= 3'b010;
		#10
		
		hwrite	<= 1'b0;
		haddr	<= 32'h0000_0000;
		htrans	<= IDLE;	
		hburst	<= 3'b000;
		hsize	<= 3'b010;
		#10

		#10
		$finish;
    end

    always #5 hclk <= ~hclk;

    sram_ctr_ahb u_sram_ctrl_ahb(
        .hclk		(hclk),
        .hresetn	(hresetn),
        .hwrite		(hwrite),
        .htrans		(htrans),
        .hsize		(hsize),
        .haddr		(haddr),
        .hburst		(hburst),
        .hwdata		(hwdata),
        .hready		(hready),
        .hresp		(hresp),
        .hrdata		(hrdata),
        .sram_csn	(sram_csn),
        .sram_wen	(sram_wen),
        .sram_a		(sram_a),
        .sram_d		(sram_d),
        .sram_q		(sram_q)
    );

	S011HD1P_BW sram(
		.Q		(sram_q),
		.CLK	(hclk),
		.CEN	(~sram_csn),
		.WEN	(~sram_wen),
		.BWEN	(0),
		.A		(sram_a),
		.D		(sram_d)
	);

endmodule
