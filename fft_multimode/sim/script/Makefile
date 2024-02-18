sim:
	iverilog -o  ../fft_multimode ../../src/*v

wave:
	iverilog -o ../fft_multimode ../../src/*v
	../fft_multimode
	gtkwave ../fft_multimode_tb.vcd
