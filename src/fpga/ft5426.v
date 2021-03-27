module ft5426(
    input i_Clk,

    output reg [11:0] o_px_x,
    output reg [11:0] o_px_y,

    output touch_registered,

    /* Physical I/O */
    input TOUCH_INTN,
    output TOUCH_RSTN,
    inout SCL,
    inout SDA
);

// i2c controller regs
localparam REG_STATUS  = 3'h0;
localparam REG_I2CADDR = 3'h2;
localparam REG_I2CCMD  = 3'h3;
localparam REG_I2CDATA = 3'h4;

///////////////////////////////////
//        State machine          //
///////////////////////////////////

localparam STATE_RST          = 4'd0;
localparam STATE_WRITEI2CADDR = 4'd1;
localparam STATE_WRITEADDR    = 4'd2;
localparam STATE_WRITECMD     = 4'd3;
localparam STATE_READSTATUS   = 4'd4;
localparam STATE_WRITECMD1    = 4'd5;
localparam STATE_WRITECMD2    = 4'd6;
localparam STATE_WRITECMD3    = 4'd7;
localparam STATE_WRITECMD4    = 4'd8;
localparam STATE_READSTATUS1  = 4'd9;
localparam STATE_READDATA1    = 4'd10;
localparam STATE_READDATA2    = 4'd11;
localparam STATE_READDATA3    = 4'd12;
localparam STATE_READDATA4    = 4'd13;

// Just a cool initial point
initial o_px_x = 12'd288;
initial o_px_y = 12'd261;

reg [2:0] r_wb_adr_o;
reg [7:0] r_wb_dat_o;
reg r_wb_we_o, r_wb_stb_o, r_wb_cyc_o;
wire wb_ack_i;
wire [7:0] wb_dat_i;

wire rst, Nextwb_we_o, Nextwb_cyc_o, Nextwb_stb_o;
reg [2:0] r_Nextwb_adr_o;
reg [7:0] r_Nextwb_dat_o;

reg [3:0] r_CurrentState = STATE_RST;
reg [3:0] r_NextState = STATE_RST;

reg [7:0] r_I2CVal1, r_I2CVal2, r_I2CVal3, r_I2CVal4;
initial r_I2CVal1 = 8'hFF;
initial r_I2CVal2 = 8'hFF;
initial r_I2CVal3 = 8'hFF;
initial r_I2CVal4 = 8'hFF;

// TODO: register on liftoff, 2'b01
assign touch_registered = r_I2CVal1[7:6] == 2'b00 || r_I2CVal1[7:6] == 2'b10;

reg [19:0] r_Counter = 20'd0;

assign TOUCH_RSTN = ~(r_CurrentState == STATE_RST);

/* State transitions */
always @(posedge i_Clk) begin
    r_CurrentState <= r_NextState;
    r_wb_adr_o     <= r_Nextwb_adr_o;
    r_wb_dat_o     <= r_Nextwb_dat_o;
    r_wb_we_o      <= Nextwb_we_o;
    r_wb_cyc_o     <= Nextwb_cyc_o;
    r_wb_stb_o     <= Nextwb_stb_o;
    
    r_Counter      <= r_Counter + 1'd1;
end

always @(*) begin
    r_NextState = r_CurrentState;
    r_Nextwb_adr_o = r_wb_adr_o;
    r_Nextwb_dat_o = r_wb_dat_o;
    
    case (r_CurrentState)
        STATE_RST: begin
            if (r_Counter[18] == 1'b1)
                r_NextState = STATE_WRITEI2CADDR;
        end
        STATE_WRITEI2CADDR: begin
            r_Nextwb_adr_o = REG_I2CADDR;
            r_Nextwb_dat_o = 8'h38;     // 7-bit address. 8-bit addr is 0x70/71 w/r
            
            if (wb_ack_i)
                r_NextState = STATE_WRITEADDR;
        end
        
        // Write FT5426 register address to I2C data
        STATE_WRITEADDR: begin
            r_Nextwb_adr_o = REG_I2CDATA;
            r_Nextwb_dat_o = 8'h03;
            
            if (wb_ack_i)
                r_NextState = STATE_WRITECMD;
        end
        
        STATE_WRITECMD: begin
            r_Nextwb_adr_o = REG_I2CCMD;
            r_Nextwb_dat_o = 8'h15;      // stop | write | start
            
            if (wb_ack_i)
                r_NextState = STATE_READSTATUS;
        end        

        STATE_READSTATUS: begin
            r_Nextwb_adr_o = REG_STATUS;

            // Ack and bus busy
            if (wb_ack_i && (wb_dat_i & 4'h3))
                r_NextState = STATE_READSTATUS;
            // Ack and bus clear
            else if (wb_ack_i && ~(wb_dat_i & 4'h3))
                r_NextState = STATE_WRITECMD1;
        end
        
        // Read 4 consecutive registers
        STATE_WRITECMD1: begin
            r_Nextwb_adr_o = REG_I2CCMD;
            r_Nextwb_dat_o = 8'h03;      // read | start
            
            if (wb_ack_i)
                r_NextState = STATE_WRITECMD2;
        end
        STATE_WRITECMD2: begin
            r_Nextwb_adr_o = REG_I2CCMD;
            r_Nextwb_dat_o = 8'h02;      // read
            
            if (wb_ack_i)
                r_NextState = STATE_WRITECMD3;
        end
        STATE_WRITECMD3: begin
            r_Nextwb_adr_o = REG_I2CCMD;
            r_Nextwb_dat_o = 8'h02;      // read
            
            if (wb_ack_i)
                r_NextState = STATE_WRITECMD4;
        end
        STATE_WRITECMD4: begin
            r_Nextwb_adr_o = REG_I2CCMD;
            r_Nextwb_dat_o = 8'h12;      // read | stop
            
            if (wb_ack_i)
                r_NextState = STATE_READSTATUS1;
        end
        
        STATE_READSTATUS1: begin
            r_Nextwb_adr_o = REG_STATUS;

            // Ack and bus busy
            if (wb_ack_i && (wb_dat_i & 4'h3))
                r_NextState = STATE_READSTATUS1;
            // Ack and bus clear
            else if (wb_ack_i && ~(wb_dat_i & 4'h3))
                r_NextState = STATE_READDATA1;
        end
        
        STATE_READDATA1: begin
            r_Nextwb_adr_o = REG_I2CDATA;
            if (wb_ack_i) begin
                r_NextState = STATE_READDATA2;
                r_I2CVal1 = wb_dat_i; // Latch data
            end
        end
        STATE_READDATA2: begin
            r_Nextwb_adr_o = REG_I2CDATA;
            if (wb_ack_i) begin
                r_NextState = STATE_READDATA3;
                r_I2CVal2 = wb_dat_i; // Latch data
            end
        end
        STATE_READDATA3: begin
            r_Nextwb_adr_o = REG_I2CDATA;
            if (wb_ack_i) begin
                r_NextState = STATE_READDATA4;
                r_I2CVal3 = wb_dat_i; // Latch data
            end
        end
        STATE_READDATA4: begin
            r_Nextwb_adr_o = REG_I2CDATA;
            if (wb_ack_i) begin
                r_NextState = STATE_WRITEADDR;
                r_I2CVal4 = wb_dat_i; // Latch data

                if (r_I2CVal1[7:6] == 2'b00) begin
                    o_px_x = {r_I2CVal1[3:0], r_I2CVal2};
                    o_px_y = {r_I2CVal3[3:0], r_I2CVal4};
                end
            end
        end
    endcase
end

assign Nextwb_cyc_o = ~wb_ack_i;
assign Nextwb_stb_o = ~wb_ack_i;
assign Nextwb_we_o = (r_CurrentState == STATE_WRITEI2CADDR) | (r_CurrentState == STATE_WRITEADDR) | (r_CurrentState == STATE_WRITECMD)
                   | (r_CurrentState == STATE_WRITECMD1) | (r_CurrentState == STATE_WRITECMD2) | (r_CurrentState == STATE_WRITECMD3) 
                   | (r_CurrentState == STATE_WRITECMD4);
        
/* Outputs */
assign rst = (r_CurrentState == STATE_RST);

////////////////////////////////////////////////////////

/* I2C master */
wire scl_i, scl_o, scl_t;
wire sda_i, sda_o, sda_t;

assign scl_i = SCL;
assign SCL = scl_t ? 1'bz : scl_o;
assign sda_i = SDA;
assign SDA = sda_t ? 1'bz : sda_o;

i2c_master_wbs_8 #(.DEFAULT_PRESCALE(63)) i2c_master (
    .clk(i_Clk),
    .rst(rst),
    
    .wbs_adr_i(r_wb_adr_o),
    .wbs_dat_i(r_wb_dat_o),
    .wbs_dat_o(wb_dat_i),
    .wbs_we_i(r_wb_we_o),
    .wbs_stb_i(r_wb_stb_o),
    .wbs_ack_o(wb_ack_i),
    .wbs_cyc_i(r_wb_cyc_o),

    .i2c_scl_i(scl_i),
    .i2c_scl_o(scl_o),
    .i2c_scl_t(scl_t),
    .i2c_sda_i(sda_i),
    .i2c_sda_o(sda_o),
    .i2c_sda_t(sda_t)
);


endmodule
