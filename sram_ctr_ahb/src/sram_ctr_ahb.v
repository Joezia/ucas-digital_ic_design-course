module sram_ctr_ahb(
    input				hclk,
    input				hresetn,
    input				hwrite,		//0读 1写
    input	[1:0]		htrans,
    input	[2:0]		hsize,		//数据位宽 8,16,32(010)
    input	[31:0]		haddr,
    input	[2:0]		hburst,
    input	[31:0]		hwdata,
    output				hready,
    output	[1:0]		hresp,
    output	[31:0]		hrdata,
	
    output				sram_csn,
    output				sram_wen,
    output	[11:0]		sram_a,
    output	[31:0]		sram_d,
    input	[31:0]		sram_q
);

	reg [3:0]	state;
	parameter	[3:0]	IDLE	= 4'b0000;
	parameter	[3:0]	REG_W	= 4'b0001;
	parameter	[3:0]	RAW		= 4'b0010;
	parameter	[3:0]	BURST_W	= 4'b0010;
	wire state_idle		= state == IDLE;
	wire state_reg_w	= state == REG_W;

	wire trans_idle		= htrans == 2'b00;
	wire trans_noseq	= htrans == 2'b10;
	wire trans_busy		= htrans == 2'b01;

	wire burst_incr		= hburst == 3'b001;
	wire burst_single	= hburst == 3'b000;

	reg			sram_ready;
	reg	[31:0]	addr_reg;
	reg			wen_reg;

	always@(posedge hclk)begin
		if(!hresetn)begin
			state		<= IDLE;
			sram_ready	<= 1'b1;
			addr_reg	<= 0;
			wen_reg		<= 0;
		end
		else begin
			case(state)
				IDLE: begin
					if(trans_noseq && hwrite)begin
						state		<= REG_W;
						wen_reg		<= 1'b1;
						addr_reg	<= haddr;
						sram_ready	<= 1'b1;
					end	
					else begin	
						sram_ready	<= 1'b1; 
					end
				end
				REG_W: begin
					if(trans_idle)begin
						state		<= IDLE;
					end
					else if(trans_busy)begin
						wen_reg		<= 0;
					end
					else if(hwrite)begin
						state		<= REG_W;
						wen_reg		<= 1'b1;
						addr_reg	<= haddr;
						sram_ready	<= 1'b1;
					end
					else if(!hwrite)begin
						state		<= RAW;
						wen_reg		<= 0;
						addr_reg	<= haddr;
						sram_ready	<= 0;
					end
				end
				RAW: begin
						state		<= IDLE;	
						addr_reg	<= haddr;
						sram_ready	<= 1'b1;
				end
				default: ;
			endcase
		end
	end

	assign	sram_csn	=	1'b1;
	assign	sram_wen	=	state_reg_w ? wen_reg : 0;
	assign	sram_a		=	state_idle ? haddr[13:2] : addr_reg[13:2];
	assign	sram_d		=	hwdata;
		
	assign	hready		= sram_ready;
	assign	hrdata		= sram_q;
	assign	hresp		= 0; 

endmodule
