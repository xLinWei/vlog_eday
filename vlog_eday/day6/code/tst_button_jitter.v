`timescale 1ns/1ps
module tst_button_jitter();

    reg clk,rst_n,key;
    wire key_out;

    button_jitter butjit(clk,rst_n,key,key_out);

    always #1 clk=~clk;

    initial begin
        clk=0;
        rst_n=0;
        key=0;
        #1 rst_n=1;
        #2 key=1;
        repeat(20)begin
            #2 key={$random()}%2;
        end
        #2 key=1;
        #50 repeat(20)begin
            #2 key={$random()}%2;
        end
        #2 key=0;
    end

endmodule