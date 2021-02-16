module color_map
(
    input [7:0] value,
    output reg [23:0] rgb
);
    always @(*) begin
        case (value)
            8'd0 : rgb   = 24'h33AA00;
            8'd1 : rgb   = 24'h55AA00;
            8'd2 : rgb   = 24'h99AA00;
            8'd3 : rgb   = 24'hAAAA00;
            8'd4 : rgb   = 24'hAA9900;
            8'd5 : rgb   = 24'hAA6600;
            8'd6 : rgb   = 24'hAA3300;
            8'd7 : rgb   = 24'hAA0000;
            8'd8 : rgb   = 24'hAA0033;
            8'd9 : rgb   = 24'hAA0066;
            8'd10: rgb   = 24'hAA0099;
            8'd11: rgb   = 24'hAA00BB;
            default: rgb = 24'hAA33BB;
        endcase
    end
endmodule
