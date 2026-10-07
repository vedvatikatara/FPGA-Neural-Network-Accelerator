module accumulator_signed_param #(
    parameter integer Data_Width = 19
)(
    input  logic                         clk,
    input  logic                         reset,
    input  logic signed [Data_Width-1:0] partial_sum,
    output logic signed [Data_Width-1:0] acc
);

    always_ff @(posedge clk) begin
        if (reset)
            acc <= '0;
        else
            acc <= acc + partial_sum;
    end

endmodule
