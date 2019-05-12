//BCD译码器，也就是4-10译码器
//3种方法：1.移位；2.case语句;3.门结构
module bcd_decoder(
    input [3:0] in,
    output[9:0] out
);

//方法1：1左移相应位
//assign out=1<<in;

//方法2：case语句
reg [9:0] out_reg;
always@(*)begin
    case(in)
        0:out_reg=10'b00_0000_0001;
        1:out_reg=10'b00_0000_0010;
        2:out_reg=10'b00_0000_0100;
        3:out_reg=10'b00_0000_1000;
        4:out_reg=10'b00_0001_0000;
        5:out_reg=10'b00_0010_0000;
        6:out_reg=10'b00_0100_0000;
        7:out_reg=10'b00_1000_0000;
        8:out_reg=10'b01_0000_0000;
        9:out_reg=10'b10_0000_0000;
        default:out_reg=10'b00_0000_0000;
    endcase
end
assign out=out_reg;

//方法3：门结构
// assign out[0]= ~in[3] & ~in[2] & ~in[1] & ~in[0];
// ...
// assign out[9]= in[3] & ~in[2] & ~in[1] & in[0];

endmodule