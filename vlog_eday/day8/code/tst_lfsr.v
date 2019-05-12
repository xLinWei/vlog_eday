module tst_lfsr();

    reg clk,rst_n;
    wire [2:0] cnt;
    LFSR_counter counter(clk,rst_n,cnt);

    initial begin
        clk=0;
        rst_n=0;
        #2 rst_n=1;
    end

    always #1 clk=~clk;

endmodule