module relu_quant (
    input  wire signed [31:0] in_data,
    input  wire [3:0] shift,
    output reg  signed [7:0] out_data
);
    reg signed [31:0] relu_data;
    reg signed [31:0] q_data;

    always @(*) begin
        if (in_data < 0)
            relu_data = 32'sd0;
        else
            relu_data = in_data;

        q_data = relu_data >>> shift;

        if (q_data > 127)
            out_data = 8'sd127;
        else if (q_data < -128)
            out_data = -8'sd128;
        else
            out_data = q_data[7:0];
    end
endmodule