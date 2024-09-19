module general_dff #(
    DATA_WIDTH = 32
) (
    input clk,
    input rst_n,
    input ld_en,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out
);
    
    reg [DATA_WIDTH-1:0] data_reg;

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0)
            data_reg <= {DATA_WIDTH{1'b0}};
        else if (ld_en == 1'b1)
            data_reg <= #1 data_in;
    end

    assign data_out = data_reg;

endmodule