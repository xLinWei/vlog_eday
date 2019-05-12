## vlog_day9:校验码
by [WeiLin](https://github.com/xLinWei)

校验码有很多，这里介绍奇偶校验和CRC校验：

### 一、奇偶校验
奇校验就是包括末尾的校验码总的1的个数为奇数，而偶校验就是包括末尾的校验码总的1的个数为偶数。之前说过，异或是统计输入的奇偶性，所以奇偶校验用异或实现：
```verilog
assign even=^data;
assign odd=!even;
```

### 二、CRC校验
CRC(循环冗余校验)结构跟LFSR一样，就是通过反馈移位寄存器实现的，所不同的是CRC有数据输入端：
<div align=center><img src=crc.png width=60%></div>

所以其代码跟LFSR相似：
```verilog
module crc(
    input clk,rst_n,din,
    output reg  [2:0] cnt
);
    localparam seed=3'b111;//种子，也就是初始值

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=seed;
        else begin
            cnt={din^cnt[0],din^cnt[0]^cnt[2],cnt[1]};
        end
    end

endmodule
```