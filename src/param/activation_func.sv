module leaky_relu #(
    parameter integer Data_Width = 32,
    parameter integer LEAK_SHIFT = 7
)(
    input  logic signed [Data_Width-1:0] x,
    output logic signed [Data_Width-1:0] y
);

    always_comb begin
        if (x < 0)
            y = x >>> LEAK_SHIFT;
        else
            y = x;
    end

endmodule
