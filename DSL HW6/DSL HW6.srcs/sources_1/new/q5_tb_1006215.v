module CCTA_tb ();

    reg [3:0] A;
    reg [3:0] B;
    reg [3:0] C;
    reg rst;
    reg ctrl;
    wire [4:0] q;
    
    CCTA CCTA_u0(
        .A(A),
        .B(B),
        .C(C),
        .rst(rst),
        .ctrl(ctrl),
        .q(q)
    );
    
    initial begin 
      //Test reset fucntion (expect 00)
      rst = 1'b1; 
      #10;
      
      rst = 1'b0;
      
      //Test ctrl low based on demo testbench (expect 05)
      ctrl = 1'b0;
      A = 4'h4;
      B = 4'h1;
      C = 4'h9;
      #10;
      
      //Test ctrl high based on demo testbench (expect 1c)
      ctrl = 1'b1;
      A = 4'h6;
      B = 4'h5;
      C = 4'hA;
      #10;
      
      //Test for random
      repeat(10) begin
        ctrl = $random;
        A = $random;
        B = $random;
        C = $random;
        #10;
      end
      
      $finish;
    end

endmodule