//环形计数器
module counter_loop(
    input clk,rst_n,
    output reg [3:0] cnt
);

    always@(posedge clk)begin
        if(!rst_n)
            cnt<=4'b0001;
        else
            cnt<={cnt[2:0],cnt[3]};//循环左移，不能用移位操作符
    end

endmodule