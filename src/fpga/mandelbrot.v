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

reg [1:0] cmd_next = CMD_READ;

reg [7:0] countdown;

assign o_SDRAM_Yield = i_SDRAM_Requested && o_Command == CMD_IDLE;

wire [31:0] fifo_q;
assign o_Data_Write = fifo_q + 32'h01010101;
wire [3:0] usedw;
wire wrreq;
assign wrreq = o_Command == CMD_READ && i_Data_Read_Valid;

/* Read/writeback FIFO */
processor_fifo processor_fifo_inst (
    .clock (i_Clk),
    .data (i_Data_Read),
    .rdreq (i_Data_Write_Done),
    .usedw (usedw),
    .wrreq (wrreq),
    .q (fifo_q)
);

/* Memory control logic */
always @(posedge i_Clk) begin
    /* Read from SDRAM */
    if (o_Command == CMD_IDLE && ~i_SDRAM_Requested) begin
        o_Command <= cmd_next;
        countdown <= READ_BURST_LENGTH - 1;
        o_Data_Address <= read_data_address;
    end
    else if (o_Command == CMD_READ && i_Data_Read_Valid) begin
        if (countdown == 3'd0) begin
            o_Command <= CMD_IDLE;
            cmd_next  <= CMD_WRITE;
        end
        else
            countdown <= countdown - 1'd1;

        o_Data_Address <= o_Data_Address + 1'd1;
    end
 
    else if (o_Command == CMD_WRITE && i_Data_Write_Done) begin
        if (countdown == 3'd0) begin
            o_Command <= CMD_IDLE;
            cmd_next  <= CMD_READ;
            read_data_address <= o_Data_Address == (480*200 - 1) ? 22'd0 : read_data_address + READ_BURST_LENGTH;
        end
        else
            countdown <= countdown - 1'd1;

            o_Data_Address <= o_Data_Address + 1'd1;
    end
end

endmodule
