module decade_counter_tb();

    reg clk;
    reg rst;
    wire [3:0] count;
    wire ten;

    decade_counter decade_counter_u0(
        .clk(clk),
        .rst(rst),
        .count(count),
        .ten(ten)
    );
    
    always begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end
    
    initial begin
        rst = 1'b1;
        #20
        #10 rst = 1'b0;
        #200 $stop;       
    end
endmodule