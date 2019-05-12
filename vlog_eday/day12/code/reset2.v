module reset1(
    input clk,rst,
    output reg rst_out
);
    reg rst_reg;
    always@(posedge clk or negedge rst)begin
        if(rst)
            rst_out<=1;
        else begin
            rst_reg<=0;
            rst_out<=rst_reg;
        end
    end
endmodule