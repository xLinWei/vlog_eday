## vlog_day8:LFSR
by [WeiLin](https://github.com/xLinWei)

LFSR(线性反馈移位寄存器)用于产生可重复的伪随机序列，在CRC校验也有用到，后面会介绍CRC。

LFSR分为2种：斐波那契LFSR、伽罗瓦LFSR
###### 斐波那契LFSR：more_to_one
斐波那契LFSR也称作多对一型LFSR，即多个触发器的输出通过异或驱动一个触发器的输入。其反馈多项式=x<sup>3</sup>+x<sup>2</sup>+1
<div align=center><img src=LFSR1.png width=50%></div>


###### 伽罗瓦LFSR：one_to_more
伽罗瓦LFSR也称作一对多型LFSR，即一个触发器的输出通过异或驱动多个个触发器的输入。其反馈多项式=x<sup>3</sup>+x<sup>2</sup>+1
<div align=center><img src=LFSR2.png width=50%></div>

反馈多项式是用来描述LFSR结构的。从上面两个LFSR可以看到即使反馈多项式一样，类型不同的LFSR产生的伪随机序列也不同。一般伽罗瓦LFSR工作速度快，因为其两个触发器间只有一个异或，伽罗瓦LFSR可能会有多个。

下面是图2伽罗瓦LFSR计数器的代码及仿真结果：
```verilog
module LFSR_counter(
    input clk,rst_n,
    output reg  [2:0] cnt
);
    localparam seed=3'b111;//种子，也就是初始值

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=seed;
        else begin
            cnt={cnt[0],cnt[2]^cnt[0],cnt[1]};
        end
    end

endmodule
```
<div align=center><img src=result.png></div>