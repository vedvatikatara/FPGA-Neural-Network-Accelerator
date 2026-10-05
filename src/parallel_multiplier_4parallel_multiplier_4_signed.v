module parallel_multiplier_4 (
    input signed [7:0] x0,
    input signed [7:0] x1,
    input signed [7:0] x2,
    input signed [7:0] x3,

    input signed [7:0] w0,
    input signed [7:0] w1,
    input signed [7:0] w2,
    input signed [7:0] w3,

    output signed [15:0] p0,
    output signed [15:0] p1,
    output signed [15:0] p2,
    output signed [15:0] p3
);

    assign p0 =x0*w0;
    assign p1 =x1*w1;
    assign p2 =x2*w2;
    assign p3 =x3*w3;

endmodule
