module parameterized_adder_tree #( 
    parameter integer N = 8,
    parameter integer Data_Width = 8
)(

    input  wire [(2*Data_Width)-1:0] p [0:N-1],
    output wire [(2*Data_Width + $clog2(N))-1:0] result
);

    // No. of Levels in the adder tree[c:ceiling]
    localparam integer Levels = $clog2(N);

    // Data_Width needed to store the final result
    localparam integer Result_Width = 2*Data_Width + Levels;

    // Complete adder tree
    wire [Result_Width-1:0] tree [0:Levels][0:N-1];

    genvar i;
    genvar level;

    // ------------------------------------------------
    // Level 0: connect multiplier outputs to the tree
    // ------------------------------------------------
    generate
        for (i = 0; i < N; i = i + 1) begin : gen_input
            assign tree[0][i] = {{Levels{1'b0}}, p[i]};
        end
    endgenerate

    // ------------------------------------------------
    // Generate all adder Levels
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
