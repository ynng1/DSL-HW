module multiplexer_tb();

reg [1:0]A,B,C,D;
reg [1:0]SEL;
wire [1:0]X;

multiplexer multiplexer_u0(
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .SEL(SEL),
    .X(X)
);

initial begin
    /*
    repeat (4) begin
        SEL <= $random;
        A <= $random;
        B <= $random;
        C <= $random;
        D <= $random;
        #10;
        $finish;
    end
    */
    //Test according to demo testbench result
    A <= 2'b00;
    B <= 2'b01;
    C <= 2'b01;
    D <= 2'b11;
    SEL <= 2'b00;
    #10;
    
    SEL <= 2'b01;
    #10;
    
    SEL <= 2'b10;
    #10;
    
    SEL <= 2'b11;  
    #10;
    $finish;
end

endmodule