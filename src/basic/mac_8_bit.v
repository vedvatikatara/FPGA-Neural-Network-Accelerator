module mac_8bit (
    input        clk,
    input        reset,
    input  [7:0] A,
    input  [7:0] B,
    output reg [15:0] ACC
);

    wire [15:0] product;

    assign product = A * B;

    always @(posedge clk) begin

        if (reset)
            ACC <= 16'd0;

        else
            ACC <= ACC + product;

    end

endmodule
