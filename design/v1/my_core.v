module my_core #(
    SIGNAL_WIDTH = 18,
    DIST_WIDTH = 14,
    NOT_WIDTH = 2,
    PEAK_NUM = 4,
    DATA_WIDTH = (SIGNAL_WIDTH + DIST_WIDTH) * PEAK_NUM
) (
    // inputs
    input ref_mode,
    input blooming_mode,
    input [DATA_WIDTH-1:0] mem_data,
    input [DIST_WIDTH-1:0] distance,
    input [NOT_WIDTH-1:0] point_notation_i,
    output [NOT_WIDTH-1:0] point_notation_o,
    output is_bloom,
    output has_ref,
    output [DIST_WIDTH-1:0] ref_dist
);
    
    // The core has two modes, reflector mode is to find reflector area and blooming mode is to find blooming area.
    localparam THRESHOLD = 20000;

    wire [DATA_WIDTH-1:0] mem_data_in = mem_data;

    // mem_data[0:127] = {peak1_dist, peak1_data, peak2_dist, peak2_data, peak3_dist, peak3_data, peak4_dist, peak4_data}
    wire [SIGNAL_WIDTH-1:0] peak_data [PEAK_NUM-1:0];
    wire [DIST_WIDTH-1:0] peak_dist [PEAK_NUM-1:0];
    genvar i;
    generate
        for (i = 0; i < PEAK_NUM; i = i + 1) begin
            assign peak_data[i] = mem_data_in[32*i+31:32*i+14];
            assign peak_dist[i] = mem_data_in[32*i+13:32*i];
        end
    endgenerate
    
    // 1. reflector mode
    wire [NOT_WIDTH-1:0] point_notation_ref;
    wire [PEAK_NUM-1:0] ref_flag;
    generate
        for (i = 0; i < PEAK_NUM; i = i + 1) begin
            assign ref_flag[i] = (ref_mode & (peak_data[i] >= THRESHOLD)) ? 1'b1: 1'b0;
        end
    endgenerate
    assign point_notation_ref = (|ref_flag) ? 2'b10 : 2'b00;
    assign has_ref = |ref_flag;
    assign ref_dist = ({DIST_WIDTH{ref_flag[0]}} & peak_dist[0]) | 
                      ({DIST_WIDTH{ref_flag[1]}} & peak_dist[1]) | 
                      ({DIST_WIDTH{ref_flag[2]}} & peak_dist[2]) | 
                      ({DIST_WIDTH{ref_flag[3]}} & peak_dist[3]) ;

    // 2. blooming mode
    wire [NOT_WIDTH-1:0] point_notation_blooming;
    wire [PEAK_NUM-1:0] bloom_flag;
    generate
        for (i = 0; i < PEAK_NUM; i = i + 1) begin
            assign bloom_flag[i] = (blooming_mode & (peak_dist[i] == distance)) ? 1'b1: 1'b0;
        end
    endgenerate
    assign point_notation_blooming = (|bloom_flag & (point_notation_i != 2'b10)) ? 2'b01 : point_notation_i;

    assign point_notation_o = ({NOT_WIDTH{ref_mode}} & point_notation_ref) | 
                              ({NOT_WIDTH{blooming_mode}} & point_notation_blooming);
    assign is_bloom = |bloom_flag;


endmodule