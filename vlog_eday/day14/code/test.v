module test();

reg [7:0] a;
reg [0:7] b;

initial begin
    a=8'b0001_0111;
    b=8'b0001_0111;
    $display("%b",a[4-:4]);
    $display("%b",a[0+:4]);
    $display("%b",b[4-:4]);
    $display("%b",b[0+:4]);
end

endmodule