module nsync_edge(
    input clk,rst_n,sig,
    output rise_edge,fall_edge,sig_edge
);

    reg sig_r1,sig_r2,sig_r3;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            sig_r1<=0;
            sig_r2<=0;
            sig_r3<=0;
        end
        else begin
            sig_r1<=sig;
            sig_r2<=sig_r1;
            sig_r3<=sig_r2;
        end
    end
    assign rise_edge = sig_r2 & !sig_r3;
    assign fall_edge = !sig_r2 & !sig_r3;
    assign sig_edge = sig_r2 ^ sig_r3;

endmodule
