//bin2gray.v//
//方法：向右移1再异或
module bin2gray #(parameter n=4)
(
    input [n-1:0] bin,
    output [n-1:0] gray
);

assign gray= (bin>>1) ^ bin;

endmodule