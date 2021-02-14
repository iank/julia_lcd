module julia(
    /* Physical inputs */
    input PLD_CLOCKINPUT,

    /* Physical outputs */
    output [1:0] LEDG,
     
    inout [31:0] S_DQ,
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

    assign LCDCLK = PLD_CLOCKINPUT;
    assign LEDG = 2'b1;
    assign RGB[23:0] = 24'b0;
    assign DEN = 1'b0;
    assign VSD = 1'b0;
    assign HSD = 1'b0;
    assign STBYB = 1'b1;

    sdramPLL mem_pll_inst(
        .inclk0(PLD_CLOCKINPUT),
        .c0(S_CLK)
    );

    julia_sys u0 (
        .clk_clk          (PLD_CLOCKINPUT),
        .reset_reset_n    (1'b1),
        .sdram_wire_addr  (S_ADDR),
        .sdram_wire_ba    (S_BA),
        .sdram_wire_cas_n (S_CAS_N),
        .sdram_wire_cke   (S_CKE),
        .sdram_wire_cs_n  (S_CS_N),
        .sdram_wire_dq    (S_DQ),
        .sdram_wire_dqm   (S_DQM),
        .sdram_wire_ras_n (S_RAS_N),
        .sdram_wire_we_n  (S_WE_N)
    );

endmodule
