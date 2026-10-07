module adder_tree_4 (

    input  [15:0] p0,
    input  [15:0] p1,
    input  [15:0] p2,
    input  [15:0] p3,

    output [17:0] result
);

    wire [16:0] sum0;
    wire [16:0] sum1;

    assign sum0 = p0 + p1;
    assign sum1 = p2 + p3;

    assign result = sum0 + sum1;

endmodule
