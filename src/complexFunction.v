module complexFunction(
    input  [15:0] i_Complex,
    input  [15:0] i_Iteration,
    output reg [23:0] o_PXData,
    output reg [15:0] o_Writeback
);

    wire done, escaped;
    wire [6:0] ypx;
    wire [7:0] xpx;
    
    assign done = i_Complex[15];
    assign xpx  = i_Complex[14:7];
    assign ypx  = i_Complex[6:0];
    
    wire signed [17:0] x0, y0;
    reg signed [35:0] xx, yy, xy;
    reg signed [17:0] o_x, o_y;
    
    assign x0 = {xpx, 10'b0};
    assign y0 = {ypx, 11'b0};
    
    wire signed [17:0] mag2;
    
    assign mag2 = xx[31:14] + yy[31:14];
    assign escaped = (mag2 > 18'sb0_100_00000000000000); // x^2 + y^2 > 2^2
            
    
    always @(*) begin
        xx = x0 * x0;
        yy = y0 * y0;
        xy = x0 * y0;
        
        o_x = xx[31:14] - yy[31:14] + x0;
        o_y = (xy[31:14] << 1) + y0; // 2xy + y0

        if (done) begin
            o_Writeback = i_Complex;
            o_PXData = {8'b0, 8'b0, i_Complex[14:7]};
        end
        else begin            
            if (escaped) begin
                o_PXData = {8'b0, 8'b0, i_Iteration[15:8]};
                o_Writeback = {escaped, i_Iteration[14:0]};
            end
            else begin
                o_PXData = {8'b0, 8'b0, 8'b0};
                o_Writeback = {escaped, o_x[17:10], o_y[17:11]};
            end
        end
    end
endmodule