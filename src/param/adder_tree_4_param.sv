module adder_tree_param #(
    parameter integer N = 8,
    parameter integer Data_Width = 8
)(
    input  wire signed [(2*Data_Width)-1:0] p [0:N-1],

    output wire signed [(2*Data_Width + $clog2(N))-1:0] result
);

    // Number of levels in the adder tree
    localparam integer Levels = $clog2(N);

    // Width needed to store the final result
    localparam integer Result_Width = 2*Data_Width + Levels;

    // Complete adder tree
    wire signed [Result_Width-1:0] tree [0:Levels][0:N-1];

    genvar i;
    genvar level;

    // ------------------------------------------------
    // Level 0: Sign-extend multiplier outputs
    // ------------------------------------------------
    generate
        for (i = 0; i < N; i = i + 1) begin : gen_input

            assign tree[0][i] =
                {{Levels{p[i][(2*Data_Width)-1]}}, p[i]};

        end
    endgenerate

    // ------------------------------------------------
    // Generate all adder levels
    // ------------------------------------------------
    generate
        for (level = 0; level < Levels; level = level + 1) begin : gen_level

            for (i = 0; i < N/(2**(level+1)); i = i + 1) begin : gen_adder

                assign tree[level+1][i] =
                    tree[level][2*i] +
                    tree[level][2*i+1];

            end

        end
    endgenerate

    // ------------------------------------------------
    // Final result
    // ------------------------------------------------
    assign result = tree[Levels][0];

endmodule
