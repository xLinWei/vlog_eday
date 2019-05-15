module bcd_fadd(
    input [3:0] a,b,
    input cin,
    output reg cout,
    output reg [3:0] sum
);
    reg [4:0] temp;
    always@(*)begin
        temp=a+b+cin;
        if(temp>9)
            {cout,sum}=temp+6;
        else
            {cout,sum}=temp;
    end

endmodule