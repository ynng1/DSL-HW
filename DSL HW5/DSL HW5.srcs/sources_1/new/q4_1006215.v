module nibbleadd(
    input [7:0]A,
    input [7:0]B,
    input ctrl,
    output reg [4:0]q
);

always @(ctrl) begin
    if(ctrl == 1'b0) begin
        q <= A[3:0] + B[3:0];
    end else begin
        q <= A[7:4] + B[7:4];
    end
end
endmodule