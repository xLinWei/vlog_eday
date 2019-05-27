//同步FIFO
module sync_fifo#(
    parameter FIFO_DEATH=16,
    parameter FIFO_WIDTH=8
)(
    input clk,rst_n,

    input wr_en,
    input [FIFO_WIDTH-1:0] data_in,
    output full,

    input rd_en,
    output reg [FIFO_WIDTH-1:0] data_out,
    output empty
);

localparam ADDR_WIDTH=$clog2(FIFO_DEATH);

reg [FIFO_WIDTH-1:0] RAM [FIFO_DEATH-1:0];

reg [ADDR_WIDTH:0] fifo_cnt;//需要多1位
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        fifo_cnt<=0;
    else begin
        if(wr_en && !rd_en && (fifo_cnt!=FIFO_DEATH))
            fifo_cnt<=fifo_cnt+1;
        else if(!wr_en && rd_en && (fifo_cnt!=0))
            fifo_cnt<=fifo_cnt-1;
        else
            fifo_cnt<=fifo_cnt;
    end

end

reg [ADDR_WIDTH-1:0] wr_addr;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        wr_addr<=0;
    else begin
        if(wr_en && (fifo_cnt!=FIFO_DEATH))begin
            RAM[wr_addr]<=data_in;
            wr_addr<=wr_addr+1;
        end 
        else
            wr_addr<=wr_addr;
    end
end

reg [ADDR_WIDTH-1:0] rd_addr;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_addr<=0;
    else begin
        if(rd_en && (fifo_cnt!=0))begin
            data_out<=RAM[rd_addr];
            rd_addr<=rd_addr+1;
        end
    end
end

assign full=(fifo_cnt==FIFO_DEATH) ? 1'b1 : 1'b0;
assign empty=(fifo_cnt==0) ? 1'b1 : 1'b0;

endmodule