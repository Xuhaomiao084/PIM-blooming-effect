// `include "my_mem.v"
`include "my_sort.v"
// `include "my_column_core.v"

module tb_my_core;

    reg clk;
    reg rst_n;
    reg [13:0] data [39:0];
    reg sort_start;
    reg sort_finish;
    reg [13:0] sorted_data [3:0];

    initial begin
        $fsdbDumpfile("device1.fsdb");
        $fsdbDumpvars(0, tb_my_core, "+all");
    end

    always #5 clk = ~clk;

    initial begin
        clk <= 0;
        rst_n <= 0;
        sort_start <= 0;
        for (integer i = 0; i < 39; i = i + 1) begin
            data[i] <= 500 + $random%100;
        end
        data[39] <= 800;
        #20
        rst_n <= 1;
        sort_start <= 1;
        #500
        sort_start <= 0;
        #10
        sort_start <= 1;
        #1000
        $finish(2);
    end

    my_sort u_sort(
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .sort_start(sort_start),
        .sort_finish(sort_finish)
    );

    

endmodule
