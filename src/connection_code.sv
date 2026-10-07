module dot_product #(
    parameter integer N = 8,
    parameter integer Data_Width = 8
)(
    input  logic signed [Data_Width-1:0] x [0:N-1],
    input  logic signed [Data_Width-1:0] w [0:N-1],

    output logic signed [(2*Data_Width + $clog2(N))-1:0] partial_sum
);

    // Product width: INT8 × INT8 → INT16
    logic signed [(2*Data_Width)-1:0] products [0:N-1];

    // Parallel multiplier
    parallel_multiplier_signed_param #(
        .N(N),
        .Data_Width(Data_Width)
    ) multiplier (
        .x(x),
        .w(w),
        .p(products)
    );

    // Adder tree
    adder_tree_4_param #(
        .N(N),
        .Data_Width(Data_Width)
    ) adder_tree (
        .p(products),
        .result(partial_sum)
    );

endmodule
