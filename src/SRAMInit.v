module sramInit(
    input  [18:0] i_Addr,
    output [15:0] o_Data
);
    localparam WIDTH = 800;
    localparam HEIGHT = 480;

    wire [8:0] ypx;
    wire [9:0] xpx;

    assign ypx = i_Addr[18:10];
    assign xpx = i_Addr[9:0];
    
    // We'll store in SRAM 16-bit values, MSB is done flag,
    // remaining 15 bits are iteration count (done = 1) or
    // two fixed-point numbers: x (8 bits) and y (7 bits)
    
    // Next revision will use a 32-bit wide DDR..
    
    // x format:
    // 8'sb0_000_0000
    // y format:
    // 7'sb0_000_000
    
    localparam signed[17:0] X_INC = 18'sb0_000_00000001110100; // 5.666 / 800
    localparam signed[17:0] Y_INC = 18'sb0_000_00000001110100; // 3.400 / 480
    localparam signed[17:0] y_lookat = 18'sb0_000_00000000000000; // 0
    localparam signed[17:0] x_lookat = 18'sb0_000_00000000000000; // 0
    
    wire signed[17:0] x_start, y_start;     // Upper-left corner in complex plane
    assign x_start = x_lookat - X_INC * (WIDTH  >> 1);
    assign y_start = y_lookat - Y_INC * (HEIGHT >> 1);
    
    wire signed[17:0] x0, y0;
    assign x0 = x_start + X_INC * xpx;
    assign y0 = y_start + Y_INC * ypx;
    
    assign o_Data = {1'b0, x0[17:10], y0[17:11]};
endmodule