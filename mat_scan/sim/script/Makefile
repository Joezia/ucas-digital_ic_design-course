sim:
	iverilog -o ../mat_scan ../../src/*v                                                                  
	
wave:
	iverilog -o ../mat_scan ../../src/*v
	../mat_scan
	gtkwave ../mat_scan_tb.vcd
