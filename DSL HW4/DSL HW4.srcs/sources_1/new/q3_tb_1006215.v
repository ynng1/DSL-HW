module demultiplexer_tb();

reg [1:0]A;
reg [1:0]SEL;
wire [1:0]W;
wire [1:0]X;
wire [1:0]Y;
wire [1:0]Z;

demultiplexer demultiplexer_u0(
    .A(A),
    .SEL(SEL),
    .W(W),
    .X(X),
    .Y(Y),
    .Z(Z)
);

initial begin
    //Test cases based on demo testbench result
    A = 2'b00;
    SEL = 2'b00;
    #10;
    
    A = 2'b01;
    SEL = 2'b01;
    #10;
    
    A = 2'b01;
    SEL = 2'b10;
    #10;
    
    A = 2'b11;
    SEL = 2'b11;
    #10;
    
    $finish;
    
end

endmodule