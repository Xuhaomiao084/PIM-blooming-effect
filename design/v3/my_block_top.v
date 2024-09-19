`include "my_block_core.v"
`include "my_mem.v"

module my_block_top #(
    BLOCK_SIZE = 30,
    SIGNAL_WIDTH = 18,
    DIST_WIDTH = 14,
    PEAK_NUM = 4,
    NOT_WIDTH = 2*PEAK_NUM,
    DATA_WIDTH = (SIGNAL_WIDTH + DIST_WIDTH) * PEAK_NUM,
    ADDR_WIDTH = 5,
    REF_MAX = 3,
    MEM_FILE = "mem_files/mem_test"
) (
    input clk,
    input rst_n,
    input [1:0] mode,
    input [DIST_WIDTH-1:0] distance,
    input core_end,
    output contains_ref,
    output contains_bloom,
    output ref_end,
    output bloom_end,
    output [DIST_WIDTH-1:0] ref_dist [REF_MAX-1:0]
);

    wire wr_en;
    wire [DATA_WIDTH-1:0] mem_data;
    wire [NOT_WIDTH-1:0] point_notation_i;
    wire [NOT_WIDTH-1:0] point_notation_o;
    wire [ADDR_WIDTH-1:0] addr;
    my_mem # (
        .SIGNAL_WIDTH(SIGNAL_WIDTH),
        .DIST_WIDTH(DIST_WIDTH),
        .NOT_WIDTH(NOT_WIDTH),
        .PEAK_NUM(PEAK_NUM),
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_LEN(BLOCK_SIZE),
        .MEM_FILE(MEM_FILE)
    ) u_mem (
        .clk(clk),
        .wr_en(wr_en),
        .addr(addr),
        .point_notation_i(point_notation_i),
        .point_notation_o(point_notation_o),
        .mem_data(mem_data),
        .bloom_end(core_end)
    );

    my_block_core # (
        .BLOCK_SIZE(BLOCK_SIZE),
        .SIGNAL_WIDTH(SIGNAL_WIDTH),
        .DIST_WIDTH(DIST_WIDTH),
        .NOT_WIDTH(NOT_WIDTH),
        .PEAK_NUM(PEAK_NUM),
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_block_core(
        .clk(clk),
        .rst_n(rst_n),
        .mode(mode),
        .mem_data(mem_data),
        .distance(distance),
        .point_notation_i(point_notation_o),
        .point_notation_o(point_notation_i),
        .addr(addr),
        .contains_bloom(contains_bloom),
        .wr_en(wr_en),
        .contains_ref(contains_ref),
        .ref_end(ref_end),
        .bloom_end(bloom_end),
        .ref_dist(ref_dist)
    );


endmodule