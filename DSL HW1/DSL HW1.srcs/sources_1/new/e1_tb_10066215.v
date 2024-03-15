module nor_rs_tb();

    wire q, qb;
    reg r, s;
    
    nor_rs dut1(q, qb, r, s);
    
    initial begin
        s=1; r=0;
        #10 s=1; r=1;
        #10 s=0; r=1;
        #10 s=0; r=0;
        #10;
        $finish;
    end

endmodule