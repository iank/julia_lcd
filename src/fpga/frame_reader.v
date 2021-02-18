module frame_reader(
    input i_Clk,
    input i_Begin,

    input i_Data_Read_Valid,
    input [9:0] i_Pixel_In_Used,
 
    input i_SDRAM_Grant,

    output reg [1:0] o_Command,
    output reg [21:0] o_Data_Address,
    output o_FIFO_Wr,
    output o_SDRAM_Request,

    output reg o_First_Data_Ready
);

`include "sdram.vh"

initial o_Command = CMD_IDLE;
initial o_Data_Address = 22'd0;

reg fifo_filling = 1'b0;
wire fifo_low_threshold, fifo_high_threshold;
initial o_First_Data_Ready = 1'b0;
reg [7:0] countdown;

assign fifo_low_threshold = (i_Pixel_In_Used <= 256);
assign fifo_high_threshold = (i_Pixel_In_Used >= (1024 - READ_BURST_LENGTH));
assign o_FIFO_Wr = o_Command == CMD_READ && i_Data_Read_Valid;

assign o_SDRAM_Request = (fifo_low_threshold && !fifo_filling) || (fifo_filling && !fifo_high_threshold) || (o_Command != CMD_IDLE);

/* Memory control logic */
always @(posedge i_Clk) begin
     /* Read from SDRAM */
    if (o_Command == CMD_IDLE && i_Begin && i_SDRAM_Grant) begin
        if ((fifo_low_threshold && !fifo_filling) || (fifo_filling && !fifo_high_threshold)) begin
            fifo_filling <= 1'b1;
            o_Command <= CMD_READ;
            countdown <= READ_BURST_LENGTH - 1;
        end
    end
    else if (o_Command == CMD_READ && i_Data_Read_Valid) begin
        if (countdown == 3'd0) begin
            o_Command <= CMD_IDLE;
            o_First_Data_Ready <= 1'b1;
        end
        else
            countdown <= countdown - 1'd1;

        o_Data_Address <= o_Data_Address == (480*200 - 1) ? 22'd0 : o_Data_Address + 1'd1;
    end
    if (fifo_filling && fifo_high_threshold)
        fifo_filling <= 1'b0;
end

endmodule
