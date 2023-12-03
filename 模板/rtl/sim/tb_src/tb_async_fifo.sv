`timescale 1ns/1ns

module tb_async_fifo ();

    int rnd_seed;
    // ------------------------------------------------------------------------------
    //                 clk and rst
    // ------------------------------------------------------------------------------
    // clock
    parameter CLK_TA = 23   ;
    parameter CLK_TB = 10  ;
    logic     clka   = 1'b0;
    logic     clkb   = 1'b0;
    always #(CLK_TA/2) clka = ~clka;
    always #(CLK_TB/2) clkb = ~clkb;

    assign clkw = clka;
    assign clkr = clkb;

    // asynchronous reset
    logic wrst_n,rrst_n;
    initial begin
        wrst_n <= '0;
        rrst_n <= '0;
        #10
        wrst_n <= '1;
        rrst_n <= '1;
        repeat (2000)@(posedge clkw);
        $finish;
    end

    // Dump fsdb for VCS
    `ifdef DUMP_FSDB
    initial
    begin
        $fsdbDumpfile("top.fsdb");
        $fsdbDumpvars;
    end
    `endif

    // Dump VCD for Iverilog
    `ifdef DUMP_IVLOG
    initial
    begin
        $dumpfile("top.vcd");
        $dumpvars;
    end
    `endif



    // ------------------------------------------------------------------------------
    //                 Instance
    // ------------------------------------------------------------------------------
    parameter DSIZE = 8;
    parameter ASIZE = 6 ;
    parameter ALMST = 12;

    logic             wreq       ;
    logic [DSIZE-1:0] wdata      ;
    logic             wfull      ;
    logic             wfull_almst;
    logic             rreq       ;
    logic [DSIZE-1:0] rdata      ;
    logic             rdvld      ;
    logic             repty      ;
    logic             repty_almst;

    async_fifo #(
        .DSIZE(DSIZE),
        .ASIZE(ASIZE),
        .ALMST(ALMST)
    ) inst_async_fifo (
        .wclk       (clkw       ),
        .wrst_n     (wrst_n     ),
        .wreq       (wreq       ),
        .wdata      (wdata      ),
        .wfull      (wfull      ),
        .wfull_almst(wfull_almst),
        .rclk       (clkr       ),
        .rrst_n     (rrst_n     ),
        .rreq       (rreq       ),
        .rdata      (rdata      ),
        .rdvld      (rdvld      ),
        .repty      (repty      ),
        .repty_almst(repty_almst)
    );

    // ------------------------------------------------------------------------------
    //                 Driver
    // ------------------------------------------------------------------------------
    task init();
        wreq   <= '0;
        wdata  <= '0;
        rreq   <= '0;
        rnd_seed = 0;
    endtask

    task write_fifo(int iter);
        wreq = 1'b0;

        for(int it = 0; it < iter; it++)
        begin
            @(posedge clkw);
            #(1);
            // wdata = {$random(rnd_seed)}%(2**DSIZE);
            wdata = it+1;
            wreq = 1'b1;
        end
        @(posedge clkw);
        #(1);
        wreq = 1'b0;
    endtask

    task read_fifo();
        wait(!repty);
        @(posedge clkr);
        rreq = '1;
        wait(repty);
        @(posedge clkr);
        rreq = '0;
    endtask


    task write_fifo_read(int iter);
        for(int it = 0; it < iter; it++)
        begin
            @(posedge clkw);
            #(1);
            wdata = it+1;
            wreq = '1;
            rreq = '1;
        end
        wreq = '0;
        wait(repty);
        @(posedge clkw);
        #(1);
        wreq = '0;
        rreq = '0;
    endtask

    initial
    begin
        init();
        repeat(10)@(posedge clkw);
        write_fifo(33);
        read_fifo();
        repeat(10)@(posedge clkw);

        write_fifo(70);
        read_fifo();
        repeat(10)@(posedge clkw);

        write_fifo_read(70);
        repeat(10)@(posedge clkw);

        fork 
            write_fifo (100);
            read_fifo();
        join
        repeat (10)@(posedge clkw);
        $finish;
    end

endmodule


