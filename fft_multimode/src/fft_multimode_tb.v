`timescale 1ns/1ns
module fft_multimode_tb();

initial begin
	$dumpfile("../fft_multimode_tb.vcd");
	$dumpvars;
end

    reg			clk;
    reg			rst_n;
    reg			inv;
    reg			valid_in;
    reg			sop_in;
    reg [15:0]	x_re;
    reg [15:0]	x_im;
    reg [1:0]	np;
    wire		valid_out;
    wire		sop_out;
    wire [15:0] y_re;
    wire [15:0] y_im;

    parameter N			= 512;
	parameter INV		= 0;

    parameter period	= 2;
    always #(period/2) clk = ~clk;

    reg [15:0] mem_re[0: N -1];
    reg [15:0] mem_im[0: N -1];
    fft_multimode fft_multimode_tb(
        .clk		(clk),
        .rst_n		(rst_n),
        .inv		(inv),
        .np			(np),
        .valid_in	(valid_in),
        .sop_in		(sop_in),
        .x_re		(x_re),
        .x_im		(x_im),
        .valid_out	(valid_out),
        .sop_out	(sop_out),
        .y_re		(y_re),
        .y_im		(y_im)
    );

    integer fdyre,fdyim;
    integer cnt;
    //读入数据
    initial begin
        clk			= 0;
        rst_n		= 0;
        sop_in		= 0;
        valid_in	= 0;
        inv			= INV;
        
		cnt			= 0;
        case(N)
			32'd64:  np = 2'b00;
			32'd128: np = 2'b01;
			32'd256: np = 2'b10;
			32'd512: np = 2'b11;
        endcase
        $readmemh("/home/zza/Documents/ucas-digital_ic_design-course/fft_multimode/sim/x_re64.txt",mem_re);
        $readmemh("/home/zza/Documents/ucas-digital_ic_design-course/fft_multimode/sim/x_im64.txt",mem_im);
        #(period);
        #(period);

        rst_n = 1;
        #(period);

        valid_in = 1;
        while(cnt < N)begin
			sop_in	= cnt ? 0 : 1;
            x_re	= mem_re[cnt];
            x_im	= mem_im[cnt];
            cnt		= cnt + 1;
            #(period);
        end

		cnt			= 0;
        valid_in	= 0;

        fdyre = $fopen("/home/zza/Documents/ucas-digital_ic_design-course/fft_multimode/sim/y_re_fft64.txt","wb");
        fdyim = $fopen("/home/zza/Documents/ucas-digital_ic_design-course/fft_multimode/sim/y_im_fft64.txt","wb");
        while(cnt<N)begin
            if(valid_out == 1)begin
                $fwrite(fdyre,"%04x\n",y_re);
                $fwrite(fdyim,"%04x\n",y_im);
                cnt = cnt + 1;
            end
			#(period);
        end
		$fclose(fdyre);
		$fclose(fdyim);

		#(period);
// ********************************
//
		$readmemh("/home/zza/Documents/ucas-digital_ic_design-course/fft_multimode/sim/y_re_fft64.txt",mem_re);
        $readmemh("/home/zza/Documents/ucas-digital_ic_design-course/fft_multimode/sim/y_im_fft64.txt",mem_im);
        #(period);
        #(period);

        rst_n = 1;
		cnt = 0;
        #(period);

		inv		= ~INV;
        valid_in = 1;
        while(cnt < N)begin
			sop_in	= cnt ? 0 : 1;
            x_re	= mem_re[cnt];
            x_im	= mem_im[cnt];
            cnt		= cnt + 1;
            #(period);
        end

		cnt			= 0;
        valid_in	= 0;

        fdyre = $fopen("/home/zza/Documents/ucas-digital_ic_design-course/fft_multimode/sim/y_re_ifft64.txt","wb");
        fdyim = $fopen("/home/zza/Documents/ucas-digital_ic_design-course/fft_multimode/sim/y_im_ifft64.txt","wb");
        while(cnt<N)begin
            if(valid_out == 1)begin
                $fwrite(fdyre,"%04x\n",y_re);
                $fwrite(fdyim,"%04x\n",y_im);
                cnt = cnt + 1;
            end
			#(period);
        end
		$fclose(fdyre);
		$fclose(fdyim);

		#(period*3);


		$finish;
		$stop;
	end
endmodule
