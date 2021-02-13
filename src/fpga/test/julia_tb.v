`timescale 1ns/1ps

module julia_tb;

reg jclk;
wire [1:0] LEDG;
wire [31:0] S_DQ;
wire [11:0] S_ADDR;
wire [1:0] S_BA;
wire S_CAS_N;
wire S_CKE;
wire S_CLK;
wire S_CS_N;
wire [3:0] S_DQM;
wire S_RAS_N;
wire S_WE_N;

wire LCDCLK;
wire [23:0] RGB;
wire DEN;
wire HSD;
wire VSD;
wire STBYB;

julia DUT(
    .PLD_CLOCKINPUT(jclk),
    .LEDG(LEDG),
    .S_DQ(S_DQ),
    .S_ADDR(S_ADDR),
    .S_BA(S_BA),
    .S_CAS_N(S_CAS_N),
    .S_CKE(S_CKE),
    .S_CLK(S_CLK),
    .S_CS_N(S_CS_N),
    .S_DQM(S_DQM),
    .S_RAS_N(S_RAS_N),
    .S_WE_N(S_WE_N),
    .LCDCLK(LCDCLK),
    .RGB(RGB),
    .DEN(DEN),
    .HSD(HSD),
    .VSD(VSD),
    .STBYB(STBYB)
);

sdr SDR(
    .Clk(S_CLK),
    .Cke(S_CKE),
    .Cs_n(S_CS_N),
    .Ras_n(S_RAS_N),
    .Cas_n(S_CAS_N),
    .We_n(S_WE_N),
    .Addr(S_ADDR),
    .Ba(S_BA),
    .Dq(S_DQ),
    .Dqm(S_DQM)
);

initial begin
    jclk = 0;
end

always begin // 50MHz clk
    #10 jclk = ~jclk;
end
always @(posedge LCDCLK) begin
    if (DEN)
        $display("VID: ", $time, ",%d,%06x,%d,%d,%d", LCDCLK, RGB, DEN, VSD, HSD);
end
endmodule
