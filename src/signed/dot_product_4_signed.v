module dot_product_4_signed (
    input  wire        clk,
    input  wire        reset,
    input  wire        start,

    input  wire signed [7:0] x0,
    input  wire signed [7:0] x1,
    input  wire signed [7:0] x2,
    input  wire signed [7:0] x3,

    input  wire signed [7:0] w0,
    input  wire signed [7:0] w1,
    input  wire signed [7:0] w2,
    input  wire signed [7:0] w3,

    output reg signed [31:0] result,
    output reg               done
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
    reg signed [7:0] x0_reg, x1_reg, x2_reg, x3_reg;
    reg signed [7:0] w0_reg, w1_reg, w2_reg, w3_reg;

    // 32-bit accumulator
    reg signed [31:0] acc;

    // Current multiplier inputs
    reg signed [7:0] current_x;
    reg signed [7:0] current_w;

    // 16-bit multiplication result
    wire signed [15:0] product;

    // Sign-extended product
    wire signed [31:0] product_ext;

    // Multiply
    assign product = current_x * current_w;

    // Sign extend 16-bit product to 32 bits
    assign product_ext = {{16{product[15]}}, product};


    // Select current x and w
    always @(*) begin

        current_x = 8'sd0;
        current_w = 8'sd0;

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
                current_x = 8'sd0;
                current_w = 8'sd0;
            end

        endcase

    end


    // Sequential logic
    always @(posedge clk) begin

        if (reset) begin

            state  <= IDLE;

            acc    <= 32'sd0;
            result <= 32'sd0;
            done   <= 1'b0;

            x0_reg <= 8'sd0;
            x1_reg <= 8'sd0;
            x2_reg <= 8'sd0;
            x3_reg <= 8'sd0;

            w0_reg <= 8'sd0;
            w1_reg <= 8'sd0;
            w2_reg <= 8'sd0;
            w3_reg <= 8'sd0;

        end

        else begin

            done <= 1'b0;

            case (state)

                IDLE: begin

                    if (start) begin

                        x0_reg <= x0;
                        x1_reg <= x1;
                        x2_reg <= x2;
                        x3_reg <= x3;

                        w0_reg <= w0;
                        w1_reg <= w1;
                        w2_reg <= w2;
                        w3_reg <= w3;

                        acc <= 32'sd0;

                        state <= MAC0;

                    end

                end


                MAC0: begin

                    acc <= product_ext;

                    state <= MAC1;

                end


                MAC1: begin

                    acc <= acc + product_ext;

                    state <= MAC2;

                end


                MAC2: begin

                    acc <= acc + product_ext;

                    state <= MAC3;

                end


                MAC3: begin

                    acc <= acc + product_ext;

                    state <= DONE;

                end


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
