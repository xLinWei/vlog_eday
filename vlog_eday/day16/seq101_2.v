//101序列检测器：两段式
module seq101_2(
	input clk,rst,in,
	output reg out
);
	localparam S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;

	reg [1:0] state,next_state;
    always@(posedge clk or posedge rst)begin
        if(rst)
            state<=S0;
        else
            state<=next_state;
    end

	always@(*)begin
        case(state)
			S0:begin
				next_state<=in?S1:S0;
				out<=0;
			end
			S1:begin
				next_state<=in?S1:S2;
				out<=0;
			end
			S2:begin
				next_state<=in?S3:S0;
				out<=0;
			end
			S3:begin
				next_state<=in?S1:S2;
				out<=1;
			end
		endcase
	end

endmodule