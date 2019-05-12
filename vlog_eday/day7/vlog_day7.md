## vlog_day7:Gray码
by [WeiLin](https://github.com/xLinWei)

<div align=center><img src=gray0.png width=40%></div>
相邻编码间只有1bit不同，除最高位外镜像对称。在异步FIFO里Gray码有重要的作用，后面会详细介绍异步FIFO。可以通过右移异或得到Gray码：

```verilog
bin->gray: assign gray = (bin >> 1) ^ bin;
gray->bin: assign bin = {gray[n-1],bin[n-1:1]^gray[n-2:0]};
```
结构图如下所示(以4bit为例)，Gray的详细介绍参考[这里](https://www.eetimes.com/document.asp?doc_id=1274549).

<div align=center><img src=gray.png width=60%></div>

下面为具体代码及仿真波形：
<div align=center><img src=result.png></div>

```verilog
//bin2gray.v//
//方法：向右移1再异或
module bin2gray #(parameter n=4)
(
    input [n-1:0] bin,
    output [n-1:0] gray
);
    assign gray= (bin>>1) ^ bin;
endmodule

//gray2bin.v//
module gray2bin#(parameter n=4) 
(
    input [n-1:0] gray,
    output [n-1:0] bin
);
    assign bin={gray[n-1],bin[n-1:1]^gray[n-2:0]};
endmodule
```

_**Question:** 有可能为任何非2幂数(只要是偶数)生成一个Gray码计数器吗?点击该[链接](https://www.embedded.com/print/4015117)参看问题及答案._
