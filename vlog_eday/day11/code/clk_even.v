module clk_even #(parameter N=4)(
    input clk,rst_n,
    output reg clk_out
);
    localparam n=N/2;

    reg [3:0] cnt;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt<=0;
            clk_out<=0;
        end
        else if(cnt==n-1)begin
            cnt<=0;
            clk_out<=~clk_out;
        end
        else begin
            cnt<=cnt+1;
            clk_out<=clk_out;
        end
    end

endmodule