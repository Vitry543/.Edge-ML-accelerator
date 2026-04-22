module mac_int8 (
    input  wire              clk,
    input  wire              rst_n,
    input  wire              en,
    input  wire              clr,
    input  wire signed [7:0] a,
    input  wire signed [7:0] b,
    output reg  signed [31:0] acc
);
    wire signed [15:0] mult;
    assign mult = a * b;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            acc <= 32'sd0;
        else if (clr)
            acc <= 32'sd0;
        else if (en)
            acc <= acc + mult;
    end
endmodule