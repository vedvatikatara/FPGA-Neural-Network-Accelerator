module mac_8bit_signed (
    input                   clk,
    input                   reset,

    input  signed [7:0]     A,
    input  signed [7:0]     B,

    output reg signed [31:0] ACC
);

    wire signed [15:0] product;

    assign product = A * B;

    always @(posedge clk) begin

        if (reset)
            ACC <= 32'sd0;

        else
            ACC <= ACC + product;

    end

endmodule
