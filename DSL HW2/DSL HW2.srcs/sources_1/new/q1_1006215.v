module decade_counter(
    input clk,
    input rst,
    output reg [3:0] count,
    output reg ten
);

    always @(posedge clk or posedge rst) begin
        count <= 1'b0;
        if (rst) begin
            count <= 1'b0;
            ten <= 1'b0;
        end else begin
            count <= count + 1'b1;
            if (count == 4'b1001) begin
                count <= 4'b0;
            end
            ten <= (count == 4'b1001);
        end
    end  

endmodule