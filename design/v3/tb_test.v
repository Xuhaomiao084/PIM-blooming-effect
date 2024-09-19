// `include "my_mem.v"
`include "my_block_core.v"
// `include "my_column_core.v"

module tb_my_core;

    reg clk;
    reg rst_n;
    reg [1:0] mode;
    reg [127:0] data [29:0];
    reg [13:0] distance;
    reg [1:0] point_notation_i;
    wire [4:0] addr;

    initial begin
        $fsdbDumpfile("device1.fsdb");
        $fsdbDumpvars(0, tb_my_core, "+all");
    end

    always #5 clk = ~clk;

    initial begin
        clk <= 0;
        rst_n <= 0;
        mode <= 2'b00;
        for (integer i = 0; i < 30; i = i + 1) begin
            if (i == 3) begin
                data[i] <= {{3{{18'd3000},{14'd500}}}, {{18'd25000}, {14'd100}}};
            end
            else if (i == 15) begin
                data[i] <= {{3{{18'd3000},{14'd500}}}, {{18'd35000}, {14'd700}}};
            end
            // else if (i == 25) begin
            //     data[i] <= {{3{{18'd3000},{14'd500}}}, {{18'd45000}, {14'd1000}}};
            // end
            else begin
                data[i] <= {4{{18'd3000},{14'd500}}};
            end
        end
        distance <= 0;
        point_notation_i <= 0;
        #20
        rst_n <= 1;
        mode <= 2'b01;
        # 5000
        $finish(2);
    end

    my_block_core u_block(
        .clk(clk),
        .rst_n(rst_n),
        .mode(mode),
        .mem_data(data[addr]),
        .distance(distance),
        .point_notation_i(point_notation_i),
        // .point_notation_o(point_notation_o),
        .addr(addr)
        // .contains_bloom(contains_bloom),
        // .wr_en(wr_en),
        // .contains_ref(contains_ref),
        // .ref_end(ref_end),
        // .bloom_end(bloom_end),
        // .ref_dist(ref_dist)
    );

    

endmodule
