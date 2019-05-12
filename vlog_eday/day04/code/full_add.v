module full_add ( 
    input a, b, cin,   
    output sum, cout 

);
    //assign {cout,sum}=a+b+cin;
    wire p;
    assign p=a^b;
    assign sum=p^cin;
    assign cout=(a&b)|(p&cin);

endmodule