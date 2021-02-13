module julia(
    /* Physical inputs */
    input PLD_CLOCKINPUT,

    /* Physical outputs */
    output [1:0] LEDG,
	 
    output [31:0] S_DQ,
    output [11:0] S_ADDR,
    output [1:0] S_BA,
	 output S_CAS_N,
	 output S_CKE,
	 output S_CLK,
	 output S_CS_N,
	 output [3:0] S_DQM,
	 output S_RAS_N,
	 output S_WE_N,

    output LCDCLK,
    output [23:0] RGB,
    output DEN,
    output HSD,
	 output VSD,
    output STBYB
);

mem_pll mem_pll(.inclk0(PLD_CLOCKINPUT), .c0(S_CLK));
vid_pll vid_pll(.inclk0(PLD_CLOCKINPUT), .c0(LCDCLK));

wire [23:0] rgb;
wire [8:0]  cy;
wire [10:0] cx;

tftlcd #(.Y_PX(480), .X_PX(800)) tftlcd(
	.i_CLK(LCDCLK),
	.i_RGB(rgb),
	.i_Begin(1'b1),
	
	.o_XPx(cx),
	.o_YPx(cy),
	
	/* Physical outputs */
	.RGB(RGB),
	.STBYB(STBYB),
	.HSD(HSD),
	.VSD(VSD),
	.DEN(DEN)
);

assign rgb = {cy, cx, 4'b0};

endmodule