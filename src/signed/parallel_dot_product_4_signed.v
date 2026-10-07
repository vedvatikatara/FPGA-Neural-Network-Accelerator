module parallel_dot_product_4 (

    input signed [7:0] x0,
    input signed [7:0] x1,
    input signed [7:0] x2,
    input signed [7:0] x3,

    input signed [7:0] w0,
    input signed [7:0] w1,
    input signed [7:0] w2,
    input signed [7:0] w3,

    output signed [17:0] result
);

    // Products from the four parallel multipliers
    wire signed [15:0] p0;
    wire signed [15:0] p1;
    wire signed [15:0] p2;
    wire signed [15:0] p3;


    // Four parallel multipliers
    parallel_multiplier_4 multiplier_block (

        .x0(x0),
        .x1(x1),
        .x2(x2),
        .x3(x3),

        .w0(w0),
        .w1(w1),
        .w2(w2),
        .w3(w3),

        .p0(p0),
        .p1(p1),
        .p2(p2),
        .p3(p3)

    );


    // Adder tree
    adder_tree_4 adder_block (

        .p0(p0),
        .p1(p1),
        .p2(p2),
        .p3(p3),

        .result(result)

    );

endmodule
