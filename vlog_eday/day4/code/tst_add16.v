`timescale 1ns/1ps
module tst_add16();

    reg [15:0] a,b;
    wire [15:0] sum;
    wire cout;

    add16 ins(a,b,sum,cout);

    initial begin
        a=0;
        b=255;
        repeat(10)begin
            #1 a=a+1;
            b=b-1;
        end
    end

endmodule