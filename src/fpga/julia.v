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

endmodule