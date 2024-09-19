module general_find_addr #(
    DATA_NUM = 40,
    NUM_WIDTH = 6
) (
    input mode, // 0 is in order, 1 is reverse order
    input [DATA_NUM-1:0] data,
    output [NUM_WIDTH-1:0] addr
);
    
    wire [DATA_NUM-1:0] data_rev;
    genvar i;
    generate
        for (i = 0; i < DATA_NUM; i = i + 1) begin
            assign data_rev[i] = data[DATA_NUM-i-1];
        end
    endgenerate

    wire [DATA_NUM-1:0] data_use = mode ? data_rev : data;
    wire [DATA_NUM-1:0] addr_long = data_use & (~(data_use - 1));
    assign addr = $clog2(addr_long);

endmodule