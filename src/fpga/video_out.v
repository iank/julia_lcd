module video_out(
    input LCDCLK,
    input [7:0] i_Pixel_Data,
    input i_Begin,

    output o_Pixel_Data_Acknowledge,

    /* Physical outputs */
    output [23:0] RGB,
    output DEN,
    output HSD,
    output VSD,
    output STBYB
);

/* LCD */
reg [23:0] rgb;
reg lcd_begin = 1'b0;

tftlcd #(.Y_PX(480), .X_PX(800)) tftlcd(
    .i_CLK(LCDCLK),
    .i_RGB(rgb),
    .i_Begin(lcd_begin),
    
    .o_XPx(),
    .o_YPx(),
    
    /* Physical outputs */
    .RGB(RGB),
    .HSD(HSD),
    .VSD(VSD),
    .DEN(DEN),
    .STBYB(STBYB)
);

assign o_Pixel_Data_Acknowledge = DEN && lcd_begin;

/* Color map */
wire [23:0] px_rgb;

color_map color_map (
	.value (i_Pixel_Data),
	.rgb (px_rgb)
);

/* Video control logic */
always @(posedge LCDCLK) begin
    if (i_Begin && !lcd_begin)
        lcd_begin <= 1'b1;

    if (DEN && lcd_begin) begin
        rgb <= px_rgb;
    end
end

endmodule
