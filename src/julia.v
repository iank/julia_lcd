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
    reg [9:0] r_LineBufferAddr;
    reg [9:0] r_NextLineBufferAddr;
    wire [9:0] LBRdAddr;
    
    // Current address while writing SRAM
    reg [18:0] r_SRAMInitAddr;
    reg [18:0] r_NextSRAMInitAddr;

    // Data write to SRAM
    wire [15:0] SRAMInitData;
    wire [15:0] SRAMWrData;

    /* Wires */
    wire [15:0] SRAM2LBData;

    // Pixel counters from LCD
    wire [9:0] xpx;
    wire [9:0] ypx;

    wire LCDBegin;
    wire LineBufferWREN;
    
    reg [15:0] r_Iteration;
    reg [15:0] r_NextIteration;

    // For SRAM
    wire [15:0] LB_data;
    wire [23:0] px_data;
    wire [15:0] writeback_data;
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
        .data0x({ypx[8:0], r_LineBufferAddr[9:0]}),     /* Generally track LineBuffer / y-pixel */
        .data1x(r_SRAMInitAddr),                        /* Something else during initialization */
        .sel(r_CurrentState == STATE_SRAMINIT),
        .result(SRAMAddr)
    );
    
    /* SRAM write data mux */
    mux16 SRAMDataMux(
        .data0x(writeback_data),                        /* Writeback based on value read into linebuffer */
        .data1x(SRAMInitData),                          /* Something else during initialization */
        .sel(r_CurrentState == STATE_SRAMINIT),
        .result(SRAMWrData)
    );
    
    /* LineBuffer address mux */
    mux10 LBRdAddrMux(
        .data0x(r_LineBufferAddr),                      /* UPDATE: we control the sweep */
        .data1x(xpx),                                   /* LCDWRITE: track tftlcd */
        .data2x(r_LineBufferAddr + 10'd3),              /* WRITEBACK: lag by 1 */
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
        .i_RGB(px_data),
        
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
    
    /* Computes initial SRAM values by address */
    sramInit SRAMInitializer(
        .i_Addr(r_SRAMInitAddr),
        .o_Data(SRAMInitData)
    );
    
    /* Computes display data based on complex number stored in SRAM */
    complexFunction displayFunction(
        .i_Complex(LB_data),
        .i_Iteration(r_Iteration),
        .o_PXData(px_data),
        .o_Writeback(writeback_data)
    );
    
    /* Blockram for line buffer */
    blockram lineBuffer(
        .clock(LCDCLK),

        .rdaddress(LBRdAddr),
        .q(LB_data),

        .wraddress(r_LineBufferAddr),
        .data(SRAM2LBData),
        .wren(LineBufferWREN)
    );

    /* State machine */
    always @(posedge LCDCLK) begin
        r_CurrentState   <= r_NextState;
        r_LineBufferAddr <= r_NextLineBufferAddr;
        r_SRAMInitAddr   <= r_NextSRAMInitAddr;
        r_Iteration      <= r_NextIteration;
    end

    // Transitions
    always @(*) begin
        r_NextState          = r_CurrentState;
        r_NextLineBufferAddr = r_LineBufferAddr;
        r_NextSRAMInitAddr   = r_SRAMInitAddr;
        r_NextIteration      = r_Iteration;

        case (r_CurrentState)
            STATE_RESET: begin
                /* Immediately transition to init */
                r_NextState = STATE_SRAMINIT;
                r_NextSRAMInitAddr = 19'd0;
                r_NextIteration = 16'd0;
            end
            STATE_SRAMINIT: begin
                /* Transition to LCDWRITE once we've written the entire thing */
                if (r_SRAMInitAddr == 19'd512000) begin
                    r_NextState = STATE_LCDWRITE;
                end
                /* Otherwise advance address and data whenever SRAM is ready */
                else if (SRAMReady) begin
                    r_NextSRAMInitAddr = r_SRAMInitAddr + 19'd1;
                end
            end
            STATE_LCDWRITE: begin
                /* Idle here until LCD is done with a line */
                if (~DEN) begin
                    r_NextState = STATE_UPDATE;
                    r_NextLineBufferAddr = 10'd0;
                end
            end
            STATE_UPDATE: begin
                /* Update a single line from SRAM, then move to writeback */
                if (r_LineBufferAddr == 10'd800) begin
                    r_NextState = STATE_WRITEBACK;
                    r_NextLineBufferAddr = 10'd0;
                end
                /* Advance address to read whenever SRAM is ready */
                else if (SRAMReady) begin
                    r_NextLineBufferAddr = r_LineBufferAddr + 10'd1;
                end
            end
            STATE_WRITEBACK: begin
                /* Back to LCDWRITE when we are finished writing this line back, or we run out of time */
                if (DEN || r_LineBufferAddr == 10'd800) begin
                    r_NextState = STATE_LCDWRITE;
                    r_NextIteration = r_Iteration + 16'd1;
                end
                /* Advance address to write whenever SRAM is ready */
                else if (SRAMReady) begin
                    r_NextLineBufferAddr = r_LineBufferAddr + 10'd1;
                end
            end
        endcase
    end
    
    /* Start LCD once we're out of init */
    assign LCDBegin = ~(r_CurrentState == STATE_RESET || r_CurrentState == STATE_SRAMINIT);
    
    /* Write to LineBuffer during UPDATE */
    assign LineBufferWREN = (r_CurrentState == STATE_UPDATE && SRAMReady);
    
    /* Begin SRAM txn when appropriate in UPDATE, SRAMINIT, and WRITEBACK */
    assign SRAMBegin = ((r_CurrentState == STATE_UPDATE && SRAMReady) || (r_CurrentState == STATE_SRAMINIT && SRAMReady) || (r_CurrentState == STATE_WRITEBACK && SRAMReady));
    
    /* Write SRAM in SRAMINIT and WRITEBACK, otherwise read */
    assign SRAMWr = (r_CurrentState == STATE_SRAMINIT || r_CurrentState == STATE_WRITEBACK);

    /* Backlight control */
    assign LIGHT = 1'b1;
endmodule