module tftlcd
#(
    /* Dimensions and timing */
    parameter Y_BP   = 2,     // Back porch
    parameter Y_PX   = 480,   // Data
    parameter Y_FP   = 2,     // Front porch

    parameter X_BP   = 100,    // Back porch
    parameter X_PX   = 800,    // Data
    parameter X_FP   = 1000,   // Front porch

    parameter DATA_WIDTH = 24,
    parameter X_COUNTER_WIDTH = log2ceil(X_BP+X_PX+X_FP),
    parameter Y_COUNTER_WIDTH = log2ceil(Y_BP+Y_PX+Y_FP) 
)
(
    input i_CLK,
    input [(DATA_WIDTH-1):0] i_RGB,
    input i_Begin,

    output [(X_COUNTER_WIDTH-1):0] o_XPx,
    output [(Y_COUNTER_WIDTH-1):0] o_YPx,

    /* Physical outputs */
    output [(DATA_WIDTH-1):0] RGB,
    output STBYB,
    output HSD,
    output VSD,
    output DEN
);
    /* State definitions */
    localparam STATE_RESET = 1'd0;
    localparam STATE_DATA  = 1'd1;
    
    /* State registers */
    reg       r_CurrentState = STATE_RESET;
    reg       r_NextState = STATE_RESET;
    reg [(X_COUNTER_WIDTH-1):0] r_CounterX;
    reg [(Y_COUNTER_WIDTH-1):0] r_CounterY;
    reg [(DATA_WIDTH-1):0] r_RGB;
    reg [(DATA_WIDTH-1):0] r_RGBNext;
    
    /* Internal wires */
    wire CounterYMax = (r_CounterY == (Y_BP + Y_PX + Y_FP - 1));
    wire CounterXMax = (r_CounterX == (X_BP + X_PX + X_FP - 1));
    
    wire VData = (r_CounterY >= (0) && r_CounterY < (Y_PX));
    wire HData = (r_CounterX >= (0) && r_CounterX < (X_PX));

    wire DataEnable  = VData & HData & (r_CurrentState == STATE_DATA);

    /* Counters */
    always @(negedge i_CLK) begin
        if (r_CurrentState == STATE_RESET) begin
            r_CounterX <= 0;
            r_CounterY <= 0;
        end
        else begin
            if (CounterXMax) begin
                r_CounterX <= 0;
                if (CounterYMax) begin
                    r_CounterY <= 0;
                end
                else
                    r_CounterY <= r_CounterY + {{(Y_COUNTER_WIDTH-1){1'b0}}, 1'b1};
            end
            else
                r_CounterX <= r_CounterX + {{(X_COUNTER_WIDTH-1){1'b0}}, 1'b1};
        end
    end

    always @(negedge i_CLK) begin
        r_RGB <= r_RGBNext;
    end

    /* State transitions */
    always @(negedge i_CLK) begin
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
    
    assign RGB = r_RGB[(DATA_WIDTH-1):0];

    assign o_XPx = r_CounterX;
    assign o_YPx = r_CounterY;

    // --------------------------------------------------
    // Calculates the log2ceil of the input value
    // --------------------------------------------------
    function integer log2ceil;
        input integer val;
        integer i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction
endmodule
