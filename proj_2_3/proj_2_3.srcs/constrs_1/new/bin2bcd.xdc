set_property PACKAGE_PIN AD12 [get_ports sys_clk_p]
set_property PACKAGE_PIN AD11 [get_ports sys_clk_n]
set_property IOSTANDARD LVDS [get_ports sys_clk_p]
set_property IOSTANDARD LVDS [get_ports sys_clk_n]
set_property PACKAGE_PIN AG5 [get_ports rst]
set_property IOSTANDARD LVCMOS15 [get_ports rst]

set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

create_clock -period 5.000 [get_ports sys_clk_n]