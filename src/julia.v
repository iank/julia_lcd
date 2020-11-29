module julia(
    input CLK, // 50 MHz clock

    /* LCD outputs */
    output [7:0] R,
    output [7:0] G,
    output [7:0] B,
    output LCDCLK,
    output STBYB,
    output HSD,
    output VSD,
    output DEN,
    output LIGHT,
    
    /* SRAM I/O */
    output CS1_N,
    output CS2,
    output OE_N,
    output WE_N,
    output LB_N,
    output UB_N,
    output [17:0] ADDR,
    inout  [15:0] IO
);
    
    /* State machine */
    localparam STATE_RESET     = 3'd0;
    /* Write to SRAM */
    localparam STATE_SRAMWR1   = 3'd1;
    localparam STATE_SRAMWR2   = 3'd2;
    /* Write to LCD from line buffer */
    localparam STATE_LCDWRITE  = 3'd3;
    /* Update line buffer from SRAM */
    localparam STATE_UPDATE1   = 3'd4;
    localparam STATE_UPDATE2   = 3'd5;

    /* Registers */
    // State machine
    reg [2:0] r_CurrentState = STATE_RESET;
    reg [2:0] r_NextState;

    // Current address (part) while copying SRAM to Line Buffer
    reg [9:0] r_SRAM2LBAddr;
    reg [9:0] r_NextSRAM2LBAddr;
    
    // Current address while writing SRAM
    reg [17:0] r_SRAMWrAddr;
    reg [17:0] r_NextSRAMWrAddr;

    // Data write to SRAM
    reg [15:0] r_SRAMWrData = 16'd0;
    reg [15:0] r_NextSRAMWrData;

    /* Wires */
    wire [15:0] SRAM2LBData;

    // Pixel counters from LCD
    wire [9:0] xpx;
    wire [9:0] ypx;

    wire LCDBegin;
    wire LineBufferWREN;

    // For SRAM
    wire [7:0] px_data;
    wire SRAMBegin;
    wire SRAMReady;
    wire SRAMWr;
    wire [17:0] SRAMAddr;
    
    /* PLL */
    pll PLL(
        .inclk0(CLK),
        .c0(LCDCLK)
    );
    
    /* SRAM address mux */
    mux18 SRAMAddrMux(
        .data0x({ypx[8:0], r_SRAM2LBAddr[9:1]}),
        .data1x(r_SRAMWrAddr),
        .sel(SRAMWr),
        .result(SRAMAddr)
    );
    
    /* SRAM */
    sram SRAM(
        // Inputs
        .i_CLK(LCDCLK),
        .i_Begin(SRAMBegin),
        .i_Write(SRAMWr),
        .i_Addr(SRAMAddr),
        .i_Data_f2s(r_SRAMWrData),

        // Outputs
        .o_Data_s2f(SRAM2LBData),
        .o_Ready(SRAMReady),

        // Physical signals
        .o_CS1_N(CS1_N),
        .o_CS2(CS2),
        .o_OE_N(OE_N),
        .o_WE_N(WE_N),
        .o_LB_N(LB_N),
        .o_UB_N(UB_N),
        .o_Addr(ADDR),
        .io_IO(IO)
    );
    
    /* LCD */
    tftlcd LCD(
        // Inputs
        .i_CLK(LCDCLK),
        .i_Begin(LCDBegin),
        .i_RGB({px_data[7:5], 5'b00000, px_data[4:2], 5'b00000, px_data[1:0], 6'b000000}),
        
        // Outputs
        .o_XPx(xpx),
        .o_YPx(ypx),
        
        // Physical signals
        .R(R), .G(G), .B(B),
        .STBYB(STBYB),
        .HSD(HSD),
        .VSD(VSD),
        .DEN(DEN)
    );

    /* Backlight control */
    pwm backlightControl(
        .i_CLK(LCDCLK),
        .o_x(LIGHT)
    );
    
    /* Blockram for line buffer */
    blockram lineBuffer(
        .clock(LCDCLK),

        .rdaddress(xpx),
        .q(px_data),

        .wraddress(r_SRAM2LBAddr[9:1]),
        .data(SRAM2LBData),
        .wren(LineBufferWREN)
    );

    /* State machine */
    always @(posedge LCDCLK) begin
        r_CurrentState <= r_NextState;
        r_SRAM2LBAddr  <= r_NextSRAM2LBAddr;
        r_SRAMWrData   <= r_NextSRAMWrData;
        r_SRAMWrAddr   <= r_NextSRAMWrAddr;
    end

    // Transitions
    always @(*) begin
        r_NextState       = r_CurrentState;
        r_NextSRAM2LBAddr = r_SRAM2LBAddr;
        r_NextSRAMWrData  = r_SRAMWrData;
        r_NextSRAMWrAddr  = r_SRAMWrAddr;

        case (r_CurrentState)
            STATE_RESET: begin
                r_NextState = STATE_SRAMWR1;
                r_NextSRAMWrAddr = 18'd0;
                r_NextSRAMWrData = 16'd0;
            end
            STATE_SRAMWR1: begin
                r_NextState = STATE_SRAMWR2;
            end
            STATE_SRAMWR2: begin
                if (r_SRAMWrAddr == 18'd262143) begin
                    r_NextState = STATE_LCDWRITE;
                end
                else if (SRAMReady) begin
                    r_NextState = STATE_SRAMWR1;
                    r_NextSRAMWrAddr = r_SRAMWrAddr + 18'd1;
                    r_NextSRAMWrData = {r_SRAMWrAddr[7:0],r_SRAMWrAddr[7:0]};
                end
            end
            STATE_LCDWRITE: begin
                if (~DEN) begin
                    r_NextState = STATE_UPDATE1;
                    r_NextSRAM2LBAddr = 10'd0;
                end
            end
            STATE_UPDATE1: begin
                r_NextState = STATE_UPDATE2;
            end
            STATE_UPDATE2: begin
                if (DEN) begin
                    r_NextState = STATE_LCDWRITE;
                end
                else if (SRAMReady) begin
                    r_NextState = STATE_UPDATE1;
                    r_NextSRAM2LBAddr = r_SRAM2LBAddr + 10'd2;
                end
            end
        endcase
    end
    
    assign LCDBegin = ~(r_CurrentState == STATE_RESET || r_CurrentState == STATE_SRAMWR1 || r_CurrentState == STATE_SRAMWR2);
    assign LineBufferWREN = (r_CurrentState == STATE_UPDATE2);
    assign SRAMBegin = (r_CurrentState == STATE_UPDATE1 || r_CurrentState == STATE_SRAMWR1);
    assign SRAMWr = (r_CurrentState == STATE_SRAMWR1 || r_CurrentState == STATE_SRAMWR2);
endmodule