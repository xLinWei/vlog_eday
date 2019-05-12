## vlog_day4:加法器
by [WeiLin](https://github.com/xLinWei)

### 一、半加器/全加器
a | b |cout|sum
:-:|:-:|:-:|:-:
0|0|0|0
0|1|0|1
1|0|0|1
1|1|1|0

加法器从半加器开始。如果观察半加器的真值表，很容易发现`sum=a^b,cout=a&b;`还可以发现{cout,sum}是对1的个数进行编码，其实更深层的意义是：
```
sum统计的是a,b的奇偶性。偶数个1，则sum=0；奇数个1，则sum=1。因此用异或统计奇偶性。
cout统计的是a,b中1的个数。如果有两个1，则cout=1,否则cout=0。因此用与门统计1的个数是否大于等于2。
```
上述描述也适用于全加器。在verilog里有3种方法描述全加器：
```
//方法1：
assign {cout，sum}= a+b+cin;
//方法2：
assign sum=a^b^cin;
assign cout=(a&b) | ((a^b)&cin);
//方法3：
assign sum=a^b^cin;
assign cout=(a&b) | (a&cin) | (b&cin);
```
一般采用第1种方法，让综合器自行优化。
### 二、行波进位加法器
对于多bit加法器，采用行波进位加法器是比较方便的。比如16位加法器，只需要例化16个全加器即可。但是重复的例化16次未免有点繁琐，可以利用generate减少重复的手动工作：
```verilog
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
```
当然行波进位加法器延时会比较长，可以用超前进位加法器缩短关键路径，减小延时。
### 三、溢出检测
首先需要知道溢出和进位输出是不一样的：1.溢出是错误，而进位不是；2.溢出是有符号数相加发生错误，比如两个正数相加得到负数，两个负数相加得到正数；3.进位是无符号数相加超出范围，虽然有符号数相加也会产生进位，但对于加法器来讲，它是当做无符号数来处理的。

所以由上面可知，溢出发生在同符号数相加且得到符号相反的结果。这是因为两个不同符号的数(正数+负数)相加，得到的结果一定在这两个数之间，是不会产生溢出的。所以可以用两个异或门加一个与门来判断是否发生溢出：
<div align=center><img src=ovf1.png width=50%></div>

事实上，可以只用一个异或门就可判断是否溢出，如下图所示。当符号位a[n-1]=b[n-1]=1时，如果cin=0，则s[n-1]=0,发生溢出；当符号位a[n-1]=b[n-1]=0时，如果cin=1,则s[n-1]=1,发生溢出。所以当最高位和次高位进位输出(c[n],c[n-1])不同时，发生溢出。
<div align=center><img src=ovf2.png width=50%></div>


