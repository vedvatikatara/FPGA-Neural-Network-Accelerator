module tb_leaky_relu;

    logic signed [31:0] x;
    logic signed [31:0] y;

    leaky_relu #(
        .Data_Width(32),
        .LEAK_SHIFT(7)
    ) dut (
        .x(x),
        .y(y)
    );

    initial begin

        // Positive value
        x = 32'sd100;
        #10;
        $display("x = %0d, y = %0d", x, y);

        // Zero
        x = 32'sd0;
        #10;
        $display("x = %0d, y = %0d", x, y);

        // Negative value
        x = -32'sd128;
        #10;
        $display("x = %0d, y = %0d", x, y);

        // Larger negative value
        x = -32'sd256;
        #10;
        $display("x = %0d, y = %0d", x, y);

        // Small negative value
        x = -32'sd50;
        #10;
        $display("x = %0d, y = %0d", x, y);

        $finish;
    end

endmodule
