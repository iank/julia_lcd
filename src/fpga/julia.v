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

`include "sdram.vh"

/***********************************************************************/

/* PLLs */
wire MEM_CLK;
mem_pll mem_pll(.inclk0(PLD_CLOCKINPUT), .c0(MEM_CLK), .c1(S_CLK));
vid_pll vid_pll(.inclk0(PLD_CLOCKINPUT), .c0(LCDCLK));

/***********************************************************************/

localparam SDRAM_MUX_INIT        = 2'd0;
localparam SDRAM_MUX_FRAME_READER= 2'd1;
localparam SDRAM_MUX_PROCESSOR   = 2'd2;

/* SDRAM Mux -> SDRAM controller */
wire [1:0] command;
wire [21:0] data_address;
wire [31:0] data_write;
wire [1:0] mux_sel;

/* SDRAM Controller outputs */
wire [31:0] data_read;
wire data_read_valid, data_write_done;

/* Memory initializer -> SDRAM Mux */
wire [1:0] MI_command;
wire [21:0] MI_data_address;
wire [31:0] MI_data_write;
wire sdram_initialized;

/* Frame reader -> SDRAM Mux, Video out, Processor */
wire [1:0] FR_command;
wire [21:0] FR_data_address;
wire first_data_ready;
wire frame_reader_requests_sdram;

/* Processor -> SDRAM Mux, frame reader */
wire [31:0] PR_data_write;
wire [1:0] PR_command;
wire [21:0] PR_data_address;
wire processor_yields_sdram;
wire it_worked;


/* Frame reader <-> FIFO <-> Video out */
wire [31:0] pixel_data_in;
wire [7:0] pixel_data_out;
wire pixel_data_in_enable, pixel_data_out_acknowledge;
wire [9:0] pixel_in_used;

/***********************************************************************/

/* SDRAM Mux: Switch access to the SDRAM controller between init,
 *            frame reader, and fractal engine as necessary */
sdram_mux sdram_mux(
    .sel(mux_sel),
    .data0x({MI_command, MI_data_address, MI_data_write}),
    .data1x({FR_command, FR_data_address, 32'dx}),
    .data2x({PR_command, PR_data_address, PR_data_write}),
    .result({command, data_address, data_write})
);

assign mux_sel = sdram_initialized ? (processor_yields_sdram ? SDRAM_MUX_FRAME_READER: SDRAM_MUX_PROCESSOR) : SDRAM_MUX_INIT;

/* SDRAM Controller */
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

/* Memory initializer */
mem_init mem_init (
    .i_Clk(MEM_CLK),
    .i_Data_Write_Done(data_write_done),
    .o_Command(MI_command),
    .o_Data_Address(MI_data_address),
    .o_Data_Write(MI_data_write),
    .o_SDRAM_Initialized(sdram_initialized)
);

/* Frame Reader */
frame_reader frame_reader (
    .i_Clk(MEM_CLK),
    .i_Begin(sdram_initialized),
    .i_Data_Read_Valid(data_read_valid),
    .i_Pixel_In_Used(pixel_in_used),
    .i_SDRAM_Grant(processor_yields_sdram),
    .o_SDRAM_Request(frame_reader_requests_sdram),
    .o_Command(FR_command),
    .o_Data_Address(FR_data_address),
    .o_FIFO_Wr(pixel_data_in_enable),
    .o_First_Data_Ready(first_data_ready)
);

/* Processor */
mandelbrot mandelbrot(
    .i_Clk(MEM_CLK),
    .i_SDRAM_Requested(frame_reader_requests_sdram),
    .i_Data_Read (data_read),
    .i_Data_Write_Done(data_write_done),
    .i_Data_Read_Valid(data_read_valid),
    .o_SDRAM_Yield(processor_yields_sdram),
    .o_Command(PR_command),
    .o_Data_Address(PR_data_address),
    .o_Data_Write(PR_data_write),
    .it_worked(it_worked)
);

/* FIFO */
assign pixel_data_in = data_read;

fifo pixel_read_fifo (
    .data (pixel_data_in),
    .rdclk (LCDCLK),
    .rdreq (pixel_data_out_acknowledge),
    .wrclk (MEM_CLK),
    .wrreq (pixel_data_in_enable),
    .q (pixel_data_out),
    .wrusedw (pixel_in_used)
);

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

/* LEDs */
assign LEDG[0] = ~it_worked;
assign LEDG[1] = 1'b1;

endmodule
