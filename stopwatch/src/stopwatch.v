`define DIV 7'd2

module stopwatch(
	input				clk,
	input				rst_n,
	input				clear,
	input				start_stop,
	output	reg	[3:0]	hr_h,
	output	reg	[3:0]	hr_l,
	output	reg	[3:0]	min_h,
	output	reg	[3:0]	min_l,
	output	reg	[3:0]	sec_h,
	output	reg	[3:0]	sec_l
);
	reg	[6:0]	clk_cnt;
	reg			clean_trig;
	reg			state;	// 记录表状态，1为运行，0为暂停
	
	always@(posedge clk or posedge clear)begin
		if(clear)	clean_trig <= 1'b1;
		else		clean_trig <= 0;
	end
	
	always@(negedge rst_n or posedge start_stop)begin
		if(!rst_n)	state <= 0;
		else		state <= ~state;
	end

	always@(posedge clk)begin
		if((!rst_n) || clean_trig)begin	
			clk_cnt <= 0;
		end
		else begin
			if(state)begin
				if(clk_cnt == `DIV)		clk_cnt	<= 0;
				else					clk_cnt <= clk_cnt + 1'b1;
			end
		end
	end
	
	wire clk_sec	= (clk_cnt == `DIV);
	wire sec_l_rst	= (sec_l == 4'd9);
	wire sec_h_rst	= (sec_l_rst) & (sec_h == 4'd5);
	wire min_l_rst  = (sec_h_rst) & (min_l == 4'd9);
	wire min_h_rst  = (min_l_rst) & (min_h == 4'd5);
	wire hr_l_rst	= (min_h_rst) & (hr_l == 4'd9);
	wire hr_h_rst	= (hr_l_rst)  & (hr_h == 4'd5);

	always@(posedge clk)begin
		if((!rst_n) || clean_trig)begin	
			hr_h	<= 0;
            hr_l	<= 0;
            min_h	<= 0;
            min_l	<= 0;
            sec_h	<= 0;
            sec_l	<= 0;
		end
		else begin
			if(state)begin
				if(clk_sec)begin
					if		(sec_l_rst)		sec_l	<=	0;
					else					sec_l	<=	sec_l + 1'b1;

					if		(sec_h_rst)		sec_h	<=	0;
					else if (sec_l_rst)		sec_h	<=	sec_h + 1'b1;

					if		(min_l_rst)		min_l	<=	0;
					else if (sec_h_rst)		min_l	<=	min_l + 1'b1;

					if		(min_h_rst)		min_h	<=	0;
					else if (min_l_rst)		min_h	<=	min_h + 1'b1;

					if		(hr_l_rst)		hr_l	<=	0;
					else if (min_h_rst)		hr_l	<= hr_l + 1'b1;

					if		(hr_h_rst)		hr_h	<=	0;
					else if (hr_l_rst)		hr_h	<=	hr_h + 1'b1;
				end
			end
		end
	end

endmodule
