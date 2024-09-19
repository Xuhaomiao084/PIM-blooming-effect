`include "my_block_top.v"
`include "my_sort.v"
`include "general_find_addr.v"

module core_top #(
    BLOCK_NUM = 40,
    NUM_WIDTH = 6
) (
    input clk,
    input rst_n,
    input core_start,
    output core_end
);

    localparam BLOCK_SIZE = 1200 / BLOCK_NUM;
    localparam SIGNAL_WIDTH = 18;
    localparam DIST_WIDTH = 14;
    localparam NOT_WIDTH = 2;
    localparam PEAK_NUM = 4;
    localparam DATA_WIDTH = (SIGNAL_WIDTH + DIST_WIDTH) * PEAK_NUM;
    localparam ADDR_WIDTH = 5;

    wire [1:0] mode [BLOCK_NUM-1:0];
    wire [DIST_WIDTH-1:0] distance;
    wire [BLOCK_NUM-1:0] contains_ref;
    wire [BLOCK_NUM-1:0] contains_bloom;
    wire [BLOCK_NUM-1:0] ref_end;
    wire [BLOCK_NUM-1:0] bloom_end;
    wire [DIST_WIDTH-1:0] ref_dist [BLOCK_NUM-1:0];

    genvar i;
    generate
        for (i = 0; i < BLOCK_NUM; i = i + 1) begin
            localparam MEM_FILE = $sformatf("./mem_files/mem_test%0d", i);
            my_block_top #(
                .BLOCK_SIZE(BLOCK_SIZE),
                .SIGNAL_WIDTH(SIGNAL_WIDTH),
                .DIST_WIDTH(DIST_WIDTH),
                .NOT_WIDTH(NOT_WIDTH),
                .PEAK_NUM(PEAK_NUM),
                .DATA_WIDTH(DATA_WIDTH),
                .ADDR_WIDTH(ADDR_WIDTH),
                .MEM_FILE(MEM_FILE)
            ) u_block_top(
                .clk(clk),
                .rst_n(rst_n),
                .mode(mode[i]),
                .distance(distance),
                .core_end(core_end),
                .contains_ref(contains_ref[i]),
                .contains_bloom(contains_bloom[i]),
                .ref_end(ref_end[i]),
                .bloom_end(bloom_end[i]),
                .ref_dist(ref_dist[i])
            );
        end
    endgenerate

    // FSM
    localparam FSM_WIDTH = 3;
    localparam IDLE = 0;
    localparam REF = 1;
    localparam BLOOMING = 2;
    localparam SEL = 3;
    localparam SORT = 4;

    wire [FSM_WIDTH-1:0] cur_st;
    wire [FSM_WIDTH-1:0] nxt_st;

    wire state_is_idle = (cur_st == IDLE);
    wire state_is_ref = (cur_st == REF);
    wire state_is_bloom = (cur_st == BLOOMING);
    wire state_is_sel = (cur_st == SEL);
    wire state_is_sort = (cur_st == SORT);

    wire [FSM_WIDTH-1:0] idle_nxt = REF;
    wire idle_st_end = state_is_idle & core_start;
    wire [FSM_WIDTH-1:0] ref_nxt = SORT;
    // wire [FSM_WIDTH-1:0] ref_nxt = BLOOMING;
    wire ref_st_end = state_is_ref & (|ref_end);
    // wire [FSM_WIDTH-1:0] bloom_nxt = SEL;
    wire [FSM_WIDTH-1:0] bloom_nxt = SEL;
    wire bloom_st_end;
    wire [FSM_WIDTH-1:0] sel_nxt;
    wire sel_st_end;
    wire [FSM_WIDTH-1:0] sort_nxt = SEL;
    wire sort_st_end;

    wire state_en = idle_st_end | ref_st_end | bloom_st_end | sel_st_end | sort_st_end;
    assign nxt_st = ({FSM_WIDTH{idle_st_end}} & idle_nxt) |
                    ({FSM_WIDTH{ref_st_end}} & ref_nxt) |
                    ({FSM_WIDTH{bloom_st_end}} & bloom_nxt) |
                    ({FSM_WIDTH{sel_st_end}} & sel_nxt) | 
                    ({FSM_WIDTH{sort_st_end}} & sort_nxt);
    general_dff # (FSM_WIDTH) u_fsm_ff(clk, rst_n, state_en, nxt_st, cur_st);

    wire [1:0] ref_mode = 2'b01;
    wire [1:0] bloom_mode = 2'b10;    

    // sort
    wire [DIST_WIDTH-1:0] ref_dist_cur [BLOCK_NUM-1:0];
    wire [DIST_WIDTH-1:0] ref_dist_r [BLOCK_NUM-1:0];
    wire [BLOCK_NUM-1:0] ref_dist_ena = {BLOCK_NUM{ref_st_end}};
    generate
        for (i = 0; i < BLOCK_NUM; i = i + 1) begin
            assign ref_dist_r[i] = ref_dist[i];
            general_dff # (DIST_WIDTH) u_ref_dist_ff(clk, rst_n, ref_dist_ena[i], ref_dist_r[i], ref_dist_cur[i]);
        end
    endgenerate
    // collect largest 4 reflectors
    localparam REF_NUM = 4;
    wire sort_finish;
    wire sort_start = ref_st_end & ~sort_finish;
    wire [DIST_WIDTH-1:0] sorted_dist_r [REF_NUM-1:0];
    wire [NUM_WIDTH-1:0] sorted_addr_r [REF_NUM-1:0];
    my_sort #(
        .DATA_NUM(BLOCK_NUM),
        .DATA_LENGTH(DIST_WIDTH),
        .OUT_NUM(REF_NUM),
        .NUM_WIDTH(NUM_WIDTH)
    ) u_sort(
        .clk(clk),
        .rst_n(rst_n),
        .data(ref_dist_cur),
        .sort_start(sort_start),
        .sort_finish(sort_finish),
        .sorted_data(sorted_dist_r),
        .sorted_addr(sorted_addr_r)
    );
    wire [DIST_WIDTH-1:0] sorted_dist [REF_NUM-1:0];
    wire [NUM_WIDTH-1:0] sorted_addr [REF_NUM-1:0];
    wire sorted_ena = sort_finish;
    generate
        for (i = 0; i < REF_NUM; i = i + 1) begin
            general_dff # (DIST_WIDTH) u_sort_dist_ff(clk, rst_n, sorted_ena, sorted_dist_r[i], sorted_dist[i]);
            general_dff # (NUM_WIDTH) u_sort_addr_ff(clk, rst_n, sorted_ena, sorted_addr_r[i], sorted_addr[i]);
        end
    endgenerate
    assign sort_st_end = sort_finish & state_is_sort;

    // sel
    wire sel_addr_start;
    general_dff # (1) u_sel_addr_start_ff(clk, rst_n, sorted_ena, 1'b1, sel_addr_start);
    wire [2:0] sel_addr_cur;
    wire [2:0] sel_addr_nxt;
    wire sel_finish = state_is_sel & ((sorted_addr[sel_addr_cur] == {NUM_WIDTH{1'b1}}) | (sel_addr_cur == REF_NUM));
    wire sel_addr_ena = ~sel_finish & bloom_st_end;
    assign sel_addr_nxt = (sel_addr_cur > REF_NUM - 1) ? REF_NUM : sel_addr_cur + 1;
    general_dff # (NUM_WIDTH) u_sel_addr_ff(clk, rst_n, sel_addr_ena, sel_addr_nxt, sel_addr_cur);
    assign sel_st_end = state_is_sel;
    assign sel_nxt = sel_finish ? IDLE : BLOOMING;

    // bloom
    wire has_ref = | contains_ref;
    wire [BLOCK_NUM-1:0] reverse_contains_ref;
    wire [NUM_WIDTH-1:0] center_idx;
    wire [NUM_WIDTH-1:0] cur_active_idx [1:0];
    wire [NUM_WIDTH-1:0] nxt_active_idx [1:0];
    wire [1:0] active_idx_ena;

    // sel start position
    // generate
    //     for (i = 0; i < BLOCK_NUM; i = i + 1) begin
    //         assign reverse_contains_ref[i] = contains_ref[BLOCK_NUM - i - 1];
    //     end
    // endgenerate
    // wire [BLOCK_NUM-1:0] first_pos_long = contains_ref & (~(contains_ref - 1));
    // wire [BLOCK_NUM-1:0] last_pos_long = reverse_contains_ref & (~(reverse_contains_ref - 1));
    // assign start_idx = $clog2(first_pos_long);
    // assign end_idx = $clog2(last_pos_long);
    // assign center_idx = (start_idx + end_idx) / 2;
    // move core
    assign center_idx = sorted_addr[sel_addr_cur];
    wire sel2bloom = (cur_st == SEL) & (nxt_st == BLOOMING);
    assign nxt_active_idx[0] = state_is_bloom ? cur_active_idx[0] - 1 :
                               sel2bloom ? center_idx : {NUM_WIDTH{1'b0}}; 
    assign nxt_active_idx[1] = state_is_bloom ? cur_active_idx[1] + 1 :
                               sel2bloom ? center_idx + 1 : {NUM_WIDTH{1'b0}}; 
    assign active_idx_ena[0] = (~(cur_active_idx[0] == 0 | contains_bloom[cur_active_idx[0]] == 0) 
                                & state_is_bloom & bloom_end[cur_active_idx[0]]) | sel2bloom;
    assign active_idx_ena[1] = (~(cur_active_idx[1] == BLOCK_NUM - 1 | contains_bloom[cur_active_idx[1]] == 0) 
                                & state_is_bloom & bloom_end[cur_active_idx[1]]) | sel2bloom;
    generate
        for (i = 0; i < 2; i = i + 1) begin
            general_dff # (NUM_WIDTH) u_addr_ff(clk, rst_n, active_idx_ena[i], nxt_active_idx[i], cur_active_idx[i]);
        end
    endgenerate
    // record distance
    // wire [DIST_WIDTH-1:0] dist_temp [BLOCK_NUM-1:0];
    // assign dist_temp[0] = ref_dist[0];
    // generate
    //     for (i = 1; i < BLOCK_NUM; i = i + 1)begin
    //         assign dist_temp[i] = dist_temp[i-1] | ref_dist[i];
    //     end
    // endgenerate   
    wire dist_ena = state_is_bloom;
    general_dff # (DIST_WIDTH) u_dist_ff(clk, rst_n, dist_ena, sorted_dist[sel_addr_cur], distance);
    //activate core
    generate
        for (i = 0; i < BLOCK_NUM; i = i + 1) begin
            assign mode[i] = ({2{state_is_ref}} & ref_mode) | 
                             ({2{state_is_bloom}} & bloom_mode 
                              & {2{((i == cur_active_idx[0]) | 
                                 (i == cur_active_idx[1]))}});
        end
    endgenerate

    assign bloom_st_end = ((~contains_bloom[cur_active_idx[0]]) & (~contains_bloom[cur_active_idx[1]])) 
                          & state_is_bloom & bloom_end[cur_active_idx[0]] & bloom_end[cur_active_idx[1]];
    assign core_end = sel_finish;
    
endmodule