module mandelbrot(
    input i_Clk,

    input i_Data_Read_Valid,
    input i_Data_Write_Done,
    input [31:0] i_Data_Read,
 
    input i_SDRAM_Requested,
    output o_SDRAM_Yield,

    output reg [1:0] o_Command,
    output reg [21:0] o_Data_Address,
    output [31:0] o_Data_Write
);

`include "sdram.vh"

initial o_Command = CMD_IDLE;

reg [21:0] read_data_address = 22'd0;
initial o_Data_Address = 22'd0;


reg [7:0] countdown;

assign o_SDRAM_Yield = i_SDRAM_Requested && o_Command == CMD_IDLE;

wire readout_wrreq;
assign readout_wrreq = o_Command == CMD_READ && i_Data_Read_Valid;
wire writeback_rdreq;
assign writeback_rdreq = o_Command == CMD_WRITE && i_Data_Write_Done;

reg readout_rdreq = 1'b0;
reg writeback_wrreq = 1'b0;

wire readout_fifo_full, readout_fifo_empty;
wire writeback_fifo_full, writeback_fifo_empty;

wire [31:0] readout_to_writeback;

/* Read/writeback FIFO */
processor_fifo_ack readout_fifo (
    .clock (i_Clk),
    .data (i_Data_Read),
    .rdreq (readout_rdreq),
    .wrreq (readout_wrreq),
    .full (readout_fifo_full),
    .empty (readout_fifo_empty),
    .q (readout_to_writeback)
);

processor_fifo_ack writeback_fifo (
    .clock (i_Clk),
    .data (readout_to_writeback + 32'h01010101),
    .rdreq (writeback_rdreq),
    .wrreq (writeback_wrreq),
    .full (writeback_fifo_full),
    .empty (writeback_fifo_empty),
    .q (o_Data_Write)
);


/* Memory control logic */
always @(posedge i_Clk) begin
    /* "process" between fifos */
    readout_rdreq <= 1'b0;
    writeback_wrreq <= 1'b0;
    if (!readout_fifo_empty && !writeback_fifo_full) begin
        writeback_wrreq <= 1'b1;
        readout_rdreq   <= 1'b1;
    end

    /* Read from SDRAM */
    if (o_Command == CMD_IDLE && ~i_SDRAM_Requested) begin
        if (readout_fifo_empty && writeback_fifo_empty)
            o_Command <= CMD_READ;
        else if (writeback_fifo_full)
            o_Command <= CMD_WRITE;
        else
            o_Command <= CMD_IDLE;

        countdown <= READ_BURST_LENGTH - 1;
        o_Data_Address <= read_data_address;
    end
    else if (o_Command == CMD_READ && i_Data_Read_Valid) begin
        if (countdown == 3'd0) begin
            o_Command <= CMD_IDLE;
        end
        else
            countdown <= countdown - 1'd1;

        o_Data_Address <= o_Data_Address + 1'd1;
    end
 
    else if (o_Command == CMD_WRITE && i_Data_Write_Done) begin
        if (countdown == 3'd0) begin
            o_Command <= CMD_IDLE;
            read_data_address <= o_Data_Address == (480*200 - 1) ? 22'd0 : read_data_address + READ_BURST_LENGTH;
        end
        else
            countdown <= countdown - 1'd1;

            o_Data_Address <= o_Data_Address + 1'd1;
    end
end

endmodule
