module mandelbrot(
    input i_Clk,

    input i_Data_Read_Valid,
    input i_Data_Write_Done,
    input [31:0] i_Data_Read,
 
    input i_SDRAM_Requested,
    output o_SDRAM_Yield,

    output reg [1:0] o_Command,
    output reg [21:0] o_Data_Address,
    output reg [31:0] o_Data_Write,

    output reg it_worked
);

`include "sdram.vh"

initial o_Command = CMD_IDLE;
initial o_Data_Address = 22'd0;
initial it_worked = 1'b0;

initial o_Data_Write = 32'b0;

reg [7:0] countdown;

assign o_SDRAM_Yield = i_SDRAM_Requested && o_Command == CMD_IDLE;

/* Memory control logic */
always @(posedge i_Clk) begin
     /* Read from SDRAM */
    if (o_Command == CMD_IDLE && ~i_SDRAM_Requested) begin
        o_Command <= CMD_READ;
        countdown <= READ_BURST_LENGTH - 1;
    end
    else if (o_Command == CMD_READ && i_Data_Read_Valid) begin
        it_worked <= 1'b1;
        if (countdown == 3'd0) begin
            o_Command <= CMD_IDLE;
        end
        else
            countdown <= countdown - 1'd1;

        o_Data_Address <= o_Data_Address == (480*200 - 1) ? 22'd0 : o_Data_Address + 1'd1;
    end
end

endmodule
