iverilog -g2012 -o top.vvp -c filelist.txt -DDUMP_IVLOG

vvp -n top.vvp

gtkwave top.vcd

pause
