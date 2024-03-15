module CCTA(
        input [3:0] A,
        input [3:0] B,
        input [3:0] C,
        input rst,
        input ctrl,
        output reg [4:0] q
);

always @(A or B or C or rst or ctrl or q) begin
    if(rst) begin
        q <= 1'b0;
    end
    else begin
        case(ctrl)
            1'b0: q <= A + B;
            1'b1: q <= A - C;
            default: q <= 5'bx;
        endcase
    end
end

endmodule