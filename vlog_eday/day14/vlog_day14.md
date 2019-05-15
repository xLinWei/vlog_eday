## vlog_day14:BCD加法器
by [WeiLin](https://github.com/xLinWei)

day1介绍了BCD编码，这回练习BCD加法器。首先是one-digit加法器，即实现2个个位数相加，然后再扩展到多位数。
### 1.one-digit adder
```verilog
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
            {cout,sum}=temp+6;//加6修正
        else
            {cout,sum}=temp;
    end

endmodule
```

### 2.n-digits adder
```verilog
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
```
多位BCD加法器跟二进制加法器类似，都是采用行波进位的思想。这里面使用了generate和`a[base+:width]`的结构简化代码书写。关于`a[base+:width]`结构说明如下：
```verilog
    (1)若 reg a[7:0];
    则 a[3-:4]表示a[3:0]
    a[0+:4]也表示a[3:0]
    
    (2)如果 reg a[0:7];
    那么 a[3-:4]表示a[0:3]
    a[0+:4]也表示a[0:3]
```
        


