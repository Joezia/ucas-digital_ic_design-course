create_clock -period 10 -name wclk [get_ports wclk]
create_clock -period 10 -name rclk [get_ports rclk]
set_false_path -from [get_ports wrst_n]
set_false_path -from [get_ports rrst_n]


