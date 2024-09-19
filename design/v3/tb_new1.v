module tb_my_core;

    reg [7:0] a [6:0];
    reg [7:0] a1 [3:0];
    reg [7:0] a2 [2:0];
    reg [7:0] b [2:0];
    reg [2:0] flag [6:0];

    always @(*) begin
        a[6:3] <= a1[3:0];
        a[2:0] <= a2[2:0];
        for (integer i = 0; i < 7; i = i + 1) begin
            for (integer j = 0; j < 3; j = j + 1) begin
                if ((a[i] != 0) & (a[i] != b[j]) & (b[j] == 0) & flag[i][j]) begin
                    b[j] = a[i];
                    flag[i] = 3'b000;
                end
            end
        end
    end

    initial begin
        $fsdbDumpfile("device2.fsdb");
        $fsdbDumpvars(0, tb_my_core, "+all");
    end

    initial begin
        for (integer i = 0; i < 7; i = i + 1) begin
            if(i < 3) begin
                a2[i] <= 0;
            end
            else begin
                a1[i-3] <= 10 + i;
            end
            flag[i] <= 3'b111;
        end
        for (integer j = 0; j < 3; j = j + 1) begin
            b[j] <= 0;
        end
        #10
        $finish(2);
    end

endmodule