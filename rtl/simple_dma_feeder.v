module simple_dma_feeder (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    output reg  done,

    output reg signed [7:0] a00, a01, a10, a11,
    output reg signed [7:0] b00, b01, b10, b11
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            done <= 1'b0;
            a00 <= 0; a01 <= 0; a10 <= 0; a11 <= 0;
            b00 <= 0; b01 <= 0; b10 <= 0; b11 <= 0;
        end else begin
            done <= 1'b0;
            if (start) begin
                a00 <= 8'd1; a01 <= 8'd2;
                a10 <= 8'd3; a11 <= 8'd4;

                b00 <= 8'd5; b01 <= 8'd6;
                b10 <= 8'd7; b11 <= 8'd8;

                done <= 1'b1;
            end
        end
    end
endmodule