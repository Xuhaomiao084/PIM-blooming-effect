`include "my_core.v"
`include "general_dff.v"

module my_block_core #(
    BLOCK_SIZE = 30,
    SIGNAL_WIDTH = 18,
    DIST_WIDTH = 14,
    NOT_WIDTH = 2,
    PEAK_NUM = 4,
    DATA_WIDTH = (SIGNAL_WIDTH + DIST_WIDTH) * PEAK_NUM,
    ADDR_WIDTH = 5
) (
    input clk,
    input rst_n,
    input [1:0] mode,
    input [DATA_WIDTH-1:0] mem_data,
    input [DIST_WIDTH-1:0] distance,
    input [NOT_WIDTH-1:0] point_notation_i,
    output [NOT_WIDTH-1:0] point_notation_o,
    output [ADDR_WIDTH-1:0] addr,
    output contains_bloom,
    output wr_en,
    output contains_ref,
    output ref_end,
    output bloom_end,
    output [DIST_WIDTH-1:0] ref_dist
);

    // FSM
    localparam IDLE = 0;
    localparam REF = 1;
    localparam BLOOMING = 2;
    localparam FSM_WIDTH = 2;

    wire [FSM_WIDTH-1:0] cur_st;
    wire [FSM_WIDTH-1:0] nxt_st;
    wire state_is_idle = (cur_st == IDLE);
    wire state_is_ref = (cur_st == REF);
    wire state_is_bloom = (cur_st == BLOOMING);
    wire mode_is_ref = (mode == 2'b01);
    wire mode_is_blooming = (mode == 2'b10);
    wire [FSM_WIDTH-1:0] idle_nxt = mode_is_ref ? REF : 
                                    mode_is_blooming ? BLOOMING : 
                                    IDLE;
    
    wire idle_st_end = state_is_idle & (mode_is_ref | mode_is_blooming);
    wire ref_st_end;
    wire blooming_st_end;
    wire [FSM_WIDTH-1:0] ref_nxt = IDLE;
    wire [FSM_WIDTH-1:0] blooming_nxt = IDLE;
    wire state_en = idle_st_end | ref_st_end | blooming_st_end;
    assign nxt_st = ({FSM_WIDTH{idle_st_end}} & idle_nxt) | 
                    ({FSM_WIDTH{ref_st_end}} & ref_nxt) |
                    ({FSM_WIDTH{blooming_st_end}} & blooming_nxt);
    general_dff # (FSM_WIDTH) u_fsm_ff(clk, rst_n, state_en, nxt_st, cur_st);

    // The block size is 30, thus it takes 30 cycles to scan one block
    wire need_addr = mode_is_ref | mode_is_blooming;
    wire addr_en = (state_is_idle & need_addr) | state_is_ref | (state_is_bloom & (~blooming_st_end));
    wire [ADDR_WIDTH-1:0] cur_addr;
    wire [ADDR_WIDTH-1:0] nxt_addr = state_is_idle ? need_addr ? cur_addr + 1 
                                                               : 0
                                                   : (cur_addr == 29 | ref_st_end) ? 0
                                                                      : cur_addr + 1;
    general_dff # (ADDR_WIDTH) u_addr_ff (clk, rst_n, addr_en, nxt_addr, cur_addr);  
    assign addr = cur_addr;
    assign ref_st_end = state_is_ref & (cur_addr == 0);
    assign blooming_st_end = state_is_bloom & (cur_addr == 0);
    assign wr_en = state_is_ref | state_is_bloom;
    assign ref_end = ref_st_end;
    assign bloom_end = blooming_st_end;

    // contains bloom
    wire cur_is_bloom;
    reg cur_bloom_status;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cur_bloom_status = 1'b0;
        end
        else begin
            cur_bloom_status = #1 cur_bloom_status | cur_is_bloom;
        end
    end
    assign contains_bloom = cur_bloom_status;

    // contains ref & ref dist
    reg [DIST_WIDTH-1:0] ref_dist_r;
    wire [DIST_WIDTH-1:0] ref_dist_cur;
    wire has_ref_cur;
    reg contains_ref_r;
    always @(posedge clk) begin
        if (!state_is_ref) begin
            ref_dist_r <= {DIST_WIDTH{1'b0}};
            contains_ref_r <= 1'b0;
        end
        else begin
            ref_dist_r = #1 ref_dist_r | ({DIST_WIDTH{has_ref_cur}} & ref_dist_cur);
            contains_ref_r = #1 contains_ref_r | has_ref_cur;
        end
    end
    assign ref_dist = ref_dist_r;
    assign contains_ref = contains_ref_r;

    my_core # (
        .SIGNAL_WIDTH(SIGNAL_WIDTH),
        .DIST_WIDTH(DIST_WIDTH),
        .NOT_WIDTH(NOT_WIDTH),
        .PEAK_NUM(PEAK_NUM),
        .DATA_WIDTH(DATA_WIDTH)
    ) u_core(
        .ref_mode(state_is_ref),
        .blooming_mode(state_is_bloom),
        .mem_data(mem_data),
        .distance(distance),
        .point_notation_i(point_notation_i),
        .point_notation_o(point_notation_o),
        .is_bloom(cur_is_bloom),
        .has_ref(has_ref_cur),
        .ref_dist(ref_dist_cur)
    );
    
endmodule