//4bit计数器
module counter(
    input clk,rst_n,
    output reg [3:0] cnt
);
    //always@(posedge clk)//同步复位
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=0;
        else
            cnt<=cnt+1;
    end
endmodule
