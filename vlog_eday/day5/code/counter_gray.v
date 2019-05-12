//Gray计数器
module counter_gray(
    input clk,rst_n,
    output [3:0] cnt
);
    reg [3:0] bin_cnt;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            bin_cnt<=0;
        else
            bin_cnt<=bin_cnt+1;
    end

    assign cnt=bin_cnt ^ (bin_cnt>>1);

endmodule