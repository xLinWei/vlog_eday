## vlog_day5:计数器
by [WeiLin](https://github.com/xLinWei)

### 1.二进制计数器
二进制计数器就是经常用的普通计数器，对于n bit，有2^n-1个计数，代码如下(代码中是4bit)：
```verilog
//4bit计数器
module counter(
    input clk,rst_n,
    output reg [3:0] cnt
);
    //always@(posedge clk)//同步复位
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=0;
        else
            cnt<=cnt+1;
    end
endmodule

```
### 2.环形计数器
环形计数器就是将1循环移位，对于n bit，有n个计数，规律如下所示(代码中是4bit)：
<div align=center><img src=ring.png width=60%></div>

```verilog
//环形计数器
module counter_loop(
    input clk,rst_n,
    output reg [3:0] cnt
);

    always@(posedge clk)begin
        if(!rst_n)
            cnt<=4'b0001;
        else
            cnt<={cnt[2:0],cnt[3]};//循环左移，不能用移位操作符
    end

endmodule
```
### 3.约翰逊计数器
Johnson计数器又叫扭环计数器,对于n bit，有2n个计数，规律如下所示(代码中是4bit)：                       
<div align=center><img src=Tring.png width=60%></div>

```verilog
//Johnson计数器
module counter_john(
    input clk,rst_n,
    output reg [3:0] cnt
);

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=0;
        else if(cnt[3])
            cnt<=cnt<<1;
        else
            cnt<={cnt[2:0],1'b1};
    end
    //替换成cnt<={cnt[2:0],~cnt}[3]};会更简洁点

endmodule
```
### 4.格雷码计数器
Gray码后面会详细讲解，其特点就是相邻编码间只有1bit不同，代码如下(代码中是4bit)：
<div align=center><img src=gray0.png width=60%></div>

```verilog
//Gray计数器
module counter_gray(
    input clk,rst_n,
    output [3:0] cnt
);
    reg [3:0] bin_cnt;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            bin_cnt<=0;
        else
            bin_cnt<=bin_cnt+1;
    end

    assign cnt=bin_cnt ^ (bin_cnt>>1);

endmodule
```

### 5.LFSR计数器
线性反馈计数器，能够产生伪随机序列,序列个数跟线性反馈移位寄存器的设计有关，不一定是2^n-1。后面会详细介绍。

仿真波形如下：
<div align=center><img src=result.png width=80%></div>