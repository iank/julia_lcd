module mandelbrot(
    input i_Clk,
    input i_CPU_Clk,

    input i_Data_Read_Valid,
    input i_Data_Write_Done,
    input [31:0] i_Data_Read,
 
    input i_SDRAM_Requested,
    output o_SDRAM_Yield,

    output [1:0] o_Command,
    output reg [21:0] o_Data_Address,
    output [31:0] o_Data_Write,

    input [9:0] i_cx,
    input [8:0] i_cy
);

`include "sdram.vh"
`include "draw.vh"

localparam STATE_IDLE      = 3'd0;
localparam STATE_READPX    = 3'd1;
localparam STATE_WRITEPX   = 3'd2;
localparam STATE_READDATA  = 3'd3;
localparam STATE_WRITEDATA = 3'd4;


/////////////////////////////////////////
reg [31:0] r_Counter = 32'd0;

reg [1:0] draw_state = DRAW_MANDELBROT;
always @(posedge i_CPU_Clk) begin
    r_Counter <= r_Counter + 32'd1;
    if (draw_state != DRAW_CLEAR && r_Counter[27] == 1'b1) begin
        draw_state <= DRAW_CLEAR;
        r_Counter <= 32'd0;
    end
    if (draw_state == DRAW_CLEAR && r_Counter[25] == 1'b1) begin
        draw_state <= DRAW_JULIA;
        r_Counter <= 32'd0;
    end
end
/////////////////////////////////////////

reg [2:0] r_State = STATE_IDLE;
reg [2:0] r_NextState;

assign o_Command = (r_State == STATE_IDLE) ? CMD_IDLE : ((r_State == STATE_READPX || r_State == STATE_READDATA) ? CMD_READ : CMD_WRITE);

reg [21:0] px_data_address = 22'd0;
reg [21:0] data_data_address = 22'h20000;
initial o_Data_Address = 22'd0;

reg [7:0] countdown;

assign o_SDRAM_Yield = i_SDRAM_Requested && r_State == STATE_IDLE;

/***********************************************************************
 *                   FIFOs
 ***********************************************************************/
// PX fifo control
wire px_readout_wrreq = r_State == STATE_READPX && i_Data_Read_Valid;
wire px_writeback_rdreq = r_State == STATE_WRITEPX && i_Data_Write_Done;

// Data fifo control
wire data_readout_wrreq = r_State == STATE_READDATA && i_Data_Read_Valid;
wire data_writeback_rdreq = r_State == STATE_WRITEDATA && i_Data_Write_Done;

wire px_readout_fifo_empty, data_readout_fifo_empty;
wire px_writeback_fifo_full, px_writeback_fifo_empty, data_writeback_fifo_full, data_writeback_fifo_empty;
wire [31:0] px_data_write, data_data_write; // To SDRAM mux

// To/from math processor
wire readout_rdreq, writeback_wrreq;
wire px_readout_fifo_empty_cpu, px_writeback_fifo_full_cpu;
wire [7:0] px_fifo_q, px_fifo_data;
wire data_readout_fifo_empty_cpu, data_writeback_fifo_full_cpu;
wire [95:0] data_fifo_q, data_fifo_data;

/* Read/writeback FIFO */
processor_fifo_32in8out px_readout_fifo (
    .rdclk (i_CPU_Clk),
    .wrclk (i_Clk),
    .data (i_Data_Read),
    .rdreq (readout_rdreq),
    .wrreq (px_readout_wrreq),
    .wrempty (px_readout_fifo_empty),
    .rdempty (px_readout_fifo_empty_cpu),
    .q (px_fifo_q)
);

processor_fifo_8in32out px_writeback_fifo (
    .rdclk (i_Clk),
    .wrclk (i_CPU_Clk),
    .data (px_fifo_data),
    .rdreq (px_writeback_rdreq),
    .wrreq (writeback_wrreq),
    .rdfull (px_writeback_fifo_full),
    .wrfull (px_writeback_fifo_full_cpu),
    .rdempty (px_writeback_fifo_empty),
    .q (px_data_write)
);

processor_fifo_32in64out data_readout_fifo (
    .rdclk (i_CPU_Clk),
    .wrclk (i_Clk),
    .data (i_Data_Read),
    .rdreq (readout_rdreq),
    .wrreq (data_readout_wrreq),
    .wrempty (data_readout_fifo_empty),
    .rdempty (data_readout_fifo_empty_cpu),
    .q (data_fifo_q)
);

processor_fifo_64in32out data_writeback_fifo (
    .rdclk (i_Clk),
    .wrclk (i_CPU_Clk),
    .data (data_fifo_data),
    .rdreq (data_writeback_rdreq),
    .wrreq (writeback_wrreq),
    .rdfull (data_writeback_fifo_full),
    .wrfull (data_writeback_fifo_full_cpu),
    .rdempty (data_writeback_fifo_empty),
    .q (data_data_write)
);

mandelbrot_math mandelbrot_math(
    .i_Clk(i_CPU_Clk),
    .i_Px_Data({px_fifo_q, data_fifo_q}),
    .o_Px_Data({px_fifo_data, data_fifo_data}),
    
    .i_Draw(draw_state),
    
    .i_Read_Fifo_Empty(px_readout_fifo_empty_cpu | data_readout_fifo_empty_cpu),
    .i_Write_Fifo_Full(px_writeback_fifo_full_cpu | data_writeback_fifo_full_cpu),
    .o_Read_Fifo_Ack(readout_rdreq),
    .o_Write_Fifo_Wrreq(writeback_wrreq),

    .i_cx(i_cx),
    .i_cy(i_cy)
);
	 
/***********************************************************************/

processor_data_mux processor_data_mux(
    .data0x(px_data_write),
    .data1x(data_data_write),
    .result(o_Data_Write),
    .sel(r_State == STATE_WRITEDATA)
);

// State transitions
always @(*) begin
    r_NextState = r_State;
    if (r_State == STATE_IDLE && ~i_SDRAM_Requested) begin
        if (px_readout_fifo_empty && px_writeback_fifo_empty)
            r_NextState = STATE_READPX;
        else if (px_writeback_fifo_full)
            r_NextState = STATE_WRITEPX;
        else if (data_readout_fifo_empty && data_writeback_fifo_empty)
            r_NextState = STATE_READDATA;
        else if (data_writeback_fifo_full)
            r_NextState = STATE_WRITEDATA;
        else
            r_NextState = STATE_IDLE;
    end
    else if ((r_State == STATE_READPX || r_State == STATE_READDATA) && i_Data_Read_Valid && countdown == 3'd0) begin
        r_NextState = STATE_IDLE;
    end
    else if ((r_State == STATE_WRITEPX || r_State == STATE_WRITEDATA) && i_Data_Write_Done && countdown == 3'd0) begin
        r_NextState = STATE_IDLE;
    end
end

// Memory control
always @(posedge i_Clk) begin
    r_State <= r_NextState;
    if (r_State == STATE_IDLE && (r_NextState == STATE_READPX || r_NextState == STATE_WRITEPX)) begin
        countdown <= READ_BURST_LENGTH - 1;
        o_Data_Address <= px_data_address;
    end
    else if (r_State == STATE_IDLE && (r_NextState == STATE_READDATA || r_NextState == STATE_WRITEDATA)) begin
        countdown <= 16*READ_BURST_LENGTH - 1;
        o_Data_Address <= data_data_address;
    end

    else if (r_State == STATE_READPX && i_Data_Read_Valid) begin
        countdown <= countdown - 1'd1;
        o_Data_Address <= o_Data_Address + 1'd1;
    end
 
    else if (r_State == STATE_WRITEPX && i_Data_Write_Done) begin
        if (countdown == 3'd0) begin
            px_data_address <= o_Data_Address == (480*200 - 1) ? 22'd0 : px_data_address + READ_BURST_LENGTH;
        end
        countdown <= countdown - 1'd1;
        o_Data_Address <= o_Data_Address + 1'd1;
    end
///////////////////////
    else if (r_State == STATE_READDATA && i_Data_Read_Valid) begin
        countdown <= countdown - 1'd1;
        o_Data_Address <= o_Data_Address + 1'd1;
    end
 
    else if (r_State == STATE_WRITEDATA && i_Data_Write_Done) begin
        if (countdown == 3'd0) begin
            data_data_address <= o_Data_Address == (22'h20000 + (480*3200 - 1)) ? 22'h20000 : data_data_address + 16*READ_BURST_LENGTH;
        end
        countdown <= countdown - 1'd1;
        o_Data_Address <= o_Data_Address + 1'd1;
    end
end

endmodule
