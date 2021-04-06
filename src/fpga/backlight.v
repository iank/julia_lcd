module backlight
(
    input i_Clk,
    input i_Touch,
    output o_Light
);

localparam STATE_DISPLAY_OFF = 1'd0;
localparam STATE_DISPLAY_ON  = 1'd1;

reg [33:0] r_Counter = 34'd0;
reg r_CurrentState = STATE_DISPLAY_ON;
reg r_NextState;

/* State transitions */
always @(posedge i_Clk) begin
    r_CurrentState <= r_NextState;
end

always @(*) begin
    r_NextState = r_CurrentState;
    case (r_CurrentState)
        STATE_DISPLAY_OFF: begin
            if (i_Touch)
                r_NextState = STATE_DISPLAY_ON;
        end
        STATE_DISPLAY_ON: begin
            if (r_Counter[33])
                r_NextState = STATE_DISPLAY_OFF;
        end
    endcase
end

/* Idle counter */
always @(posedge i_Clk) begin
    if (i_Touch)
        r_Counter <= 34'd0;
    else
        r_Counter <= r_Counter + 1'd1;
end

/* Backlight control */
assign o_Light = (r_CurrentState == STATE_DISPLAY_ON);

endmodule

