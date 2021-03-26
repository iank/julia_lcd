module mandelbrot_math(
    input i_Clk,

    input [103:0] i_Px_Data,
    input i_Read_Fifo_Empty,
    input i_Write_Fifo_Full,
    input [1:0] i_Draw,

    output [103:0] o_Px_Data,
    output o_Read_Fifo_Ack,
    output o_Write_Fifo_Wrreq
);

`include "draw.vh"

assign o_Write_Fifo_Wrreq = (~i_Read_Fifo_Empty & ~i_Write_Fifo_Full);
assign o_Read_Fifo_Ack = (~i_Read_Fifo_Empty & ~i_Write_Fifo_Full);

wire [7:0] i_PxVal = i_Px_Data[103:96];
wire [31:0] i_Xval = i_Px_Data[95:64];
wire [31:0] i_Yval = i_Px_Data[63:32];
wire [31:0] i_Iteration = i_Px_Data[31:0];

reg [7:0] o_PxVal;
reg [31:0] o_Xval;
reg [31:0] o_Yval;
reg [31:0] o_Iteration;

reg [9:0] px_x = 10'd0;
reg [8:0] px_y = 9'd0;

always @(posedge i_Clk) begin
    if (o_Read_Fifo_Ack) begin
        px_x <= px_x + 1'b1;
        if (px_x + 1'b1 == 10'd800) begin
            px_x <= 10'd0;
            px_y <= px_y + 1'b1;
            if (px_y + 1'b1 == 9'd480) begin
                px_y <= 9'd0;
            end
        end
    end
end


// 32 bits => Q5.27 two's complement
// Result is 64 bits.. Q10.54
// Products in result[58:27]

// Increments
localparam signed [31:0] xinc   = 32'sb0_0000_000000011101000000101000100; // 5.666 / 800;
localparam signed [31:0] yinc   = 32'sb0_0000_000000011101000000110110101; // 3.400 / 480;

// Upper-left corner relative to origin (midpoint)
localparam signed [31:0] xstart = 32'sb1_1101_001010101100000010000011001; // 32'd0 - xinc * (800 / 2.0);
localparam signed [31:0] ystart = 32'sb1_1110_010011001100110011001100110; // 32'd0 - yinc * (480 / 2.0);

// C value for julia set

// xinc = 0.0070825
// yinc = 0.00708333333

// upper left corner is -2.83300, -1.69999999

// -0.79, 0.15 -> px val 288.46, 261.1
// try 288, 261. origin + pxval*inc = -0.79324, 0.14875

//localparam signed [31:0] cx = 32'sb1_1111_001101011100001010001111011;  // -0.79
//localparam signed [31:0] cy = 32'sb0_0000_001001100110011001100110011;  //  0.15

//localparam signed [31:0] cx = 32'sb1_1111_001101001110111000111001001;  // -0.79324
//localparam signed [31:0] cy = 32'sb0_0000_001001100001010001111010111;  //  0.14875

localparam touch_cx = 288;
localparam touch_cy = 261;

reg signed [31:0] cx = xstart + touch_cx * xinc;
reg signed [31:0] cy = ystart + touch_cy * yinc; 

reg signed [31:0] x0,y0;
reg signed [31:0] x,y;
reg signed [63:0] x2,y2,xy;

always @(*) begin
    x = i_Xval;
    y = i_Yval;

    x0 = xstart + xinc*px_x;
    y0 = ystart + yinc*px_y;
    
    // Needs initialization?
    if (i_Xval == 32'h00000000)
        x = x0;
    if (i_Yval == 32'h00000000)
        y = y0;

    x2 = x*x;
    y2 = y*y; 
    xy = x*y;
       
    // Already escaped?
    if (i_Xval == 32'hFFFFFFFF && i_Yval == 32'hFFFFFFFF) begin
        if (i_Draw == DRAW_CLEAR) begin
            o_PxVal = {i_PxVal[7], 7'h0};
            o_Xval = 32'h00000000;
            o_Yval = 32'h00000000;
            o_Iteration = 32'h0;
        end
        else begin
            o_PxVal = i_PxVal;
            o_Xval = i_Xval;
            o_Yval = i_Yval;
            o_Iteration = i_Iteration;
        end
    end
    // Not already escaped
    else begin      
        if (x2[58:27] + y2[58:27] > 32'sb0_0100_000000000000000000000000000 /* 4.0 */) begin
            if (i_Draw == DRAW_MANDELBROT) begin
                o_Xval = 32'hFFFFFFFF;
                o_Yval = 32'hFFFFFFFF;
                o_PxVal = 8'h00;
                o_Iteration = i_Iteration;
            end
            else if (i_Draw == DRAW_JULIA) begin
                o_Xval = 32'hFFFFFFFF;
                o_Yval = 32'hFFFFFFFF;
                o_PxVal = {i_PxVal[7], i_Iteration[6:0]};
                o_Iteration = i_Iteration;
            end
            else begin // i_Draw == DRAW_CLEAR
                o_Xval = 32'h00000000;
                o_Yval = 32'h00000000;
                o_PxVal = {i_PxVal[7], 7'h0};
                o_Iteration = 32'h0;
            end
        end
        else begin
            if (i_Draw == DRAW_MANDELBROT) begin
                o_Yval = (xy[58:27] << 1) + y0;
                o_Xval = x2[58:27] - y2[58:27] + x0;
                o_Iteration = i_Iteration + 1'b1;
                o_PxVal = 8'h80;
            end
            else if (i_Draw == DRAW_JULIA) begin
                o_Yval = (xy[58:27] << 1) + cy;
                o_Xval = x2[58:27] - y2[58:27] + cx;
                o_Iteration = i_Iteration + 1'b1;
                o_PxVal = {i_PxVal[7], 7'h7F};
            end
            else begin // i_Draw == DRAW_CLEAR
                o_Yval = 32'h00000000;
                o_Xval = 32'h00000000;
                o_Iteration = 32'h0;
                o_PxVal = {i_PxVal[7], 7'h0};
            end
        end
    end
end

assign o_Px_Data = { o_PxVal, o_Xval, o_Yval, o_Iteration };


endmodule