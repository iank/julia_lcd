module mandelbrot(
    input i_Clk,

    input i_Data_Read_Valid,
    input i_Data_Write_Done,
    input [31:0] i_Data_Read,
 
    input i_SDRAM_Requested,
    output o_SDRAM_Yield,

    output [1:0] o_Command,
    output reg [21:0] o_Data_Address,
    output [31:0] o_Data_Write
);

`include "sdram.vh"

localparam STATE_IDLE      = 3'd0;
localparam STATE_READPX    = 3'd1;
localparam STATE_WRITEPX   = 3'd2;
localparam STATE_READDATA  = 3'd3;
localparam STATE_WRITEDATA = 3'd4;

reg [2:0] r_State = STATE_IDLE;
reg [2:0] r_NextState;

assign o_Command = (r_State == STATE_IDLE) ? CMD_IDLE : ((r_State == STATE_READPX || r_State == STATE_READDATA) ? CMD_READ : CMD_WRITE);

reg [21:0] px_data_address = 22'd0;
reg [21:0] data_data_address = 22'h20000;
initial o_Data_Address = 22'd0;

reg [7:0] countdown;

assign o_SDRAM_Yield = i_SDRAM_Requested && r_State == STATE_IDLE;

// PX fifo control
wire px_readout_wrreq;
assign px_readout_wrreq = r_State == STATE_READPX && i_Data_Read_Valid;
wire px_writeback_rdreq;
assign px_writeback_rdreq = r_State == STATE_WRITEPX && i_Data_Write_Done;

wire px_readout_fifo_empty;
wire px_writeback_fifo_full, px_writeback_fifo_empty;
wire [31:0] px_data_write;

// For mock processor
reg px_readout_rdreq = 1'b0;
reg px_writeback_wrreq = 1'b0;
wire [31:0] px_readout_to_writeback;

/* Read/writeback FIFO */
processor_fifo_ack px_readout_fifo (
    .clock (i_Clk),
    .data (i_Data_Read),
    .rdreq (px_readout_rdreq),
    .wrreq (px_readout_wrreq),
    .full (),
    .empty (px_readout_fifo_empty),
    .q (px_readout_to_writeback)
);

wire [31:0] px_processed_data  = ((px_readout_to_writeback[7:0]   + 8'h01) << 0) | 
                                 ((px_readout_to_writeback[15:8]  + 8'h01) << 8) | 
                                 ((px_readout_to_writeback[23:16] + 8'h01) << 16) | 
                                 ((px_readout_to_writeback[31:24] + 8'h01) << 24);

processor_fifo_ack px_writeback_fifo (
    .clock (i_Clk),
    .data (px_processed_data),
    .rdreq (px_writeback_rdreq),
    .wrreq (px_writeback_wrreq),
    .full (px_writeback_fifo_full),
    .empty (px_writeback_fifo_empty),
    .q (px_data_write)
);

/////////////
// PX fifo control
wire data_readout_wrreq;
assign data_readout_wrreq = r_State == STATE_READDATA && i_Data_Read_Valid;
wire data_writeback_rdreq;
assign data_writeback_rdreq = r_State == STATE_WRITEDATA && i_Data_Write_Done;

wire data_readout_fifo_empty;
wire data_writeback_fifo_full, data_writeback_fifo_empty;
wire [31:0] data_data_write;

// For mock processor
reg data_readout_rdreq = 1'b0;
reg data_writeback_wrreq = 1'b0;
wire [31:0] data_readout_to_writeback;


/* Read/writeback FIFO */
processor_fifo_ack_big data_readout_fifo (
    .clock (i_Clk),
    .data (i_Data_Read),
    .rdreq (data_readout_rdreq),
    .wrreq (data_readout_wrreq),
    .full (),
    .empty (data_readout_fifo_empty),
    .q (data_readout_to_writeback)
);

wire [31:0] data_processed_data = ((data_readout_to_writeback[7:0]   + 8'h08) << 0) | 
                                  ((data_readout_to_writeback[15:8]  + 8'h01) << 8) | 
                                  ((data_readout_to_writeback[23:16] + 8'h05) << 16) | 
                                  ((data_readout_to_writeback[31:24] + 8'h20) << 24);

processor_fifo_ack_big data_writeback_fifo (
    .clock (i_Clk),
    .data (data_processed_data),
    .rdreq (data_writeback_rdreq),
    .wrreq (data_writeback_wrreq),
    .full (data_writeback_fifo_full),
    .empty (data_writeback_fifo_empty),
    .q (data_data_write)
);
/////////////

processor_data_mux processor_data_mux(
    .data0x(px_data_write),
    .data1x(data_data_write),
    .result(o_Data_Write),
    .sel(r_State == STATE_WRITEDATA)
);


reg [3:0] reg_test = 4'd0;

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

// Mock processor
always @(posedge i_Clk) begin
    px_readout_rdreq <= 1'b0;
    px_writeback_wrreq <= 1'b0;
 
    reg_test <= reg_test + 1'd1;
    if (!px_readout_fifo_empty && !px_writeback_fifo_full && reg_test == 4'd0) begin
        px_writeback_wrreq <= 1'b1;
        px_readout_rdreq   <= 1'b1;
    end
end

always @(posedge i_Clk) begin
    data_readout_rdreq <= 1'b0;
    data_writeback_wrreq <= 1'b0;
 
    if (!data_readout_fifo_empty && !data_writeback_fifo_full && reg_test[2] == 1'd0) begin
        data_writeback_wrreq <= 1'b1;
        data_readout_rdreq   <= 1'b1;
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
        countdown <= 8*READ_BURST_LENGTH - 1;
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
            data_data_address <= o_Data_Address == (22'h20000 + (480*1600 - 1)) ? 22'h20000 : data_data_address + 8*READ_BURST_LENGTH;
        end
        countdown <= countdown - 1'd1;
        o_Data_Address <= o_Data_Address + 1'd1;
    end
end

endmodule
