onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_async_fifo/inst_async_fifo/wclk
add wave -noupdate /tb_async_fifo/inst_async_fifo/wrst_n
add wave -noupdate /tb_async_fifo/inst_async_fifo/wreq
add wave -noupdate /tb_async_fifo/inst_async_fifo/wdata
add wave -noupdate /tb_async_fifo/inst_async_fifo/wfull
add wave -noupdate /tb_async_fifo/inst_async_fifo/wfull_almst
add wave -noupdate /tb_async_fifo/inst_async_fifo/rclk
add wave -noupdate /tb_async_fifo/inst_async_fifo/rrst_n
add wave -noupdate /tb_async_fifo/inst_async_fifo/rreq
add wave -noupdate /tb_async_fifo/inst_async_fifo/rdata
add wave -noupdate /tb_async_fifo/inst_async_fifo/rdvld
add wave -noupdate /tb_async_fifo/inst_async_fifo/repty
add wave -noupdate /tb_async_fifo/inst_async_fifo/repty_almst
add wave -noupdate /tb_async_fifo/inst_async_fifo/rptrg_wclk1
add wave -noupdate /tb_async_fifo/inst_async_fifo/rptrg_wclk2
add wave -noupdate /tb_async_fifo/inst_async_fifo/rptrg
add wave -noupdate /tb_async_fifo/inst_async_fifo/wptrg_rclk1
add wave -noupdate /tb_async_fifo/inst_async_fifo/wptrg_rclk2
add wave -noupdate /tb_async_fifo/inst_async_fifo/wptrg
add wave -noupdate /tb_async_fifo/inst_async_fifo/repty_t
add wave -noupdate /tb_async_fifo/inst_async_fifo/raddr
add wave -noupdate /tb_async_fifo/inst_async_fifo/rptrb
add wave -noupdate /tb_async_fifo/inst_async_fifo/rptrb_nxt
add wave -noupdate /tb_async_fifo/inst_async_fifo/rptrg_nxt
add wave -noupdate /tb_async_fifo/inst_async_fifo/waddr
add wave -noupdate /tb_async_fifo/inst_async_fifo/wptrb
add wave -noupdate /tb_async_fifo/inst_async_fifo/wptrb_nxt
add wave -noupdate /tb_async_fifo/inst_async_fifo/wptrg_nxt
add wave -noupdate /tb_async_fifo/inst_async_fifo/wptr_g2b
add wave -noupdate /tb_async_fifo/inst_async_fifo/rptr_g2b
add wave -noupdate /tb_async_fifo/inst_async_fifo/rgap
add wave -noupdate /tb_async_fifo/inst_async_fifo/wgap
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1570000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {8558550 ps}
