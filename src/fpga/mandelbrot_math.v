module mandelbrot_math(
    input i_Clk,

    input [71:0] i_Px_Data,
    input i_Read_Fifo_Empty,
    input i_Write_Fifo_Full,

    output [71:0] o_Px_Data,
    output o_Read_Fifo_Ack,
    output o_Write_Fifo_Wrreq
);

// Mock processor

assign o_Write_Fifo_Wrreq = (~i_Read_Fifo_Empty & ~i_Write_Fifo_Full);
assign o_Read_Fifo_Ack = (~i_Read_Fifo_Empty & ~i_Write_Fifo_Full);

assign o_Px_Data = {
    i_Px_Data[71:64] + 8'h01,
    i_Px_Data[63:56] + 8'h10,
    i_Px_Data[55:48] + 8'h20,
    i_Px_Data[47:40] + 8'h30,
    i_Px_Data[39:32] + 8'h40,
    i_Px_Data[31:24] + 8'h14,
    i_Px_Data[23:16] + 8'h25,
    i_Px_Data[15:8]  + 8'h36,
    i_Px_Data[7:0]   + 8'h47
};

endmodule



