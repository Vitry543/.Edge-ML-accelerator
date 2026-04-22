`timescale 1ns/1ps

module tb_edge_accel;
    reg clk = 0;
    reg rst_n = 0;
    reg start = 0;

    wire done;
    wire signed [31:0] c00, c01, c10, c11;
    wire signed [7:0] q00, q01, q10, q11;

    edge_accel_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .done(done),
        .c00(c00), .c01(c01), .c10(c10), .c11(c11),
        .q00(q00), .q01(q01), .q10(q10), .q11(q11)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_edge_accel.vcd");
        $dumpvars(0, tb_edge_accel);

        $display("Starting simulation...");

        rst_n = 0;
        #20;
        rst_n = 1;

        #10;
        start = 1;
        #10;
        start = 0;

        wait(done == 1);

        $display("C matrix:");
        $display("c00=%0d c01=%0d", c00, c01);
        $display("c10=%0d c11=%0d", c10, c11);

        $display("Q matrix:");
        $display("q00=%0d q01=%0d", q00, q01);
        $display("q10=%0d q11=%0d", q10, q11);

        if (c00 == 19 && c01 == 22 && c10 == 43 && c11 == 50)
            $display("PASS: matrix multiply correct");
        else
            $display("FAIL: wrong matrix result");

        #20;
        $finish;
    end
endmodule