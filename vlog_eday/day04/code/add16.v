module add16 (
    input [15:0] a,
    input [15:0] b,
    output [15:0] sum,
    output cout
);
    
    wire [15:0] c;

    full_add add0(a[0],b[0],0,sum[0],c[0]);
    
    generate 
        genvar i;
        for(i=1;i<16;i=i+1)
        begin:label
            full_add add1(a[i],b[i],c[i-1],sum[i],c[i]); 
        end
    endgenerate

    assign cout=c[15];

endmodule

