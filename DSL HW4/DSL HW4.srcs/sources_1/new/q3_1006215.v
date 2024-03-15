module demultiplexer(
    input [1:0]A,
    input [1:0]SEL,
    output reg [1:0]W,
    output reg [1:0]X,
    output reg [1:0]Y,
    output reg [1:0]Z
);

always @(SEL or A) begin
    case(SEL)
        2'b00: begin
            W <= A;
            X <= 2'b00;
            Y <= 2'b00;
            Z <= 2'b00;
        end
        
        2'b01: begin
            W <= 2'b00;
            X <= A;
            Y <= 2'b00;
            Z <= 2'b00;
        end
        
        2'b10: begin
            W <= 2'b00;
            X <= 2'b00;
            Y <= A;
            Z <= 2'b00;
        end
        
        2'b11: begin
            W <= 2'b00;
            X <= 2'b00;
            Y <= 2'b00;
            Z <= A;
        end
    endcase
end
endmodule

