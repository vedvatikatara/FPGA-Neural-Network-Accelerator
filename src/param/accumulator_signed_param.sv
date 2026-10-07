module accumulator_signed_param #(
    parameter integer Input_Width = 19,
    parameter integer Acc_Width   = 32
)(
    input  logic                         clk,
    input  logic                         reset,
    input  logic signed [Input_Width-1:0] partial_sum,
    output logic signed [Acc_Width-1:0]   acc
);

    always_ff @(posedge clk) begin
        if (reset)
            acc <= '0;
        else
            acc <= acc + partial_sum;
    end

endmodule
