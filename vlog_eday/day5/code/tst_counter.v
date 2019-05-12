//test for counter(_XXX).v
module tst_counter();

    reg clk,rst_n;
    wire [3:0] cnt,cnt_john,cnt_loop,cnt_gray;

    counter cnt0(clk,rst_n,cnt);
    counter_john cnt1(clk,rst_n,cnt_john);
    counter_loop cnt2(clk,rst_n,cnt_loop);
    counter_gray cnt3(clk,rst_n,cnt_gray);

    initial begin
        clk=0;
        rst_n=0;
        #2 rst_n=1;
    end
    always #1 clk=~clk;

endmodule