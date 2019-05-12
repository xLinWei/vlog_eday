## vlog_day3:边沿检测
by [WeiLin](https://github.com/xLinWei)

### 一、同步边沿检测
边沿检测有 _同步_ 和 _异步_ 之分。同步是指待检测信号来自同一个时钟域，不需要对其进行同步处理；而异步是指待检测信号是异步信号，需要对其进行两级触发器同步。

先介绍同步边沿检测,需要检测上升沿、下降沿，或同时检测上升沿下降沿,其代码如下：
```verilog
module sync_edge(
    input clk,rst_n,sig,
    output rise_edge,fall_edge,sig_edge
);
    reg sig_r;

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            sig_r<=0;
        else
            sig_r<=sig;
    end

    assign rise_edge=sig & !sig_r;
    assign fall_edge=!sig & sig_r;
    assign sig_edge=sig ^ sig_r;

endmodule
```
其思想就是将信号用D触发器延时一个时钟，然后做判断即可，逻辑图如下。
<div align=center><img src=sync_edge.png></div>
其仿真结果如下：
<div align=center><img src=wave.png></div>

### 二、异步边沿检测
异步信号需要考虑亚稳态的问题，所以需要做同步处理，一般使用两级触发器。
```verilog
module nsync_edge(
    input clk,rst_n,sig,
    output rise_edge,fall_edge,sig_edge
);

    reg sig_r1,sig_r2,sig_r3;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            sig_r1<=0;
            sig_r2<=0;
            sig_r3<=0;
        end
        else begin
            sig_r1<=sig;
            sig_r2<=sig_r1;
            sig_r3<=sig_r2;
        end
    end
    assign rise_edge = sig_r2 & !sig_r3;
    assign fall_edge = !sig_r2 & !sig_r3;
    assign sig_edge = sig_r2 ^ sig_r3;

endmodule
```
异步上升沿检测逻辑图如下图所示，只需在同步逻辑前加两级触发器即可。
<div align=center><img src=nsync_edge.png width=70%></div>