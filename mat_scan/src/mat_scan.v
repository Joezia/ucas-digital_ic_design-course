module mat_scan(
	input				clk,
	input				rst_n,
	input				vld_in,
	input		[9:0]	din,
	output	reg			vld_out,
	output	reg [9:0]	dout
);
	reg [2:0]	state;
	parameter [2:0]	IDLE	= 3'b000;
	parameter [2:0]	DATA_IN	= 3'b001;
	parameter [2:0]	DATA_OUT= 3'b010;
	parameter [2:0]	WAIT	= 3'b011;

	reg	[5:0]	addr;
	reg			r_en;
	reg [5:0]	cnt;
	wire [9:0]	d_o;

	always@(posedge clk)begin
		if(!rst_n)begin
			state	<= 0;
			addr	<= 0;
			r_en	<= 0;
			cnt		<= 0;
			vld_out	<= 0;
			dout	<= 0;
		end
		else begin
			case(state)
				IDLE:begin
					if(vld_in)begin
						state	<= DATA_IN;
						addr	<= 1;
						cnt		<= 6'd63; 
					end
					else begin	
						addr		<= 0;
						vld_out		<= 0;
						dout		<= 0;
					end
				end
				DATA_IN:begin
					if(cnt == 0)begin
						state	<= WAIT;
						r_en	<= 1'b1;
						addr	<= 0;
						cnt		<= 6'd63;
					end
					else begin
						addr	<= addr + 6'd1;
						cnt		<= cnt - 6'd1;
					end
				end
				WAIT:begin
					state	<= DATA_OUT;
					addr	<= addr + 1;
				end
				DATA_OUT:begin
					if(cnt == 0)begin
						state	<= IDLE;
						addr	<= 0;
						r_en	<= 0;
						vld_out	<= 1'b1;
						dout	<= d_o;
					end
					else begin
						vld_out	<= 1'b1;
						dout	<= d_o;
						cnt		<= cnt - 6'd1;
						case(addr)
							6'b00_0000: addr <= 6'b00_0001;
                			6'b00_0001: addr <= 6'b00_1000;
                			6'b00_1000: addr <= 6'b01_0000;
                			6'b01_0000: addr <= 6'b00_1001;
                			6'b00_1001: addr <= 6'b00_0010;
                			6'b00_0010: addr <= 6'b00_0011;
                			6'b00_0011: addr <= 6'b00_1010;
                			6'b00_1010: addr <= 6'b01_0001;
                			6'b01_0001: addr <= 6'b01_1000;
                			6'b01_1000: addr <= 6'b10_0000;
                			6'b10_0000: addr <= 6'b01_1001;
                			6'b01_1001: addr <= 6'b01_0010;
                			6'b01_0010: addr <= 6'b00_1011;
                			6'b00_1011: addr <= 6'b00_0100;
                			6'b00_0100: addr <= 6'b00_0101;
                			6'b00_0101: addr <= 6'b00_1100;
                			6'b00_1100: addr <= 6'b01_0011;
                			6'b01_0011: addr <= 6'b01_1010;
                			6'b01_1010: addr <= 6'b10_0001;
                			6'b10_0001: addr <= 6'b10_1000;
                			6'b10_1000: addr <= 6'b11_0000;
                			6'b11_0000: addr <= 6'b10_1001;
                			6'b10_1001: addr <= 6'b10_0010;
                			6'b10_0010: addr <= 6'b01_1011;
                			6'b01_1011: addr <= 6'b01_0100;
                			6'b01_0100: addr <= 6'b00_1101;
                			6'b00_1101: addr <= 6'b00_0110;
                			6'b00_0110: addr <= 6'b00_0111;
                			6'b00_0111: addr <= 6'b00_1110;
                			6'b00_1110: addr <= 6'b01_0101;
                			6'b01_0101: addr <= 6'b01_1100;
                			6'b01_1100: addr <= 6'b10_0011;
                			6'b10_0011: addr <= 6'b10_1010;
                			6'b10_1010: addr <= 6'b11_0001;
                			6'b11_0001: addr <= 6'b11_1000;
                			6'b11_1000: addr <= 6'b11_1001;
                			6'b11_1001: addr <= 6'b11_0010;
                			6'b11_0010: addr <= 6'b10_1011;
                			6'b10_1011: addr <= 6'b10_0100;
                			6'b10_0100: addr <= 6'b01_1101;
                			6'b01_1101: addr <= 6'b01_0110;
                			6'b01_0110: addr <= 6'b00_1111;
                			6'b00_1111: addr <= 6'b01_0111;
                			6'b01_0111: addr <= 6'b01_1110;
                			6'b01_1110: addr <= 6'b10_0101;
                			6'b10_0101: addr <= 6'b10_1100;
                			6'b10_1100: addr <= 6'b11_0011;
                			6'b11_0011: addr <= 6'b11_1010;
                			6'b11_1010: addr <= 6'b11_1011;
                			6'b11_1011: addr <= 6'b11_0100;
                			6'b11_0100: addr <= 6'b10_1101;
                			6'b10_1101: addr <= 6'b10_0110;
                			6'b10_0110: addr <= 6'b01_1111;
                			6'b01_1111: addr <= 6'b10_0111;
                			6'b10_0111: addr <= 6'b10_1110;
                			6'b10_1110: addr <= 6'b11_0101;
                			6'b11_0101: addr <= 6'b11_1100;
                			6'b11_1100: addr <= 6'b11_1101;
                			6'b11_1101: addr <= 6'b11_0110;
                			6'b11_0110: addr <= 6'b10_1111;
                			6'b10_1111: addr <= 6'b11_0111;
                			6'b11_0111: addr <= 6'b11_1110;
                			6'b11_1110: addr <= 6'b11_1111;
							6'b11_1111: addr <= 6'b00_0000;
							default: ;
						endcase
					end
				end
				default: ;
			endcase
		end
	end

	sram #(
		.ADDR_DEPTH(6),
        .DATA_WIDTH(10),
        .DATA_DEPTH(64)	
	)sram(
		.clk		(clk),
        .rst_n		(rst_n),
        .w_en		(vld_in),
        .r_en		(r_en),
        .addr		(addr),
        .din		(din),
        .dout		(d_o)
	);
endmodule
