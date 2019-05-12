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