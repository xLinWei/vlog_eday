module bcd_adder #(parameter N=100)( 
    input [4*N-1:0] a, b,
    input cin,
    output cout,
    output [4*N-1:0] sum );
    
    genvar i;
    wire [N-1:0] c;
    generate 
        for(i=0;i<N;i=i+1)begin:bcd
            if(i==0)
            	bcd_fadd fadd0(a[4*i+:4],b[4*i+:4],cin,c[i],sum[4*i+:4]);
            else
                bcd_fadd fadd(a[4*i+:4],b[4*i+:4],c[i-1],c[i],sum[4*i+:4]);
        end
    endgenerate
    assign cout=c[N-1];

endmodule