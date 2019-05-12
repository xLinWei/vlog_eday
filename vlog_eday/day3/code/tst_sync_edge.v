module tst_sync_edge();
    reg clk,rst_n,sig;
    wire rise_edge,fall_edge,sig_edge;

    sync_edge inst(clk,rst_n,sig,rise_edge,fall_edge,sig_edge);

    initial begin
        clk=0;
        rst_n=0;
        sig=0;
        #2 rst_n=1;
        #1 #0sig=1;
        #6 #0sig=0;
    end

    always #1 clk=~clk;

endmodule