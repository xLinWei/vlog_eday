## vlog_day13:锁存器
by [WeiLin](https://github.com/xLinWei)

在FPGA里应避免使用锁存器，这是因为Latch会加大时序分析的难度，而且会占用较大资源。所以应遵循一些书写规范以避免锁存器的产生。

一般在非时序逻辑中的不完整条件会产生Latch:
    
    不带else字句的if语句
    不带default的case语句

为了避免产生Latch，所有的输出在所有的条件下都需要被驱动，所以需要补全所有的条件：
```verilog
always@(*)begin
    if(sel)
        ...
    else
        ...
end
```
但只是补全所有的条件还不够，还须让所有的输出被驱动，如下代码就会产生Latch:
```verilog
always@(*)begin
    if(sel)
        a=in1;
        b=in2;
    else
        a=in3;//b没有在该条件分支里被赋值
end
```
由于b在else条件没有被赋值，所以也是会综合成Latch。**所以需保证所有的输出在所有的条件分支里均被赋值。** 

一个简单的办法是：**在always块内部开始时为变量分配默认值。**

如下示例所示(示例来自[HDLbits](https://hdlbits.01xz.net/wiki/Always_nolatches))，在always块开始时为所有输出分配默认值。这种书写方式可以保证输出总是被默认值驱动，除非case分支有被赋值。这样就没有必要在case的所有分支里为4个输出全部赋值，简化了代码书写。
```verilog
module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 
    
    always@(*)begin
       left=0;down=0;right=0;up=0;
        case(scancode)
            16'he06b:left=1;
            16'he072:down=1;
            16'he074:right=1;
            16'he075:up=1;
        endcase
    end

endmodule
```