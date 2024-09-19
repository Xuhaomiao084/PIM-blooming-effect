module test #(
    FILENAME = "mem_files/mem_test.txt"
)(
    input clk
);
    reg [130:0] mem [3:0];
    initial begin
        $readmemh(FILENAME, mem);
    end
endmodule