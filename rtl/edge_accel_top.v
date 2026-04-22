module edge_accel_top (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    output wire done,

    output wire signed [31:0] c00, c01, c10, c11,
    output wire signed [7:0] q00, q01, q10, q11
);
    wire feeder_done;
    wire signed [7:0] a00, a01, a10, a11;
    wire signed [7:0] b00, b01, b10, b11;
    wire mat_done;

    simple_dma_feeder u_dma (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .done(feeder_done),
        .a00(a00), .a01(a01), .a10(a10), .a11(a11),
        .b00(b00), .b01(b01), .b10(b10), .b11(b11)
    );

    mac_array_2x2 u_matmul (
        .clk(clk),
        .rst_n(rst_n),
        .start(feeder_done),
        .a00(a00), .a01(a01), .a10(a10), .a11(a11),
        .b00(b00), .b01(b01), .b10(b10), .b11(b11),
        .done(mat_done),
        .c00(c00), .c01(c01), .c10(c10), .c11(c11)
    );

    relu_quant u_q00 (.in_data(c00), .shift(4'd1), .out_data(q00));
    relu_quant u_q01 (.in_data(c01), .shift(4'd1), .out_data(q01));
    relu_quant u_q10 (.in_data(c10), .shift(4'd1), .out_data(q10));
    relu_quant u_q11 (.in_data(c11), .shift(4'd1), .out_data(q11));

    assign done = mat_done;
endmodule