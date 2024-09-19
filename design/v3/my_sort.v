module my_sort #(
    DATA_NUM = 40,
    DATA_LENGTH = 14,
    OUT_NUM = 4,
    NUM_WIDTH = 6
)(
    input clk, 
    input rst_n,
    input [DATA_LENGTH-1:0] data [DATA_NUM-1:0],
    input sort_start,
    output sort_finish,
    output [DATA_LENGTH-1:0] sorted_data [OUT_NUM-1:0],
    output [NUM_WIDTH-1:0] sorted_addr [OUT_NUM-1:0]
);
    // addr ctrl
    reg core_running;
    reg [NUM_WIDTH-1:0] addr;
    reg finish_signal;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr <= {NUM_WIDTH{1'b0}};
            core_running <= 1'b0;
            finish_signal <= 1'b0;
        end
        else if (!core_running | sort_start) begin
            addr <= {NUM_WIDTH{1'b0}};
            core_running <= 1'b1;
            finish_signal <= 1'b0;
        end
        else if (core_running) begin
            if (addr == DATA_NUM - 1) begin
                addr <= {NUM_WIDTH{1'b0}};
                core_running <= #1 1'b0;
                finish_signal <= #1 1'b1;
            end
            else begin
                addr <= #1 addr + 1;
            end
        end 
    end
    assign sort_finish = finish_signal;
    
    // sort data
    reg [DATA_LENGTH-1:0] temp_sort [OUT_NUM-1:0];
    reg [NUM_WIDTH-1:0] temp_addr [OUT_NUM-1:0];
    wire [DATA_LENGTH-1:0] temp_output [OUT_NUM-1:0];
    wire [NUM_WIDTH-1:0] temp_addr_output [OUT_NUM-1:0];
    wire [DATA_LENGTH-1:0] temp_input [OUT_NUM-1:0];
    wire [NUM_WIDTH-1:0] temp_addr_input [OUT_NUM-1:0];
    wire [OUT_NUM-1:0] temp_result;
    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n | !core_running) begin
            for (i = 0; i < OUT_NUM; i = i + 1) begin
                temp_sort[i] <= {DATA_LENGTH{1'b1}};
                temp_addr[i] <= {NUM_WIDTH{1'b1}};
            end
        end
        else begin
            for (i = 0; i < OUT_NUM; i = i + 1) begin
                temp_sort[i] <= #1 temp_result[i] ? temp_input[i] : temp_sort[i];
                temp_addr[i] <= #1 (temp_result[i] | (temp_input[i] == temp_sort[i])) ? temp_addr_input[i] : temp_addr[i];
            end
        end
    end
    // wire [1:0] sum [OUT_NUM:0];
    // assign sum[0] = 2'b0;
    genvar j;
    generate
        for (j = 0; j < OUT_NUM; j = j + 1) begin
            assign sorted_data[j] = {DATA_LENGTH{sort_finish}} & temp_sort[j];
            assign temp_output[j] = temp_result[j] ? 
                                        temp_sort[j] : 
                                        (temp_input[j] == temp_sort[j]) ? 
                                            (temp_addr_input[j]/3 - temp_addr[j]/3 > 1) ? 
                                                temp_input[j]:
                                                {DATA_LENGTH{1'b1}} :
                                            temp_input[j];
            assign temp_addr_output[j] = temp_result[j]  ? 
                                            temp_addr[j] : 
                                            (temp_input[j] == temp_sort[j]) ? 
                                                (temp_addr_input[j]/3 - temp_addr[j]/3 > 1) ? 
                                                    temp_addr_input[j] :
                                                    {NUM_WIDTH{1'b0}} :
                                                temp_addr_input[j];         
            assign temp_result[j] = (temp_input[j] < temp_sort[j]) & (temp_input[j] != 0);
            // assign sorted_addr[j] = {NUM_WIDTH{temp_result[j]}} & addr;
            if (j == 0) begin
                assign temp_input[j] = data[addr];
                assign temp_addr_input[j] = addr;
            end 
            else begin
                assign temp_input[j] = temp_output[j-1];
                assign temp_addr_input[j] = temp_addr_output[j-1];
            end
            // assign sum[j+1] = sum[j] + temp_result[j];
        end
    endgenerate
    // assign addr_pos = sum[OUT_NUM];
    assign sorted_addr = temp_addr;
    
endmodule