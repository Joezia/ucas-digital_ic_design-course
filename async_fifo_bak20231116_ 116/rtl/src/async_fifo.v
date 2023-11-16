// *********************************************************************************
// Author       : luzexiao
// E-mail       : zexiaooo@foxmail.com
// File         : async_fifo.v
// Create       : 2023-02-17 23:16:25
// *********************************************************************************
// Description  : 
//                
//==================================================================================
// Revision History:
// Date         By              Revision        Change Description
//----------------------------------------------------------------------------------
// 2023-02-17   luzexiao        1.0             Original
//==================================================================================

module async_fifo #(
    parameter DSIZE = 16, //Data Width
    parameter ASIZE = 10, //Address Width
    parameter ALMST = 32  //Almost Threshold
) (
    input                  wclk       , // Write side clk
    input                  wrst_n     , // Write side async reset, active low
    input                  wreq       , // Write side request, active high
    input      [DSIZE-1:0] wdata      , // Write side data
    output reg             wfull      , // Write side full, active high
    output reg             wfull_almst, // Write side almost full, active high
    input                  rclk       , // Read side clk
    input                  rrst_n     , // Read side async reset, active low
    input                  rreq       , // Read side request, active high
    output reg [DSIZE-1:0] rdata      , // Read side data
    output                 rdvld      , // Read side data valid indication
    output reg             repty      , // Read side empty
    output reg             repty_almst  // Read side almost empty
);
    localparam MEM_DEPTH = (1<<ASIZE);

    reg  [  ASIZE:0] rptrg_wclk1, rptrg_wclk2, rptrg;
    reg  [  ASIZE:0] wptrg_rclk1, wptrg_rclk2, wptrg;
    wire             repty_t    ;
    wire [ASIZE-1:0] raddr      ;
    reg  [  ASIZE:0] rptrb      ;
    wire [  ASIZE:0] rptrb_nxt  ;
    wire [  ASIZE:0] rptrg_nxt  ;

    wire [ASIZE-1:0] waddr    ;
    reg  [  ASIZE:0] wptrb    ;
    wire [  ASIZE:0] wptrb_nxt;
    wire [  ASIZE:0] wptrg_nxt;

    assign rdvld = rreq&~repty;

    // ------------------------------------------------------------------------------
    //                 Sync rptrg to wclk domain
    // ------------------------------------------------------------------------------
    always @ ( posedge wclk or negedge wrst_n )
    begin
        if(!wrst_n)
            {rptrg_wclk2,rptrg_wclk1} <= 'd0;
        else
            {rptrg_wclk2,rptrg_wclk1} <= {rptrg_wclk1,rptrg};
    end

    // ------------------------------------------------------------------------------
    //                 Sync wptrg to rclk domain
    // ------------------------------------------------------------------------------
    always @ ( posedge rclk or negedge rrst_n )
    begin
        if(!rrst_n)
            {wptrg_rclk2,wptrg_rclk1} <= 'd0;
        else
            {wptrg_rclk2,wptrg_rclk1} <= {wptrg_rclk1,wptrg};
    end

    // ------------------------------------------------------------------------------
    //                 Generate rempty
    // ------------------------------------------------------------------------------
    assign repty_t = (rptrg_nxt == wptrg_rclk2);

    always @ ( posedge rclk or negedge rrst_n )
    begin
        if(!rrst_n)
            repty <= 1'b1;
        else
            repty <= repty_t;
    end

    // ------------------------------------------------------------------------------
    //                 Generating read address
    // ------------------------------------------------------------------------------
    assign rptrb_nxt = !repty?(rptrb+rreq):(rptrb);

    always @ ( posedge rclk or negedge rrst_n )
    begin
        if(!rrst_n)
            rptrb <= 'd0;
        else
            rptrb <= rptrb_nxt;
    end

    assign raddr = rptrb_nxt[ASIZE-1:0];

    // ------------------------------------------------------------------------------
    //                 Generate rptr and send to wclk domain
    // ------------------------------------------------------------------------------
    assign rptrg_nxt = rptrb_nxt ^ (rptrb_nxt>>1);
    always @ ( posedge rclk or negedge rrst_n )
    begin
        if(!rrst_n)
            rptrg <= 'd0;
        else
            rptrg <= rptrg_nxt;
    end

    // ------------------------------------------------------------------------------
    //                 Generate write address
    // ------------------------------------------------------------------------------
    assign wptrb_nxt = wptrb + (wreq & !wfull);

    always @ ( posedge wclk or negedge wrst_n )
    begin
        if(!wrst_n)
            wptrb <= 'd0;
        else
            wptrb <= wptrb_nxt;
    end

    assign waddr = wptrb[ASIZE-1:0];

    // ------------------------------------------------------------------------------
    //                 Generate wptr and send to rclk domain
    // ------------------------------------------------------------------------------
    assign wptrg_nxt = (wptrb_nxt>>1) ^ wptrb_nxt;
    always @ ( posedge wclk or negedge wrst_n )
    begin
        if(!wrst_n)
            wptrg <= 'd0;
        else
            wptrg <= wptrg_nxt;
    end

    // ------------------------------------------------------------------------------
    //                 Generate full indication
    // ------------------------------------------------------------------------------
    always @ ( posedge wclk or negedge wrst_n )
    begin
        if(!wrst_n)
            wfull <= 1'b0;
        else
            wfull <= (wptrg_nxt == {~rptrg_wclk2[ASIZE:ASIZE-1],rptrg_wclk2[ASIZE-2:0]});
    end

    // ------------------------------------------------------------------------------
    //                 GRAY to Binary
    // ------------------------------------------------------------------------------
    wire [ASIZE:0] wptr_g2b,rptr_g2b;
    assign wptr_g2b[ASIZE] = wptrg_rclk2[ASIZE];
    assign rptr_g2b[ASIZE] = rptrg_wclk2[ASIZE];
    genvar i;
    generate
        for(i = 0; i < ASIZE; i=i+1)
        begin: gen_async_fifo
            assign wptr_g2b[i] = wptrg_rclk2[i]^wptr_g2b[i+1];
            assign rptr_g2b[i] = rptrg_wclk2[i]^rptr_g2b[i+1];
        end
    endgenerate

    // ------------------------------------------------------------------------------
    //                 Almost logic
    // ------------------------------------------------------------------------------
    wire [ASIZE:0] rgap,wgap;
    assign rgap = wptr_g2b - rptrb;
    assign wgap = (wptrb[ASIZE] ^ rptr_g2b[ASIZE])?(rptr_g2b[ASIZE-1:0] - wptrb[ASIZE-1:0]):(MEM_DEPTH+rptr_g2b-wptrb);

    always @ ( posedge wclk or negedge wrst_n )
    begin
        if(!wrst_n)
            wfull_almst <= 1'b0;
        else
            wfull_almst <= (wgap<=ALMST);
    end

    always @ ( posedge rclk or negedge rrst_n )
    begin
        if(!rrst_n)
            repty_almst <= 1'b1;
        else
            repty_almst <= (rgap<=ALMST);
    end

    // ------------------------------------------------------------------------------
    //                 Memory
    // ------------------------------------------------------------------------------

    // (* ramstyle = "M9K" *) reg [DSIZE-1:0] MEM [0:MEM_DEPTH-1]; //For altera fpga M9K ram
    // (*ram_style = "distributed"*) reg [DSIZE-1:0] MEM [0:MEM_DEPTH-1]; //For xilinx fpga distribute ram
    // (*ram_style = "block"*) reg [DSIZE-1:0] MEM [0:MEM_DEPTH-1]; //For xilinx fpga block ram
    reg [DSIZE-1:0] MEM [0:MEM_DEPTH-1];

    always @ ( posedge wclk )
    begin
        if(wreq & !wfull)
            MEM[waddr] <= wdata;
    end

    always @ ( posedge rclk )
    begin
        rdata <= MEM[raddr];
    end




endmodule


