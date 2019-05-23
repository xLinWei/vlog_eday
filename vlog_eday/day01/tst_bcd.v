//testbench of bcd_decoder.v
module tst_bcd();

    reg [3:0] in;
    wire [9:0] out;

    bcd_decoder bcd0(in,out);

    integer i;
    initial begin
        for(i=0;i<16;i=i+1)
            #2 in=i;
    end

endmodule