vlog -reportprogress 300 -work work /home/ian/fun/julia_lcd/src/fpga/test/sdr.v
vlog -reportprogress 300 -work work /home/ian/fun/julia_lcd/src/fpga/test/julia_tb.v
vsim -L altera_mf_ver  work.julia_tb

add wave -position insertpoint \
sim:/julia_tb/jclk \
sim:/julia_tb/LCDCLK \
sim:/julia_tb/RGB \
sim:/julia_tb/S_CLK \
sim:/julia_tb/S_DQ \
sim:/julia_tb/DUT/pixel_data_out \
sim:/julia_tb/DUT/pixel_data_in \
sim:/julia_tb/DUT/pixel_in_used \
sim:/julia_tb/DUT/pixel_data_out_acknowledge \
sim:/julia_tb/DUT/pixel_data_in_enable \
sim:/julia_tb/DUT/data_address \
sim:/julia_tb/DUT/data_read_valid \
sim:/julia_tb/DUT/countdown \
sim:/julia_tb/DUT/data_read \
sim:/julia_tb/DUT/command \
sim:/julia_tb/DUT/as4c4m32s_controller/sdram_controller/countdown \
sim:/julia_tb/DUT/as4c4m32s_controller/sdram_controller/step \
sim:/julia_tb/DUT/as4c4m32s_controller/sdram_controller/state \
sim:/julia_tb/DUT/MEM_CLK
