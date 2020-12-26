module sram(
    // Inputs
    input             i_CLK,
    input             i_Begin,
    input             i_Write,
    input      [18:0] i_Addr,
    input      [15:0] i_Data_f2s,  // fpga 2 sram

    output     [15:0] o_Data_s2f,  // sram 2 fpga
    output            o_Ready,

    // Physical signals
    output o_CS1_N,
    output o_OE_N,
    output o_WE_N,
    output o_LB_N,
    output o_UB_N,
    output [18:0] o_Addr,
    inout  [15:0] io_IO
);
    /* State definitions */
    localparam STATE_RESET     = 3'd0;
    localparam STATE_IDLE      = 3'd1;
    localparam STATE_WR_BEGIN  = 3'd2;
    localparam STATE_WR_END    = 3'd3;
    localparam STATE_RD_BEGIN  = 3'd4;
    localparam STATE_RD_END    = 3'd5;

    /* Registers */
    reg [2:0] r_CurrentState = STATE_RESET;
    reg [2:0] r_NextState;
    reg [18:0] r_Addr;
    reg [18:0] r_NextAddr;
    reg [15:0] r_Data_f2s;
    reg [15:0] r_NextData_f2s;
    reg [15:0] r_Data_s2f;
    reg [15:0] r_NextData_s2f;

    /* Internal wires */
    
    /* State transitions */
    always @(posedge i_CLK) begin
        r_CurrentState <= r_NextState;
        r_Addr         <= r_NextAddr;
        r_Data_f2s     <= r_NextData_f2s;
        r_Data_s2f     <= r_NextData_s2f;
    end

    always @(*) begin
        r_NextState    = r_CurrentState;
        r_NextAddr     = r_Addr;
        r_NextData_f2s = r_Data_f2s;
        r_NextData_s2f = r_Data_s2f;

        case (r_CurrentState)
            STATE_RESET: begin
                r_NextState = STATE_IDLE;
            end
            STATE_IDLE: begin
                if (i_Begin && i_Write) begin
                    r_NextState    = STATE_WR_BEGIN;
                    r_NextAddr     = i_Addr;
                    r_NextData_f2s = i_Data_f2s;
                end
                else if (i_Begin && ~i_Write) begin
                    r_NextState    = STATE_RD_BEGIN;
                    r_NextAddr     = i_Addr;
                end
            end
            STATE_WR_BEGIN: begin
                r_NextState = STATE_WR_END;
            end
            STATE_WR_END: begin
                if (i_Begin && i_Write) begin
                    r_NextState    = STATE_WR_BEGIN;
                    r_NextAddr     = i_Addr;
                    r_NextData_f2s = i_Data_f2s;
                end
                else if (i_Begin && ~i_Write) begin
                    r_NextState    = STATE_RD_BEGIN;
                    r_NextAddr     = i_Addr;
                end
                else begin
                    r_NextState = STATE_IDLE;
                end
            end
            STATE_RD_BEGIN: begin
                r_NextState = STATE_RD_END;
            end
            STATE_RD_END: begin
                r_NextData_s2f = io_IO;
                if (i_Begin && i_Write) begin
                    r_NextState    = STATE_WR_BEGIN;
                    r_NextAddr     = i_Addr;
                    r_NextData_f2s = i_Data_f2s;
                end
                else if (i_Begin && ~i_Write) begin
                    r_NextState    = STATE_RD_BEGIN;
                    r_NextAddr     = i_Addr;
                end
                else begin
                    r_NextState = STATE_IDLE;
                end
            end
        endcase
    end
    
    /* Dynamic outputs */

    // Drive data lines w/ hiZ on read, data on write
    assign io_IO   = (r_CurrentState == STATE_WR_BEGIN || r_CurrentState == STATE_WR_END) ? r_Data_f2s : 16'hZZZZ;
    assign o_Addr = r_Addr;

    assign o_WE_N = ~(r_CurrentState == STATE_WR_BEGIN);
    assign o_OE_N = ~(r_CurrentState == STATE_RD_BEGIN || r_CurrentState == STATE_RD_END);
    
    assign o_Ready = (r_CurrentState == STATE_IDLE || r_CurrentState == STATE_RD_END || r_CurrentState == STATE_WR_END);
    
    assign o_Data_s2f = r_Data_s2f;
    
    /* Constant outputs */
    assign o_LB_N = 1'b0; // LB enabled
    assign o_UB_N = 1'b0; // UB enabled
    
    assign o_CS1_N = 1'b0; // CS = true
endmodule