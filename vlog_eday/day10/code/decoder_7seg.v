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