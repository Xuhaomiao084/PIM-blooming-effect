module my_mem #(
    SIGNAL_WIDTH = 18,
    DIST_WIDTH = 14,
    NOT_WIDTH = 2,
    PEAK_NUM = 4,
    DATA_WIDTH = (SIGNAL_WIDTH + DIST_WIDTH) * PEAK_NUM,
    ADDR_WIDTH = 5,
    MEM_LEN = 30,
    MEM_FILE = "mem_files/mem_test"
) (
    input clk,
    input wr_en,
    input [ADDR_WIDTH-1:0] addr,
    input [NOT_WIDTH-1:0] point_notation_i,
    input bloom_end,
    output [NOT_WIDTH-1:0] point_notation_o,
    output [DATA_WIDTH-1:0] mem_data
);

    reg [DATA_WIDTH+NOT_WIDTH-1:0] mem_reg [MEM_LEN-1:0];
    wire [DATA_WIDTH+NOT_WIDTH-1:0] data_r;
    reg [ADDR_WIDTH-1:0] addr_r;

    always @(posedge clk) begin
        addr_r <= #1 addr;
    end

    always @(negedge clk) begin
        if (wr_en) begin
            mem_reg[addr_r][DATA_WIDTH+NOT_WIDTH-1:DATA_WIDTH] <= #1 point_notation_i;
        end
    end

    assign data_r = mem_reg[addr_r];
    assign mem_data = data_r[DATA_WIDTH-1:0];
    assign point_notation_o = data_r[DATA_WIDTH+NOT_WIDTH-1:DATA_WIDTH];

    integer out_file;
    initial begin
        $readmemb($sformatf("%s.txt", MEM_FILE), mem_reg);
        wait(bloom_end);
        out_file = $fopen($sformatf("%s_result.txt", MEM_FILE), "w");
        for (integer j = 0; j < MEM_LEN; j = j + 1) begin
            $fwrite(out_file, "%b", mem_reg[j]);
            $fwrite(out_file, "\n");
        end
        $fclose(out_file);
    end

    // reg [13:0] addr_data = 14'd100;
    // reg [15:0] point_data = 16'd500;
    // reg [31:0] normal_point = {point_data, addr_data};
    // initial begin
    //     for (integer j = 0; j < MEM_LEN; j = j + 1) begin
    //         mem_reg[j] = {2'b00, {4{normal_point}}};
    //     end
    //     for (integer j = 3; j < 8; j = j + 1) begin
    //         mem_reg[j][95:64] = {16'd2000, 14'd500};
    //     end
    //     for (integer j = 12; j < 19; j = j + 1) begin
    //         mem_reg[j][95:64] = {16'd2000, 14'd500};
    //     end
    //     for (integer j = 23; j < 28; j = j + 1) begin
    //         mem_reg[j][95:64] = {16'd2000, 14'd500};
    //     end
    //     for (integer j = 14; j < 17; j = j + 1) begin
    //         mem_reg[j][127:96] = {16'd50000, 14'd500};
    //     end
    //     mem_reg[0][127:96] = {16'd50000, 14'd500};
    //     mem_reg[29][127:96] = {16'd50000, 14'd500};
    // end
       
endmodule