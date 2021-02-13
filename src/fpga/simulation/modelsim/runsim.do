vlog -reportprogress 300 -work work /home/ian/fun/julia_lcd/src/fpga/test/sdr.v
vlog -reportprogress 300 -work work /home/ian/fun/julia_lcd/src/fpga/test/julia_tb.v
vsim -L altera_mf_ver  work.julia_tb

add wave -position insertpoint  \
sim:/julia_tb/jclk \
sim:/julia_tb/LCDCLK \
sim:/julia_tb/RGB \
sim:/julia_tb/DEN \
sim:/julia_tb/HSD \
sim:/julia_tb/VSD \
sim:/julia_tb/STBYB
