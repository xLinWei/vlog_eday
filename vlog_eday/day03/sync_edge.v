module sync_edge(
    input clk,rst_n,sig,
    output rise_edge,fall_edge,sig_edge
);
    reg sig_r;

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            sig_r<=0;
        else
            sig_r<=sig;
    end

    assign rise_edge=sig & !sig_r;
    assign fall_edge=!sig & sig_r;
    assign sig_edge=sig ^ sig_r;

endmodule