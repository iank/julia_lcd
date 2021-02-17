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

/* SDRAM Mux -> SDRAM controller */
wire [1:0] command;
wire [21:0] data_address;
wire [31:0] data_write;
wire [5:0] dummy;

/* SDRAM Controller outputs */
wire [31:0] data_read;
wire data_read_valid, data_write_done;

/* Frame reader <-> SDRAM Mux, FIFO */
wire [1:0] FR_command;
wire [21:0] FR_data_address;
wire [31:0] FR_data_write;
wire first_data_ready;

/* Frame reader <-> FIFO <-> Video out */
wire [31:0] pixel_data_in;
wire [7:0] pixel_data_out;
wire pixel_data_in_enable, pixel_data_out_acknowledge;
wire [9:0] pixel_in_used;

/***********************************************************************/

/* SDRAM Mux: Switch access to the SDRAM controller between init,
 *            frame reader, and fractal engine as necessary */
sdram_mux sdram_mux(
    .sel(2'b00),
    .data0x({FR_command, FR_data_address, FR_data_write}),
    .data1x(),
    .data2x(),
    .result({command, data_address, data_write})
);

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

/* Frame Reader */
frame_reader frame_reader (
    .i_Clk(MEM_CLK),
    .i_Data_Read_Valid(data_read_valid),
    .i_Data_Write_Done(data_write_done),
    .i_Pixel_In_Used(pixel_in_used),
    .o_Command(FR_command),
    .o_Data_Address(FR_data_address),
    .o_Data_Write(FR_data_write),
    .o_FIFO_Wr(pixel_data_in_enable),
    .o_First_Data_Ready(first_data_ready)
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
assign LEDG[0] = 1'b1;
assign LEDG[1] = 1'b1;

endmodule
