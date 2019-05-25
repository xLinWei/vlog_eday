//101序列检测器:一段式
module seq101_1(
	input clk,rst,in,
	output reg out
);
	localparam S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;

	reg [1:0] state;
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			out<=0;
			state<=S0;
		end
		else begin
			case(state)
				S0:begin
					state<=in?S1:S0;
					out<=0;
				end
				S1:begin
					state<=in?S1:S2;
					out<=0;
				end
				S2:begin
					state<=in?S3:S0;
					out<=0;
				end
				S3:begin
					state<=in?S1:S2;
					out<=1;
				end
			endcase
		end
	end

endmodule