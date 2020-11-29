module tftlcd(
    input i_CLK,
    input [23:0] i_RGB,
    input i_Begin,
    
    /* Physical outputs */
    output [7:0] R,
    output [7:0] G,
    output [7:0] B,
    output STBYB,
    output HSD,
    output VSD,
    output DEN,
    
    /* Internal outputs */
    output [15:0] o_XPx,
    output [15:0] o_YPx
);

    /* State definitions */
    localparam STATE_RESET = 1'd0;
    localparam STATE_DATA  = 1'd1;
    
    /* Dimensions and timing */
    localparam Y_BP   = 40;     // Back porch
    localparam Y_PX   = 480;    // Data
    localparam Y_FP   = 40;     // Front porch

    localparam X_BP   = 100;    // Back porch
    localparam X_PX   = 800;    // Data
    localparam X_FP   = 1600;   // Front porch
    
    /* State registers */
    reg       r_CurrentState = STATE_RESET;
    reg       r_NextState = STATE_RESET;
    reg [15:0] r_CounterX;
    reg [15:0] r_CounterY;
    reg [23:0] r_RGB;
    reg [23:0] r_RGBNext;
    
    /* Internal wires */
    wire CounterYMax = (r_CounterY == (Y_BP + Y_PX + Y_FP - 1));
    wire CounterXMax = (r_CounterX == (X_BP + X_PX + X_FP - 1));
    
    wire VData = (r_CounterY >= (0) && r_CounterY < (Y_PX));
    wire HData = (r_CounterX >= (0) && r_CounterX < (X_PX));

    wire DataEnable  = VData & HData;

    /* Counters */
    
    always @(posedge i_CLK) begin
        if (r_CurrentState == STATE_RESET) begin
            r_CounterX <= 16'd0;
            r_CounterY <= 16'd0;
        end
        else begin
            if (CounterXMax) begin
                r_CounterX <= 0;
                if (CounterYMax) begin
                    r_CounterY <= 0;
                end
                else
                    r_CounterY <= r_CounterY + 16'd1;
            end
            else
                r_CounterX <= r_CounterX + 16'd1;
        end
    end

    always @(posedge i_CLK) begin
        r_RGB <= r_RGBNext;
    end

    /* State transitions */
    always @(posedge i_CLK) begin
        r_CurrentState <= r_NextState;
    end

    always @(*) begin
        r_NextState = r_CurrentState;
        r_RGBNext = r_RGB;
        case (r_CurrentState)
            STATE_RESET: begin
                if (i_Begin)
                    r_NextState = STATE_DATA;
            end
            STATE_DATA: begin
                r_NextState = STATE_DATA;
                r_RGBNext   = i_RGB;
            end
        endcase
    end

    /* Dynamic Outputs */
    assign STBYB = ~(r_CurrentState == STATE_RESET);  // 1 = Normal operation, 0 = Standby mode
    assign VSD   = ~(r_CurrentState == STATE_RESET);
    assign HSD   = ~(r_CurrentState == STATE_RESET);
    assign DEN    = DataEnable;
    
    assign o_XPx = r_CounterX;
    assign o_YPx = r_CounterY;

    assign R = r_RGB[23:16];
    assign G = r_RGB[15:8];
    assign B = r_RGB[7:0];
endmodule