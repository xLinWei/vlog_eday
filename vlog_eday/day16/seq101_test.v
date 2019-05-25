`timescale 1ns / 1ps
//101序列检测器testbench
module seq101_test();

reg clk,rst,in;
wire out;
seq101_3 ins(clk,rst,in,out);
reg [0:15] data;
integer i;
initial begin
	clk=0;
	rst=0;
	data=16'b0010_1011_0110_1110;
	#1 rst=1;
	#1 rst=0;
end

initial begin
	#1;
	for(i=0;i<16;i=i+1)
		#2 in=data[i];
end

always 
	#1 clk=~clk;

endmodule