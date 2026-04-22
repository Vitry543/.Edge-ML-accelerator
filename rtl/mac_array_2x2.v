module mac_array_2x2 (
    input  wire clk,
    input  wire rst_n,
    input  wire start,

    input  wire signed [7:0] a00, a01,
    input  wire signed [7:0] a10, a11,
    input  wire signed [7:0] b00, b01,
    input  wire signed [7:0] b10, b11,

    output reg done,
    output reg signed [31:0] c00, c01, c10, c11
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            done <= 1'b0;
            c00 <= 0; c01 <= 0; c10 <= 0; c11 <= 0;
        end else begin
            done <= 1'b0;
            if (start) begin
                c00 <= a00*b00 + a01*b10;
                c01 <= a00*b01 + a01*b11;
                c10 <= a10*b00 + a11*b10;
                c11 <= a10*b01 + a11*b11;
                done <= 1'b1;
            end
        end
    end
endmodule