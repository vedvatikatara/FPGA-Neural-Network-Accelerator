module adder_tree_4 (

    input signed [15:0] p0,
    input signed [15:0] p1,
    input signed [15:0] p2,
    input signed [15:0] p3,

    output signed [17:0] result
);

    wire signed [16:0] sum0;
    wire signed [16:0] sum1;

    assign sum0 = p0 + p1;
    assign sum1 = p2 + p3;

    assign result = sum0 + sum1;

endmodule
