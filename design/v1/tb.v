`include "core_top.v"

module tb_my_core;

    localparam SIGNAL_WIDTH = 18;
    localparam DIST_WIDTH = 14;
    localparam NOT_WIDTH = 2;
    localparam MEM_DATA_WIDTH = (SIGNAL_WIDTH + DIST_WIDTH)*4;
    localparam PEAK_NUM = 4;
    localparam ADDR_WIDTH = 6;

    reg clk;
    reg rst_n;
    wire core_end;

    localparam CLK_PERIOD = 10;
    always #(CLK_PERIOD/2) clk=~clk;

    core_top #(
        .BLOCK_NUM(40)
    ) u_block_top(
        .clk(clk),
        .rst_n(rst_n),
        .core_start(1'b1),
        .core_end(core_end)
    );

    initial begin
        $fsdbDumpfile("device.fsdb");
        $fsdbDumpvars(0, tb_my_core, "+all");
    end

    initial begin
        clk <= 0;
        rst_n <= 0;
        repeat(4) @(posedge clk);
        rst_n <= 1;
        wait(core_end);
        repeat(2) @(posedge clk);
        $finish(2);
    end
endmodule
