//gray2bin.v//
module gray2bin #(parameter n=4) 
(
    input [n-1:0] gray,
    output [n-1:0] bin
);

assign bin={gray[n-1],bin[n-1:1]^gray[n-2:0]};

endmodule