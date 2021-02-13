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

initial begin
   jclk = 0;
	#1500;
   //#13552000
end

always begin // 50MHz clk
    #10 jclk = ~jclk;
end
always begin
	 $monitor("VID: ", $time, ",%d,%06x,%d,%d,%d", LCDCLK, RGB, DEN, VSD, HSD);
end
endmodule