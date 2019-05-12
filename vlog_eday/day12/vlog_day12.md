## vlog_day12:复位
by [WeiLin](https://github.com/xLinWei)

复位分为：同步复位、异步复位、异步复位同步释放
### 1.同步复位
```verilog
always(posedge clk)begin
    if(!rst_n)
        ...
end
```

### 2.异步复位
```verilog
always(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ...
end
```

### 3.异步复位同步释放
这里重点介绍异步复位同步释放。异步复位会有问题，即复位结束时刻(释放时刻)恰在亚稳态窗口内时，无法决定现在的复位状态是1还是0，会导致亚稳态。之所以需要异步复位、同步释放是因为异步rst信号置位是不需要clk采样，而rst释放时是需要clk采样的，所以释放需要同步。

分两种情况，一个是低电平复位，一个是高电平复位：
<div align=center><img src=rst_n.png width=50%></div>

```verilog
module reset1(
    input clk,rst_n,
    output reg rst_n_out
);
    reg rst_n_reg;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            rst_n_out<=0;
        else begin
            rst_n_reg<=1;
            rst_n_out<=rst_n_reg;
        end
    end
endmodule
```
<div align=center><img src=rst.png width=50%></div>

```verilog
module reset1(
    input clk,rst,
    output reg rst_out
);
    reg rst_reg;
    always@(posedge clk or negedge rst)begin
        if(rst)
            rst_out<=1;
        else begin
            rst_reg<=0;
            rst_out<=rst_reg;
        end
    end
endmodule
```
