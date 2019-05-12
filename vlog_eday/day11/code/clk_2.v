module clk_2(
    input clk,rst_n,
    output reg clk_out
);

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            clk_out<=0;
        else
            clk_out<=~clk_out;
    end

endmodule