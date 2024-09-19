// `include "my_mem.v"
`include "test.v"
// `include "my_column_core.v"
`default_nettype none

module tb_my_core;

    reg clk;

    initial begin
        $fsdbDumpfile("device1.fsdb");
        $fsdbDumpvars(0, tb_my_core, "+all");
    end

    // wire [15:0] temp_data = 16'b1001_0111_1000_1000;
    // reg [15:0] temp;
    genvar i;
    generate
        for (i = 0; i < 2; i = i + 1) begin
            test #($sformatf("mem_files/mem_test%0d.txt", i)) u_test(clk);
        end
    endgenerate
    initial begin
        clk <= 0;
    end

    

endmodule
`default_nettype wire
