//testbench for bin2gray.v & gray2bin
`timescale 1ns/1ps
module tst_gray();

    parameter n=4;
    reg [n-1:0] bin;
    wire [n-1:0] gray,out;

    bin2gray #(n) b2g(bin,gray);
    gray2bin #(n) g2b(gray,out);

    initial 
        bin=0;
    always 
        #1 bin=bin+1;

endmodule