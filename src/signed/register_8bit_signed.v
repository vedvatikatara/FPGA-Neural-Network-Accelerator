module register_8bit (
    input signed       clk,
    input signed [7:0] D,
    output reg signed [7:0] Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule
