//异步FIFO
module asunc_fifo#(
    parameter FIFO_DEATH=16,
    parameter FIFO_WIDTH=8
)(
    input clk1,//写时钟
    input rst1,
    input we,//写使能
    input [FIFO_WIDTH-1:0]din,

    input clk2,//读时钟
    input rst2,
    input re,//读使能
    output reg [FIFO_WIDTH-1:0]dout,

    output full,
    output empty
);

localparam ADDR_WIDTH=$clog2(FIFO_DEATH);

reg [FIFO_WIDTH-1:0] RAM [FIFO_DEATH-1:0];

reg [ADDR_WIDTH:0] w_ptr;//需要多1位
always@(posedge clk1 or posedge rst1)begin
    if(rst1)
        w_ptr<=0;
    else begin
        if(we && !full)begin
            RAM[w_ptr]<=din;
            w_ptr<=w_ptr+1;
        end
        else
            w_ptr<=w_ptr;
    end
end

reg [ADDR_WIDTH:0] r_ptr;//需要多1位
always@(posedge clk2 or posedge rst2)begin
    if(rst2)
        r_ptr<=0;
    else begin
        if(re && !empty)begin
            dout<=RAM[r_ptr];
            r_ptr<=r_ptr+1;
        end
        else
            r_ptr<=r_ptr;
    end
end
////////指针同步/////////
reg [ADDR_WIDTH:0] w_ptr_g;//gray写指针
bin2gray #(ADDR_WIDTH+1) bg1(w_ptr,w_ptr_g);

reg [ADDR_WIDTH:0] w_ptr_g1;//两级同步器中间值
reg [ADDR_WIDTH:0] w_ptr_s;//同步后的写指针
always@(posedge clk1 or posedge rst1)begin
    if(rst1)begin
        w_ptr_g1<=0;
        w_ptr_s<=0;
    end 
    else begin
        w_ptr_g1<=w_ptr_g;
        w_ptr_s<=w_ptr_g1;
    end
end


reg [ADDR_WIDTH:0] r_ptr_g;//gray读指针
bin2gray #(ADDR_WIDTH+1) bg2(r_ptr,r_ptr_g);

reg [ADDR_WIDTH:0] r_ptr_g1;//两级同步器中间值
reg [ADDR_WIDTH:0] r_ptr_s;//同步后的读指针
always@(posedge clk2 or posedge rst2)begin
    if(rst1)begin
        r_ptr_g1<=0;
        r_ptr_s<=0;
    end 
    else begin
        r_ptr_g1<=r_ptr_g;
        r_ptr_s<=r_ptr_g1;
    end
end
////////空满判断////////
assign full=((!w_ptr_g[ADDR_WIDTH-:2]==r_ptr_s[ADDR_WIDTH-:2])&&(w_ptr_g[ADDR_WIDTH-2:0]==r_ptr_s[ADDR_WIDTH-2:0]))?1:0;
assign empty=(r_ptr_g==w_ptr_s)?1:0;

endmodule