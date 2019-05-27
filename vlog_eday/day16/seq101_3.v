//101序列检测器：三段式
module seq101_3(
	input clk,rst,in,
	output reg out
);
	localparam S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;

	reg [1:0] state,next_state;
    always@(*)begin
        case(state)
			S0:next_state<=in?S1:S0;
			S1:next_state<=in?S1:S2;
			S2:next_state<=in?S3:S0;
			S3:next_state<=in?S1:S2;
			default:next_state<=S0;
		endcase
	end

    always@(posedge clk or posedge rst)begin
        if(rst)
            state<=S0;
        else
            state<=next_state;
    end

	always@(posedge clk or posedge rst)begin
        if(rst)
            out<=0;
        else begin
            case(state)
			S0:out<=0;
			S1:out<=0;
			S2:out<=0;
			S3:out<=1;
			default:out<=0;
		endcase
        end
	end

endmodule