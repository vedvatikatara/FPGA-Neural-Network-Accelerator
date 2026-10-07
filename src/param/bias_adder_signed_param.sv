module bias_adder_signed_param #(
    parameter integer Data_Width = 32
)(
    input  logic signed [Data_Width-1:0] acc,
    input  logic signed [Data_Width-1:0] bias,
    output logic signed [Data_Width-1:0] biased_sum
);

    assign biased_sum = acc + bias;

endmodule
