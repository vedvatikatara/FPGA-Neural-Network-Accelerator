module parallel_multiplier_4 (
    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,

    input [7:0] w0,
    input [7:0] w1,
    input [7:0] w2,
    input [7:0] w3,

    output [15:0] p0,
    output [15:0] p1,
    output [15:0] p2,
    output [15:0] p3
);

    assign p0 =x0*w0;
    assign p1 =x1*w1;
    assign p2 =x2*w2;
    assign p3 =x3*w3;

endmodule
