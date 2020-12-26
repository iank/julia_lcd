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
    output OE_N,
    output WE_N,
    output LB_N,
    output UB_N,
    output [18:0] ADDR,
    inout  [15:0] IO
);
    
    /* State machine */
    localparam STATE_RESET     = 3'd0;
    /* Write to SRAM (initialize) */
    localparam STATE_SRAMINIT  = 3'd1;
    /* Write to LCD from line buffer */
    localparam STATE_LCDWRITE  = 3'd2;
    /* Update line buffer from SRAM */
    localparam STATE_UPDATE    = 3'd3;
    /* Write line buffer contents back to SRAM */
    localparam STATE_WRITEBACK = 3'd4;


    /* Registers */
    // State machine
    reg [2:0] r_CurrentState = STATE_RESET;
    reg [2:0] r_NextState;

    // Current address (part) while copying SRAM to Line Buffer
    reg [9:0] r_SRAM2LBAddr;
    reg [9:0] r_NextSRAM2LBAddr;
    wire [9:0] LBRdAddr;
    
    // Current address while writing SRAM
    reg [18:0] r_SRAMWrAddr;
    reg [18:0] r_NextSRAMWrAddr;

    // Data write to SRAM
    reg [15:0] r_SRAMWrData = 16'd0;
    reg [15:0] r_NextSRAMWrData;
    wire [15:0] SRAMWrData;

    /* Wires */
    wire [15:0] SRAM2LBData;

    // Pixel counters from LCD
    wire [9:0] xpx;
    wire [9:0] ypx;

    wire LCDBegin;
    wire LineBufferWREN;

    // For SRAM
    wire [15:0] px_data;
    wire SRAMBegin;
    wire SRAMReady;
    wire SRAMWr;
    wire [18:0] SRAMAddr;
    
    /* PLL */
    pll PLL(
        .inclk0(CLK),
        .c0(LCDCLK)
    );
    
    /* SRAM address mux */
    mux18 SRAMAddrMux(
        .data0x({ypx[8:0], r_SRAM2LBAddr[9:0]}),
        .data1x(r_SRAMWrAddr),
        .sel(r_CurrentState == STATE_SRAMINIT),
        .result(SRAMAddr)
    );
    
    /* SRAM write data mux */
   mux16 SRAMDataMux(
        .data0x(px_data + 16'd100),
        .data1x(r_SRAMWrData),
        .sel(r_CurrentState == STATE_SRAMINIT),        
        .result(SRAMWrData)
    );
    
    mux10 LBRdAddrMux(
        .data0x(r_SRAM2LBAddr),
        .data1x(xpx),
        .data2x(r_SRAM2LBAddr + 10'd1),
        .sel({r_CurrentState == STATE_WRITEBACK, r_CurrentState == STATE_LCDWRITE}),
        .result(LBRdAddr)
    );
    
    
    /* SRAM */
    sram SRAM(
        // Inputs
        .i_CLK(LCDCLK),
        .i_Begin(SRAMBegin),
        .i_Write(SRAMWr),
        .i_Addr(SRAMAddr),
        .i_Data_f2s(SRAMWrData),

        // Outputs
        .o_Data_s2f(SRAM2LBData),
        .o_Ready(SRAMReady),

        // Physical signals
        .o_CS1_N(CS1_N),
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
        .i_RGB({px_data[15:11], 3'b00, px_data[10:5], 2'b00, px_data[4:0], 3'b000}),
        
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
    /*pwm backlightControl(
        .i_CLK(LCDCLK),
        .o_x(LIGHT)
    );*/
    assign LIGHT = 1'b1;
    
    /* Blockram for line buffer */
    blockram lineBuffer(
        .clock(LCDCLK),

        .rdaddress(LBRdAddr),
        .q(px_data),

        .wraddress(r_SRAM2LBAddr[9:0]),
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
                r_NextState = STATE_SRAMINIT;
                r_NextSRAMWrAddr = 19'd0;
                r_NextSRAMWrData = 16'd0;
            end
            STATE_SRAMINIT: begin
                if (r_SRAMWrAddr == 19'd512000) begin
                    r_NextState = STATE_LCDWRITE;
                end
                else if (SRAMReady) begin
                    r_NextSRAMWrAddr = r_SRAMWrAddr + 19'd1;
                    r_NextSRAMWrData = {r_SRAMWrAddr[18:17], 14'd0}; // {r_SRAMWrAddr[8:0], r_SRAMWrAddr[18:12]};
                end
            end
            STATE_LCDWRITE: begin
                if (~DEN) begin
                    r_NextState = STATE_UPDATE;
                    r_NextSRAM2LBAddr = 10'd0;
                end
            end
            STATE_UPDATE: begin
                if (r_SRAM2LBAddr == 10'd800) begin
                    r_NextState = STATE_WRITEBACK;
                    r_NextSRAM2LBAddr = 10'd0;
                end
                else if (SRAMReady) begin
                    r_NextSRAM2LBAddr = r_SRAM2LBAddr + 10'd1;
                end
            end
            STATE_WRITEBACK: begin
                if (DEN || r_SRAM2LBAddr == 10'd800) begin
                    r_NextState = STATE_LCDWRITE;
                end
                else if (SRAMReady) begin
                    r_NextSRAM2LBAddr = r_SRAM2LBAddr + 10'd1;
                end
            end
        endcase
    end
    
    assign LCDBegin = ~(r_CurrentState == STATE_RESET || r_CurrentState == STATE_SRAMINIT);
    assign LineBufferWREN = (r_CurrentState == STATE_UPDATE && SRAMReady);
    assign SRAMBegin = ((r_CurrentState == STATE_UPDATE && SRAMReady) || (r_CurrentState == STATE_SRAMINIT && SRAMReady) || (r_CurrentState == STATE_WRITEBACK && SRAMReady));
    assign SRAMWr = (r_CurrentState == STATE_SRAMINIT || r_CurrentState == STATE_WRITEBACK);
endmodule