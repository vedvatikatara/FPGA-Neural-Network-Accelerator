module tb_bias_adder_signed_param;

    logic signed [31:0] acc;
    logic signed [31:0] bias;
    logic signed [31:0] biased_sum;

    bias_adder_signed_param #(
        .Data_Width(32)
    ) dut (
        .acc(acc),
        .bias(bias),
        .biased_sum(biased_sum)
    );

    initial begin

        // Test 1: Zero bias
        acc  = 32'sd100;
        bias = 32'sd0;
        #10;
        $display("ACC = %0d, Bias = %0d, Output = %0d",
                 acc, bias, biased_sum);

        // Test 2: Positive bias
        acc  = 32'sd100;
        bias = 32'sd25;
        #10;
        $display("ACC = %0d, Bias = %0d, Output = %0d",
                 acc, bias, biased_sum);

        // Test 3: Negative bias
        acc  = 32'sd100;
        bias = -32'sd30;
        #10;
        $display("ACC = %0d, Bias = %0d, Output = %0d",
                 acc, bias, biased_sum);

        // Test 4: Negative accumulator
        acc  = -32'sd100;
        bias = 32'sd25;
        #10;
        $display("ACC = %0d, Bias = %0d, Output = %0d",
                 acc, bias, biased_sum);

        $finish;
    end

endmodule
