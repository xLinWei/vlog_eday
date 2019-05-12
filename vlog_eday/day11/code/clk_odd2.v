module clk_odd2 #(parameter N=5)(
    input clk,rst_n,
    output clk_out
);
    localparam n=N/2;
    reg [3:0] cnt;
    reg clk1,clk2;

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=0;
        else
            cnt<=(cnt==N-1)?0:cnt+1;
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            clk1<=0;
        else begin
            if(cnt==0)
                clk1<=~clk1;
            else
                clk1<=clk1;
        end
    end

    always@(negedge clk or negedge rst_n)begin
        if(!rst_n)
            clk2<=0;
        else begin
            if(cnt==n+1)
                clk2<=~clk2;
            else
                clk2<=clk2;
        end
    end

    assign clk_out=clk1 ^ clk2;

endmodule