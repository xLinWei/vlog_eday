module crc(
    input clk,rst_n,din,
    output reg  [2:0] cnt
);
    localparam seed=3'b111;//种子，也就是初始值

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=seed;
        else begin
            cnt={din^cnt[0],din^cnt[0]^cnt[2],cnt[1]};
        end
    end

endmodule