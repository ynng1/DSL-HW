`timescale 1ns / 1ps

module timer(
    input rstn,
    input clk1hz,
    input clk25hz,
    output  [15:0] bcd_num,
    output reg buzzer,
    output reg [2:0] LED
);

// Timer Section is composed with 4 BCD Number counter(Minute Decade,Minute Unit, Second Decade, Minute Unit);
reg [3:0] sec_unit_bcd_r,sec_deca_bcd_r,min_unit_bcd_r,min_deca_bcd_r; //Register - (Minute Decade,Minute Unit, Second Decade, Second Unit);
reg sec_unit_cout,sec_deca_cout,min_unit_cout; //Carry Out Signal, When 4 BCD Number counter reach upper limit, it will generate a cout signal;

//Counter           Upper Limit
//Minute Decade     5
//Minute Unit       9
//Second Decade     5
//Second Unit       9

always @(posedge clk1hz or negedge rstn)begin
    if(!rstn)begin
        sec_unit_bcd_r <= 4'd0; //Clear BCD Number Counter;
        sec_unit_cout <= 1'b0;  //Clear Cout Signal;
    end
    else begin
        if(sec_unit_bcd_r == 4'h9)begin
            sec_unit_cout <= 1'b1;  //Cout generate a posedge;
            sec_unit_bcd_r <= 4'd0; //Clear BCD Number Counter;
        end
        else begin
            sec_unit_cout <= 1'b0;                      //Clear Cout Signal;
            sec_unit_bcd_r <= sec_unit_bcd_r + 1'b1; // BCD Number Counter increase by '1';
        end
    end
end

always @(posedge sec_unit_cout or negedge rstn)begin
    if(!rstn)begin
        sec_deca_bcd_r <= 4'd0;
        sec_deca_cout <= 1'b0;
    end
    else begin
        if(sec_deca_bcd_r == 4'h5)begin
            sec_deca_cout <= 1'b1;
            sec_deca_bcd_r <= 4'd0;
        end
        else begin
            sec_deca_cout <= 1'b0;
            sec_deca_bcd_r <= sec_deca_bcd_r + 1'b1;
        end
    end
end

always @(posedge sec_deca_cout or negedge rstn)begin
    if(!rstn)begin
        min_unit_bcd_r <= 4'd0;
        min_unit_cout <= 1'b0;
    end
    else begin
        if(min_unit_bcd_r == 4'h9)begin
            min_unit_cout <= 1'b1;
            min_unit_bcd_r <= 4'd0;
        end
        else begin
            min_unit_cout <= 1'b0;
            min_unit_bcd_r <= min_unit_bcd_r + 1'b1;
        end
    end
end

always @(posedge min_unit_cout or negedge rstn)begin
    if(!rstn)begin
        min_deca_bcd_r <= 4'd0;
    end
    else begin
        if(min_deca_bcd_r == 4'h5)begin
            min_deca_bcd_r <= 4'd0;
        end
        else begin
            min_deca_bcd_r <= min_deca_bcd_r + 1'b1;
        end
    end
end

//Buzzer trigger logic (buzzer only turns on when 2nd, 4th, 6th & 8th minute is reached)
always @(posedge clk25hz or negedge rstn) begin
    if(!rstn) begin 
        LED[2:0] <= 3'b0;
        buzzer <= 1'b0;
    end
    else if (min_deca_bcd_r == 4'h0 && min_unit_bcd_r == 4'h1 
    && sec_deca_bcd_r == 4'h0 && sec_unit_bcd_r == 4'h0) begin
        LED[0] <= 1'b1;
        buzzer <= 1'b1; //buzzer only turn on when conditions are met
        #10;
        buzzer <= ~buzzer;
    end
    else if (min_deca_bcd_r == 4'h0 && min_unit_bcd_r == 4'h2 
    && sec_deca_bcd_r == 4'h0 && sec_unit_bcd_r == 4'h0) begin
        LED[1] <= 1'b1;
        buzzer <= 1'b1; //buzzer only turn on when conditions are met
        #10;
        buzzer <= ~buzzer;
    end
    else if (min_deca_bcd_r == 4'h0 && min_unit_bcd_r == 4'h3 
    && sec_deca_bcd_r == 4'h0 && sec_unit_bcd_r == 4'h0) begin
        LED[2] <= 1'b1;
        buzzer <= 1'b1; //buzzer only turn on when conditions are met
        #10;
        buzzer <= ~buzzer;
    end
    else begin
        buzzer <= 1'b0;
    end
end
/*
//LED logic
always @(posedge clk25hz or negedge rstn) begin
    if(!rstn) begin
        LED = 4'b0;
    end else begin 
        case({min_unit_bcd_r, sec_unit_bcd_r})
            8'h10: begin
                LED[0] <= 1'b1;  //after 2 minute 1 LED light up
            end 
            8'h20: begin
                LED[1:0] <= 2'b1;  // after 4 minutes 2 LEDs light up
            end    
            8'h30: begin
                LED[2:0] <= 3'b1;  // after 6 minutes 3 LEDs light up
            end
            8'h40: begin 
                LED[3:0] <= 4'b1;  // after 8 minutes 4 LEDs light up
            end
            default: begin
                LED[0] <= 1'b0;
            end
        endcase
    end
end
*/

//When DIG4 on, BCD Number Display at this moment is bcd_num[3:0];  (i.e Stop Watch - Second Unit)
//When DIG3 on, BCD Number Display at this moment is bcd_num[7:4];  (i.e Stop Watch - Second Decade)
//When DIG2 on, BCD Number Display at this moment is bcd_num[11:8]; (i.e Stop Watch - Minute Unit)
//When DIG1 on, BCD Number Display at this moment is bcd_num[15:12];(i.e Stop Watch - Minute Decade)
assign  bcd_num[15:12]  = min_deca_bcd_r;
assign  bcd_num[11:8]   = min_unit_bcd_r;
assign  bcd_num[7:4]    = sec_deca_bcd_r;
assign  bcd_num[3:0]    = sec_unit_bcd_r;
 
endmodule