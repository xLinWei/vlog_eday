module test_bcd_fadd();

    reg [3:0] a,b;
    reg cin;
    wire [3:0] sum;
    wire cout;

    bcd_fadd fadd(a,b,cin,cout,sum);

    integer i,j;
    initial begin
        cin=0;
        for(i=0;i<10;i=i+1)begin
            for(j=0;j<10;j=j+1)begin
                #1 a=i;b=j;
            end
        end
    end

endmodule