//Johnson计数器
module counter_john(
    input clk,rst_n,
    output reg [3:0] cnt
);

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=0;
        else if(cnt[3])
            cnt<=cnt<<1;
        else
            cnt<={cnt[2:0],1'b1};
    end

endmodule