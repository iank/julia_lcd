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
            8'd12: rgb   = 24'hBB00CC;
            8'd13: rgb   = 24'hCC00DD;
            8'd14: rgb   = 24'hDD00EE;
            8'd15: rgb   = 24'hEE00FF;
            8'd16: rgb   = 24'hFF00FF;
            8'd17: rgb   = 24'hEE00FF;
            8'd18: rgb   = 24'hDD00FF;
            8'd19: rgb   = 24'hCC00FF;
            8'd20: rgb   = 24'hBB00FF;
            8'd21: rgb   = 24'hAA00FF;
            8'd22: rgb   = 24'h9900FF;
            8'd23: rgb   = 24'h8800FF;
            8'd24: rgb   = 24'h7700FF;
            8'd25: rgb   = 24'h6600FF;
            8'd26: rgb   = 24'h5500FF;
            8'd27: rgb   = 24'h4400FF;
            8'd28: rgb   = 24'h3300FF;
            8'd29: rgb   = 24'h2200FF;
            8'd30: rgb   = 24'h1100FF;
            8'd255: rgb   = 24'h000000;
            default: rgb = 24'hFFFFFF;
        endcase
    end
endmodule
