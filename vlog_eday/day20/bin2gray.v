module bin2gray#(parameter n=8)(
    input [n-1:0] bin,
    output [n-1:0] gray
);

    assign gray=bin^(bin>>1);
    
endmodule