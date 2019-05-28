//同步技术1：两级触发器
module sync1(
    input clk,rst_n,
    input din,
    output reg dout
);

reg din_r;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dout<=0;
        din_r<=0;
    else begin
        din_r<=din;
        dout<=din_r;
    end
end

endmodule