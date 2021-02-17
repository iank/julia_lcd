module julia(
    /* Physical inputs */
    input PLD_CLOCKINPUT,

    /* Physical outputs */
    output [1:0] LEDG,
     
    inout  [31:0] S_DQ,
    output [11:0] S_ADDR,
    output [1:0] S_BA,
    output S_CAS_N,
    output S_CKE,
    output S_CLK,
    output S_CS_N,
    output [3:0] S_DQM,
    output S_RAS_N,
    output S_WE_N,

    output LCDCLK,
    output [23:0] RGB,
    output DEN,
    output HSD,
    output VSD,
    output STBYB
);

/* PLLs */
wire MEM_CLK;
mem_pll mem_pll(.inclk0(PLD_CLOCKINPUT), .c0(MEM_CLK), .c1(S_CLK));
vid_pll vid_pll(.inclk0(PLD_CLOCKINPUT), .c0(LCDCLK));

/* SDRAM */
localparam WRITE_BURST = 1;
localparam READ_BURST_LENGTH = 8;

localparam CMD_IDLE  = 2'd0;
localparam CMD_WRITE = 2'd1;
localparam CMD_READ  = 2'd2;

reg [1:0] command = 2'd0;
reg sdram_init_complete = 1'd0;
reg [21:0] data_address = 22'd0;
reg [31:0] data_write = 32'd0;
wire [31:0] data_read;
wire data_read_valid, data_write_done;
reg [7:0] countdown;

as4c4m32s_controller #(.CLK_RATE(80000000), .WRITE_BURST(WRITE_BURST), .READ_BURST_LENGTH(READ_BURST_LENGTH), .CAS_LATENCY(3)) as4c4m32s_controller (
    .clk(MEM_CLK),
    .command(command),
    .data_address(data_address),
    .data_write(data_write),
    .data_read(data_read),
    .data_read_valid(data_read_valid),
    .data_write_done(data_write_done),
     
     /* Physical outputs */
    .clock_enable(S_CKE),
    .bank_activate(S_BA),
    .address(S_ADDR),
    .chip_select(S_CS_N),
    .row_address_strobe(S_RAS_N),
    .column_address_strobe(S_CAS_N),
    .write_enable(S_WE_N),
    .dqm(S_DQM),
    .dq(S_DQ)
);

/* FIFO */

reg first_data_ready = 1'b0;
wire [31:0] pixel_data_in;
wire [7:0] pixel_data_out;
wire pixel_data_in_enable, pixel_data_out_acknowledge;
wire [9:0] pixel_in_used;

fifo	pixel_read_fifo (
	.data (pixel_data_in),
	.rdclk (LCDCLK),
	.rdreq (pixel_data_out_acknowledge),
	.wrclk (MEM_CLK),
	.wrreq (pixel_data_in_enable),
	.q (pixel_data_out),
	.wrusedw (pixel_in_used)
);
	
assign pixel_data_in_enable = command == CMD_READ && data_read_valid;
assign pixel_data_in = data_read;

reg fifo_filling = 1'b0;
wire fifo_low_threshold, fifo_high_threshold;

assign fifo_low_threshold = (pixel_in_used <= 256);
assign fifo_high_threshold = (pixel_in_used >= (1024 - READ_BURST_LENGTH));

/* Memory control logic */
always @(posedge MEM_CLK) begin
    /* Initialize SDRAM */
    if (command == CMD_IDLE && !sdram_init_complete) begin
        command <= CMD_WRITE;
        data_write <= {10'b1111111100, data_address};
        countdown <= READ_BURST_LENGTH - 1;
    end
    else if (command == CMD_WRITE && data_write_done) begin
        if (countdown == 3'd0)
            command <= CMD_IDLE;
        else
            countdown <= countdown - 1'd1;
             
        data_address <= data_address + 1'd1;
        //data_write <= {10'b0000000000, data_address + 1'd1};
		  data_write <= {4{data_address[7:0] + 1'd1}};
/*        if (data_address + 1'd1 == 22'd0)
            sdram_init_complete <= 1'b1;*/
        if (data_address + 1'd1 == (480*200)) begin
            data_address <= 0;
            sdram_init_complete <= 1'b1;
        end
    end
     /* Read back from SDRAM */
    else if (command == CMD_IDLE && sdram_init_complete) begin
        if ((fifo_low_threshold && !fifo_filling) || (fifo_filling && !fifo_high_threshold)) begin
		      fifo_filling <= 1'b1;
            command <= CMD_READ;
            countdown <= READ_BURST_LENGTH - 1;
        end
    end
    else if (command == CMD_READ && data_read_valid) begin
        if (countdown == 3'd0) begin
            command <= CMD_IDLE;
            first_data_ready <= 1'b1;
        end
        else
            countdown <= countdown - 1'd1;

        data_address <= data_address == (480*200 - 1) ? 22'd0 : data_address + 1'd1;
    end
	 if (fifo_filling && fifo_high_threshold)
	     fifo_filling <= 1'b0;
end

assign LEDG[0] = ~sdram_init_complete;
assign LEDG[1] = ~data_read_valid;

/* LCD */
video_out video_out (
    .LCDCLK(LCDCLK),
	 .i_Begin(first_data_ready),
    .i_Pixel_Data(pixel_data_out), // "out" from FIFO
	 .o_Pixel_Data_Acknowledge(pixel_data_out_acknowledge),
	 
    /* Physical outputs */
    .RGB(RGB),
    .DEN(DEN),
    .HSD(HSD),
    .VSD(VSD),
    .STBYB(STBYB)
);

endmodule
