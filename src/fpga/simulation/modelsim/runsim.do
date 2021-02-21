vlog -reportprogress 300 -work work /home/ian/fun/julia_lcd/src/fpga/test/sdr.v
vlog -reportprogress 300 -work work /home/ian/fun/julia_lcd/src/fpga/test/julia_tb.v
vsim -L altera_mf_ver -L lpm_ver work.julia_tb

add wave -position insertpoint \
sim:/julia_tb/jclk \
sim:/julia_tb/LCDCLK \
sim:/julia_tb/RGB \
sim:/julia_tb/S_CLK \
sim:/julia_tb/DUT/CPU_CLK \
sim:/julia_tb/DUT/pixel_data_out \
sim:/julia_tb/DUT/pixel_data_in \
sim:/julia_tb/DUT/pixel_in_used \
sim:/julia_tb/DUT/pixel_data_out_acknowledge \
sim:/julia_tb/DUT/pixel_data_in_enable \
sim:/julia_tb/DUT/data_address \
sim:/julia_tb/DUT/FR_command \
sim:/julia_tb/DUT/FR_data_address \
sim:/julia_tb/DUT/frame_reader_requests_sdram \
sim:/julia_tb/DUT/PR_data_write \
sim:/julia_tb/DUT/PR_command \
sim:/julia_tb/DUT/PR_data_address \
sim:/julia_tb/DUT/processor_yields_sdram \
sim:/julia_tb/DUT/mandelbrot/o_Data_Address \
sim:/julia_tb/DUT/mandelbrot/o_Data_Write \
sim:/julia_tb/DUT/mandelbrot/r_NextState \
sim:/julia_tb/DUT/mandelbrot/px_readout_wrreq \
sim:/julia_tb/DUT/mandelbrot/px_writeback_rdreq \
sim:/julia_tb/DUT/mandelbrot/px_readout_fifo_empty \
sim:/julia_tb/DUT/mandelbrot/px_readout_fifo_empty_cpu \
sim:/julia_tb/DUT/mandelbrot/px_writeback_fifo_full \
sim:/julia_tb/DUT/mandelbrot/px_writeback_fifo_full_cpu \
sim:/julia_tb/DUT/mandelbrot/px_writeback_fifo_empty \
sim:/julia_tb/DUT/mandelbrot/px_data_write \
sim:/julia_tb/DUT/mandelbrot/px_readout_rdreq \
sim:/julia_tb/DUT/mandelbrot/px_writeback_wrreq \
sim:/julia_tb/DUT/mandelbrot/px_readout_to_writeback \
sim:/julia_tb/DUT/mandelbrot/px_processed_data \
sim:/julia_tb/DUT/mandelbrot/data_writeback_rdreq \
sim:/julia_tb/DUT/mandelbrot/data_readout_to_writeback \
sim:/julia_tb/DUT/mandelbrot/data_processed_data \
sim:/julia_tb/DUT/mandelbrot/data_readout_wrreq \
sim:/julia_tb/DUT/MEM_CLK \
sim:/julia_tb/S_DQ \
sim:/julia_tb/DUT/mux_sel \
sim:/julia_tb/DUT/mandelbrot/o_Command \
sim:/julia_tb/DUT/data_read_valid \
sim:/julia_tb/DUT/data_write_done \
sim:/julia_tb/DUT/data_read \
sim:/julia_tb/DUT/mandelbrot/data_writeback_fifo_empty \
sim:/julia_tb/DUT/mandelbrot/px_data_address \
sim:/julia_tb/DUT/mandelbrot/data_data_address \
sim:/julia_tb/DUT/mandelbrot/data_data_write \
sim:/julia_tb/DUT/mandelbrot/r_State \
sim:/julia_tb/DUT/mandelbrot/countdown \
sim:/julia_tb/DUT/mandelbrot/data_readout_fifo_empty \
sim:/julia_tb/DUT/mandelbrot/data_writeback_fifo_full \
sim:/julia_tb/DUT/mandelbrot/data_readout_fifo_empty_cpu \
sim:/julia_tb/DUT/mandelbrot/data_writeback_fifo_full_cpu \
sim:/julia_tb/DUT/mandelbrot/data_writeback_wrreq \
sim:/julia_tb/DUT/mandelbrot/data_readout_rdreq
