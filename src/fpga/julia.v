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

/* PLLs */
mem_pll mem_pll(.inclk0(PLD_CLOCKINPUT), .c0(MEM_CLK), .c1(S_CLK));
vid_pll vid_pll(.inclk0(PLD_CLOCKINPUT), .c0(LCDCLK));

/* LCD */
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

/* SDRAM */
localparam WRITE_BURST = 1;
localparam READ_BURST_LENGTH = 8;

localparam CMD_IDLE  = 2'd0;
localparam CMD_WRITE = 2'd1;
localparam CMD_READ  = 2'd2;

reg [1:0] command = 2'd0;
reg sdram_init_complete = 1'd0;
reg [21:0] data_address = 22'd0;
reg [31:0] data_write = 32'd0;
wire [31:0] data_read;
wire data_read_valid, data_write_done;
reg [7:0] countdown;

as4c4m32s_controller #(.CLK_RATE(50000000), .WRITE_BURST(WRITE_BURST), .READ_BURST_LENGTH(READ_BURST_LENGTH), .CAS_LATENCY(3)) as4c4m32s_controller (
    .clk(MEM_CLK),
    .command(command),
    .data_address(data_address),
    .data_write(data_write),
    .data_read(data_read),
    .data_read_valid(data_read_valid),
    .data_write_done(data_write_done),
     
     /* Physical outputs */
    .clock_enable(S_CKE),
    .bank_activate(S_BA),
    .address(S_ADDR),
    .chip_select(S_CS_N),
    .row_address_strobe(S_RAS_N),
    .column_address_strobe(S_CAS_N),
    .write_enable(S_WE_N),
    .dqm(S_DQM),
    .dq(S_DQ)
);

always @(posedge MEM_CLK) begin
    if (command == CMD_IDLE && !sdram_init_complete) begin
        command <= CMD_WRITE;
        data_write <= {10'd0, data_address};
        countdown <= READ_BURST_LENGTH - 1;
    end
    else if (command == CMD_WRITE && data_write_done) begin
        if (countdown == 3'd0)
            command <= CMD_IDLE;
        else
            countdown <= countdown - 1'd1;
             
        data_address <= data_address + 1'd1;
        data_write <= {10'd0, data_address + 1'd1};
        if (data_address + 1'd1 == 22'd0)
            sdram_init_complete <= 1'b1;
    end
end


endmodule
