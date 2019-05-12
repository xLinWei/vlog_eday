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