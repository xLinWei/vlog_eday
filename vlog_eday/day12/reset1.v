module reset1(
    input clk,rst_n,
    output reg rst_n_out
);
    reg rst_n_reg;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            rst_n_out<=0;
        else begin
            rst_n_reg<=1;
            rst_n_out<=rst_n_reg;
        end
    end
endmodule