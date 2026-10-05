module parameterized_multiplier #(
    parameter integer N = 8,
    parameter integer Data_Width = 8
)(
    input  wire signed [Data_Width-1:0] x [0:N-1],
    input  wire signed [Data_Width-1:0] w [0:N-1],

    output wire signed [(2*Data_Width)-1:0] p [0:N-1]
);

    genvar i;

    generate
        for (i = 0; i < N; i = i + 1) begin : gen_multiplier

            assign p[i] = x[i] * w[i];

        end
    endgenerate

endmodule
