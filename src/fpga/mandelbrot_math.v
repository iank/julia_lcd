module mandelbrot_math(
    input i_Clk,

    input [71:0] i_Px_Data,
    input i_Read_Fifo_Empty,
    input i_Write_Fifo_Full,

    output [71:0] o_Px_Data,
    output o_Read_Fifo_Ack,
    output o_Write_Fifo_Wrreq
);

assign o_Write_Fifo_Wrreq = (~i_Read_Fifo_Empty & ~i_Write_Fifo_Full);
assign o_Read_Fifo_Ack = (~i_Read_Fifo_Empty & ~i_Write_Fifo_Full);

// TODO: calculate x,y indices

wire [7:0] i_Iteration = i_Px_Data[71:64];
wire [31:0] i_Xval = i_Px_Data[63:32];
wire [31:0] i_Yval = i_Px_Data[31:0];

reg [7:0] o_Iteration;
reg [31:0] o_Xval;
reg [31:0] o_Yval;

reg [9:0] cx = 10'd0;
reg [8:0] cy = 9'd0;

always @(posedge i_Clk) begin
    if (o_Read_Fifo_Ack) begin
        cx <= cx + 1'b1;
        if (cx + 1'b1 == 10'd800) begin
            cx <= 10'd0;
            cy <= cy + 1'b1;
            if (cy + 1'b1 == 9'd480) begin
                cy <= 9'd0;
            end
        end
    end
end


// 32 bits => Q5.27 two's complement
// Result is 64 bits.. Q10.54
// I want result[58:27]

// Increments
localparam signed [31:0] xinc   = 32'sb0_0000_000000011101000000101000100; // 5.666 / 800;
localparam signed [31:0] yinc   = 32'sb0_0000_000000011101000000110110101; // 3.400 / 480;

// Upper-left corner relative to origin (midpoint)
localparam signed [31:0] xstart = 32'sb1_1101_001010101100000010000011001; // 32'd0 - xinc * (800 / 2.0);
localparam signed [31:0] ystart = 32'sb1_1110_010011001100110011001100110; // 32'd0 - yinc * (480 / 2.0);


reg signed [31:0] x0,y0;
reg signed [31:0] x,y;
reg signed [63:0] x2,y2,xy;

always @(*) begin
    x = i_Xval;
    y = i_Yval;

    x0 = xstart + xinc*cx;
    y0 = ystart + yinc*cy;
    
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
        o_Iteration = i_Iteration;
        o_Xval = i_Xval;
        o_Yval = i_Yval;
    end
    // Not already escaped
    else begin      
        if (x2[58:27] + y2[58:27] > 32'sb0_0100_000000000000000000000000000 /* 4.0 */) begin
            o_Xval = 32'hFFFFFFFF;
            o_Yval = 32'hFFFFFFFF;
            o_Iteration = i_Iteration;
        end
        else begin
            o_Yval = (xy[58:27] << 1) + y0;
            o_Xval = x2[58:27] - y2[58:27] + x0;
            o_Iteration = i_Iteration + 1'b1;
        end
    end
end

assign o_Px_Data = { o_Iteration, o_Xval, o_Yval };


endmodule