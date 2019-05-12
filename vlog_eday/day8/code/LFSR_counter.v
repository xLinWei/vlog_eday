module LFSR_counter(
    input clk,rst_n,
    output reg  [2:0] cnt
);
    localparam seed=3'b111;//种子，也就是初始值

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=seed;
        else begin
            cnt={cnt[0],cnt[2]^cnt[0],cnt[1]};
        end
    end

endmodule