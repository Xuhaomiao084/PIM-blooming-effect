`include "my_core.v"
`include "general_dff.v"

module my_block_core #(
    BLOCK_SIZE = 30,
    SIGNAL_WIDTH = 18,
    DIST_WIDTH = 14,
    PEAK_NUM = 4,
    NOT_WIDTH = 2*PEAK_NUM,
    DATA_WIDTH = (SIGNAL_WIDTH + DIST_WIDTH) * PEAK_NUM,
    ADDR_WIDTH = 5,
    REF_MAX = 3,
    BLOOMING_RANGE = 50
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
    output [DIST_WIDTH-1:0] ref_dist [REF_MAX-1:0]
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
    reg [DIST_WIDTH-1:0] ref_dist_r [REF_MAX-1:0];
    reg [REF_MAX-1:0] flag [PEAK_NUM+REF_MAX-1:0];
    wire [DIST_WIDTH-1:0] ref_dist_cur [PEAK_NUM-1:0];
    wire [DIST_WIDTH-1:0] ref_dist_out [PEAK_NUM-1:0] [REF_MAX-1:0];
    wire [DIST_WIDTH-1:0] ref_dist_in [PEAK_NUM-1:0] [REF_MAX-1:0];
    wire [PEAK_NUM-1:0] ref_dist_comp [REF_MAX-1:0];
    wire [PEAK_NUM-1:0] if_new_ref [REF_MAX-1:0];
    reg [DIST_WIDTH-1:0] ref_dist_wr [REF_MAX-1:0];
    wire [REF_MAX-1:0] load_ctrl [PEAK_NUM-1:0];
    wire [REF_MAX-1:0] ref_dist_ena;
    wire [REF_MAX-1:0] cnt_ena;
    wire [DIST_WIDTH-1:0] ref_dist_wr_arr [REF_MAX-1:0] [PEAK_NUM-1:0];
    wire has_ref_cur;
    reg [REF_MAX+PEAK_NUM-1:0] contains_ref_r;
    integer i;
    integer j;
    integer k;
    always @(posedge clk) begin
        if (!state_is_ref) begin
            for (i = 0; i < REF_MAX; i = i + 1) begin
                ref_dist_r[i] <= {DIST_WIDTH{1'b0}};
                ref_dist_wr[i] <= {DIST_WIDTH{1'b0}};
            end
            for (i = 0; i < REF_MAX + PEAK_NUM; i = i + 1) begin
                flag[i] = {REF_MAX{1'b1}};
            end
            contains_ref_r <= 1'b0;
        end
        else begin
            for (i = 0; i < REF_MAX; i = i + 1) begin
                ref_dist_r[i] <= #1 ref_dist_wr[i];
            end
            for (i = 0; i < REF_MAX + PEAK_NUM; i = i + 1) begin
                contains_ref_r[i] <= #1 (i == 0) ? (~(&flag[i])) : ((~(&flag[i])) | contains_ref_r[i-1]);
            end
        end
    end

    reg [DIST_WIDTH-1:0] temp [PEAK_NUM+REF_MAX-1:0];
    always @(*) begin
        temp[PEAK_NUM+REF_MAX-1:REF_MAX] <= ref_dist_cur;
        temp[REF_MAX-1:0] <= ref_dist_r;
        for (i = 0; i < PEAK_NUM+REF_MAX; i = i + 1) begin
            for (j = 0; j < REF_MAX; j = j + 1) begin
                if ((temp[i] != {DIST_WIDTH{1'b0}}) &
                    (temp[i] != ref_dist_wr[j]) & 
                    (ref_dist_wr[j] == {DIST_WIDTH{1'b0}})) 
                    begin
                    ref_dist_wr[j] = {DIST_WIDTH{flag[i][j]}} & temp[i];
                    for (k = 0; k < REF_MAX; k = k + 1) begin
                        if (k != j) begin
                            flag[i][k] = {REF_MAX{1'b0}};
                        end
                    end
                end
            end
        end
    end    

    // generate
    //     for (j = 0; j < REF_MAX; j = j + 1) begin
    //         for (k = 0; k < PEAK_NUM; k = k + 1) begin
    //             assign ref_dist_in[k][j] = (j == 0) ? ref_dist_cur[k] : ref_dist_out[k][j-1];
    //             assign ref_dist_out[k][j] = ref_dist_comp[j][k] ? {DIST_WIDTH{1'b0}} : ref_dist_in[k][j];
    //             assign ref_dist_comp[j][k] = ((ref_dist_r[j] == {DIST_WIDTH{1'b0}}) | 
    //                                             (ref_dist_in[k][j] == ref_dist_r[j])) & 
    //                                          load_ctrl[k][j] & 
    //                                          ref_dist_in[k][j] != {DIST_WIDTH{1'b0}};
    //             assign if_new_ref[j][k] = (ref_dist_in[k][j] != ref_dist_r[j]) & (ref_dist_in[k][j] != {DIST_WIDTH{1'b0}});
    //             assign load_ctrl[k][j] = (k == 0) ? 1'b1 : ~ref_dist_comp[j][k-1];
    //             assign ref_dist_wr_arr[j][k] = {DIST_WIDTH{ref_dist_comp[j][k]}} & ref_dist_in[k][j];
    //             assign ref_dist_ena[j] = |ref_dist_comp[j];
    //             assign cnt_ena[j] = |if_new_ref[j];
    //         end
    //     end
    // endgenerate

    // always @(*) begin
    //     for (integer j = 0; j < REF_MAX; j = j + 1) begin
    //         ref_dist_wr[j] = {DIST_WIDTH{1'b0}};
    //         for (integer k = 0; k < PEAK_NUM; k = k + 1) begin
    //             ref_dist_wr[j] = ref_dist_wr[j] | ref_dist_wr_arr[j][k];
    //         end
    //     end
    // end

    assign ref_dist = ref_dist_r;
    assign contains_ref = contains_ref_r[REF_MAX+PEAK_NUM-1];

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