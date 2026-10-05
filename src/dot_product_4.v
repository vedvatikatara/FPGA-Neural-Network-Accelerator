module dot_product_4 (
    input        clk,
    input        reset,
    input        start,

    input  [7:0] x0,
    input  [7:0] x1,
    input  [7:0] x2,
    input  [7:0] x3,

    input  [7:0] w0,
    input  [7:0] w1,
    input  [7:0] w2,
    input  [7:0] w3,

    output reg [23:0] result,
    output reg        done
);

    // FSM states
    localparam IDLE = 3'd0;
    localparam MAC0 = 3'd1;
    localparam MAC1 = 3'd2;
    localparam MAC2 = 3'd3;
    localparam MAC3 = 3'd4;
    localparam DONE = 3'd5;

    reg [2:0] state;

    // Input registers
    reg [7:0] x0_reg, x1_reg, x2_reg, x3_reg;
    reg [7:0] w0_reg, w1_reg, w2_reg, w3_reg;

    // Accumulator
    reg [23:0] acc;

    // Current inputs to the multiplier
    reg [7:0] current_x;
    reg [7:0] current_w;

    // Multiplier output
    wire [15:0] product;

    // Zero-extended product for accumulator
    wire [23:0] product_ext;

    assign product = current_x * current_w;
    assign product_ext = {8'd0, product};


    // Select which x and w pair is being processed
    always @(*) begin

        current_x = 8'd0;
        current_w = 8'd0;

        case (state)

            MAC0: begin
                current_x = x0_reg;
                current_w = w0_reg;
            end

            MAC1: begin
                current_x = x1_reg;
                current_w = w1_reg;
            end

            MAC2: begin
                current_x = x2_reg;
                current_w = w2_reg;
            end

            MAC3: begin
                current_x = x3_reg;
                current_w = w3_reg;
            end

            default: begin
                current_x = 8'd0;
                current_w = 8'd0;
            end

        endcase

    end


    // Main sequential logic
    always @(posedge clk) begin

        if (reset) begin

            state  <= IDLE;

            acc    <= 24'd0;
            result <= 24'd0;
            done   <= 1'b0;

            x0_reg <= 8'd0;
            x1_reg <= 8'd0;
            x2_reg <= 8'd0;
            x3_reg <= 8'd0;

            w0_reg <= 8'd0;
            w1_reg <= 8'd0;
            w2_reg <= 8'd0;
            w3_reg <= 8'd0;

        end

        else begin

            // done is normally low
            done <= 1'b0;

            case (state)

                // Wait for start
                IDLE: begin

                    if (start) begin

                        // Capture inputs
                        x0_reg <= x0;
                        x1_reg <= x1;
                        x2_reg <= x2;
                        x3_reg <= x3;

                        w0_reg <= w0;
                        w1_reg <= w1;
                        w2_reg <= w2;
                        w3_reg <= w3;

                        // Clear accumulator
                        acc <= 24'd0;

                        state <= MAC0;

                    end

                end


                // x0 × w0
                MAC0: begin

                    acc <= product_ext;

                    state <= MAC1;

                end


                // x1 × w1
                MAC1: begin

                    acc <= acc + product_ext;

                    state <= MAC2;

                end


                // x2 × w2
                MAC2: begin

                    acc <= acc + product_ext;

                    state <= MAC3;

                end


                // x3 × w3
                MAC3: begin

                    acc <= acc + product_ext;

                    state <= DONE;

                end


                // Output result
                DONE: begin

                    result <= acc;

                    done <= 1'b1;

                    state <= IDLE;

                end


                default: begin

                    state <= IDLE;

                end

            endcase

        end

    end

endmodule
