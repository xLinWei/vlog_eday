## vlog_day10:译码和编码
by [WeiLin](https://github.com/xLinWei)

### 一、译码
day1介绍过BCD码，也就是4-10译码器。这里以7段译码器为例：
```verilog
module decoder_7seg(
    input [3:0] din,
    output reg [6:0] segs
);

    always@(*)begin
        case(din)
            0:segs=7'b111_1110;
            1:segs=7'b011_0000;
            2:segs=7'b110_1101;
            3:segs=7'b111_1001;
            4:segs=7'b011_0011;
            5:segs=7'b101_1011;
            6:segs=7'b101_1111;
            7:segs=7'b111_0000;
            8:segs=7'b111_1111;
            9:segs=7'b111_1011;
            default:segs=7'b111_1110;
        endcase
    end

endmodule
```

### 二、编码
编码是译码的反过程，这里以8-3编码器为例。编码器分为常规编码器和有限编码器。
#### 1.常规编码器
常规编码器默认输入为独热码，也就是8个输入仅且只有1个1。这里使用case的另一种用法：判断条件放在case()里，而判断变量放在case的选择通道处。
```verilog
module encoder(
    input [7:0] in,
    output reg [2:0] out
);

    always@(*)begin
        case(1'b1)//输入需是独热码
            in[0]:out=3'b000;
            in[1]:out=3'b001;
            in[2]:out=3'b010;
            in[3]:out=3'b011;
            in[4]:out=3'b100;
            in[5]:out=3'b101;
            in[6]:out=3'b110;
            in[7]:out=3'b111;
            default:out=3'b000;
        endcase
    end

endmodule
```
#### 2.优先编码器
优先编码器是当输入不是独热码时，即输入可能存在多个1，则编码结果由低位的第一个1决定，跟高位的1无关。这里有两种优先编码器写法：1.用casex语句;2.用if else语句。从中可以看出case和if else的区别，**case是并行判断，而if else是有优先级的，是串行判断** 。
```verilog
module priority_encoder(
    input [7:0] in,
    output reg [2:0] out
);
    //第一种写法：用casex语句
    always@(*)begin
        casex(in)
            8'bxxxx_xxx1:out=3'b000;
            8'bxxxx_xx10:out=3'b001;
            8'bxxxx_x100:out=3'b010;
            8'bxxxx_1000:out=3'b011;
            8'bxxx1_0000:out=3'b100;
            8'bxx10_0000:out=3'b101;
            8'bx100_0000:out=3'b110;
            8'b1000_0000:out=3'b111;
            default:out=3'b000;
        endcase
    end 

    // 第二种写法：用if..else
    // always@(*)begin
    //     if(in[0])
    //         out=3'b000;
    //     else if(in[1])
    //         out=3'b001;
    //     else if(in[2])
    //         ...
    //     else if(in[7])
    //         out=3'b111;
    //     else
    //         out=3'b000;
    // end
    
endmodule
```