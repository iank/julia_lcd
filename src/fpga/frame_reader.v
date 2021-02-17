module frame_reader(
    input i_Clk,

    input i_Data_Read_Valid,
    input i_Data_Write_Done,

    input [9:0] i_Pixel_In_Used,

    output reg [1:0] o_Command,
    output reg [21:0] o_Data_Address,
    output reg [31:0] o_Data_Write,
    output o_FIFO_Wr,

    output reg o_First_Data_Ready
);

`include "sdram.vh"

initial o_Command = 2'd0;
initial o_Data_Address = 22'd0;
initial o_Data_Write = 32'd0;

reg fifo_filling = 1'b0;
wire fifo_low_threshold, fifo_high_threshold;
initial o_First_Data_Ready = 1'b0;
reg o_SDRAM_Init_Complete = 1'd0;
reg [7:0] countdown;

assign fifo_low_threshold = (i_Pixel_In_Used <= 256);
assign fifo_high_threshold = (i_Pixel_In_Used >= (1024 - READ_BURST_LENGTH));
assign o_FIFO_Wr = o_Command == CMD_READ && i_Data_Read_Valid;

/* Memory control logic */
always @(posedge i_Clk) begin
    /* Initialize SDRAM */
    if (o_Command == CMD_IDLE && !o_SDRAM_Init_Complete) begin
        o_Command <= CMD_WRITE;
        o_Data_Write <= {10'b1111111100, o_Data_Address};
        countdown <= READ_BURST_LENGTH - 1;
    end
    else if (o_Command == CMD_WRITE && i_Data_Write_Done) begin
        if (countdown == 3'd0)
            o_Command <= CMD_IDLE;
        else
            countdown <= countdown - 1'd1;
             
        o_Data_Address <= o_Data_Address + 1'd1;
        o_Data_Write <= {4{o_Data_Address[7:0] + 1'd1}};

//      if (o_Data_Address + 1'd1 == 22'd0) begin 
        if (o_Data_Address + 1'd1 == (480*200)) begin
            o_Data_Address <= 0;
            o_SDRAM_Init_Complete <= 1'b1;
        end
    end
     /* Read back from SDRAM */
    else if (o_Command == CMD_IDLE && o_SDRAM_Init_Complete) begin
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
