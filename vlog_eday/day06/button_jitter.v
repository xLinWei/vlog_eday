//按键去抖动,输入时钟12MHZ,最大抖动时间2us
//(实际最大抖动时间应该是15ms左右，这里为了便于仿真设为2us)
//那么需要计时2us*12MHz=24
//这里key=1时表示按键被按下
module button_jitter(
    input clk,rst_n,key,
    output reg key_out
);
    localparam COUNTS=24;

    reg key_r1,key_r2,key_r3;//Key信号是异步的，需要进行同步
    wire sig_edge;  //边沿检测，包括上升沿和下降沿
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            key_r1<=0;
            key_r2<=0;
            key_r3<=0;
        end
        else begin
            key_r1<=key;
            key_r2<=key_r1;
            key_r3<=key_r2;
        end
    end
    assign sig_edge=key_r2 ^ key_r3;

    reg start_flag;//开始计时的标志
    reg [7:0] cnt;//计数器
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            start_flag<=0;
        else if(sig_edge)//检测到边沿时开始计时
            start_flag<=1;
        else if(cnt>=COUNTS)//计满时停止
            start_flag<=0;
        else 
            start_flag<=start_flag;
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt<=0;
        else begin
            if(start_flag)
                cnt<=cnt+1;
            else
                cnt<=0;
        end
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            key_out<=0;
        else begin
            if(cnt==COUNTS)//当计满时，输出反向
                key_out<=!key_out;
            else     //否则保持不变
                key_out<=key_out;
        end
    end

endmodule