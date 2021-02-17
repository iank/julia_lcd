module mem_init(
    input i_Clk,

    input i_Data_Write_Done,

    output reg [1:0] o_Command,
    output reg [21:0] o_Data_Address,
    output reg [31:0] o_Data_Write,

    output reg o_SDRAM_Initialized
);

`include "sdram.vh"

initial o_Command = CMD_IDLE;
initial o_Data_Address = 22'd0;
initial o_Data_Write = 32'd0;
initial o_SDRAM_Initialized = 1'd0;
reg [7:0] countdown;

/* Memory control logic */
always @(posedge i_Clk) begin
    /* Initialize SDRAM */
    if (o_Command == CMD_IDLE && !o_SDRAM_Initialized) begin
        o_Command <= CMD_WRITE;
        o_Data_Write <= {4{o_Data_Address[7:0]}};
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
            o_SDRAM_Initialized <= 1'b1;
        end
    end
end


endmodule
