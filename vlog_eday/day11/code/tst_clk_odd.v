module tst_clk_odd();

    reg clk,rst_n;
    wire clk_out1,clk_out2;

    clk_odd1 #(5) a(clk,rst_n,clk_out1);
    clk_odd2 #(5) b(clk,rst_n,clk_out2);

    initial begin
        clk=0;
        rst_n=0;
        #2 rst_n=1;
    end

    always #1 clk=~clk;

endmodule