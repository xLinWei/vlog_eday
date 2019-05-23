module tst_clk_even();

    reg clk,rst_n;
    wire clk2,clk2n;

    clk_2 a(clk,rst_n,clk2); 
    clk_even #(4) b(clk,rst_n,clk2n); 

    initial begin
        clk=0;
        rst_n=0;
        #2 rst_n=1;
    end

    always #1 clk=~clk;

endmodule