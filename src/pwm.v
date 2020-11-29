module pwm(
    input i_CLK,
    output o_x
);
    /* Registers */
    reg [15:0] r_PWMCounter = 16'd0;
    
    /* Counter */
    always @(posedge i_CLK) begin
        r_PWMCounter <= r_PWMCounter + 16'd1;
    end
    
    /* Output */
    assign o_x = (r_PWMCounter[15:13] == 3'b000);
endmodule