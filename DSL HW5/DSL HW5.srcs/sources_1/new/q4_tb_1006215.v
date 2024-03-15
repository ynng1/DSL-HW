module nibbleadd_tb();
    reg [7:0]A;
    reg [7:0]B;
    reg ctrl;
    wire [4:0]q;
    
    nibbleadd nibbleadd_u0(
        .A(A),
        .B(B),
        .ctrl(ctrl),
        .q(q)
    );
    
    initial begin
        //Test for ctrl low (expect 0e)
        ctrl = 1'b0; 
        A = 8'h01;
        B = 8'h0d;
        #10;
        
        //Test for ctrl high(expect 0a)
        ctrl = 1'b1; 
        A = 8'h76;
        B = 8'h3d;
        #10;    
        
        //Test for random cases
        repeat(10) begin
            ctrl = $random;
            A = $random;
            B = $random;
            #10;
        end    
        $finish;
    end
endmodule