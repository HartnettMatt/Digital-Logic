module top (ADC_CLK_10, SW, KEY, LEDR, HEX0);


input ADC_CLK_10;
input [2:0] SW;
input [1:0] KEY;
wire clock;
output reg [9:0] LEDR;
output [7:0] HEX0;
reg [2:0] left_LEDs;
reg [2:0] right_LEDs;

wire [2:0] l_LEDS;
wire [2:0] r_LEDS;

always @(l_LEDS or r_LEDS)
begin
    left_LEDs <= l_LEDS;
    right_LEDs <= r_LEDS;
end

clockDivider C0 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .divide_by(1000000), .clock_out(clock));
blink B0 (.clock(clock), .hazards(SW[0]), .reset_n(KEY[0]), .turnChange(KEY[1]), .rightLEDs(r_LEDS), .leftLEDs(l_LEDS), .hex(HEX0));

initial
begin
    LEDR[9:0] = 10'b0000000000;
end


always @(SW[2:0] or KEY[1] or KEY[0])
begin
    //RESET
    if (~KEY[0])
    begin
        LEDR[9:0] = 10'b0000000000;
    end
    //BEHAVIOR 1: IDLE
    else if (~SW[1] & ~SW[0] & ~SW[2] & KEY[0])
    begin
        LEDR[2:0] <= 3'b000;
        LEDR[9:7] <= 3'b000;
    end
    //BEHAVIOR 2: LEFT TURN
    else if (SW[1] & KEY[1] & ~SW[0] & ~SW[2] & KEY[0])
    begin
        LEDR[9:7] <= left_LEDs;
        LEDR[2:0] <= 3'b000;
    end
    //BEHAVIOR 3: RIGHT TURN
    else if (SW[1] & ~KEY[1] & ~SW[0] & ~SW[2] & KEY[0])
    begin
        LEDR[9:7] <= 3'b000;
        LEDR[2] <= right_LEDs[0];
        LEDR[1] <= right_LEDs[1];
        LEDR[0] <= right_LEDs[2];
    end
    //BEHAVIOR 4: LEFT BRAKE
    else if (SW[1] & KEY[1] & ~SW[0] & SW[2] & KEY[0])
    begin
        LEDR[9:7] <= left_LEDs;
        LEDR[2:0] <= 3'b111;
    end
    //BEHAVIOR 5: RIGHT BRAKE
    else if (SW[1] & ~KEY[1] & ~SW[0] & SW[2] & KEY[0])
    begin
        LEDR[9:7] <= 3'b111;
        LEDR[2] <= right_LEDs[0];
        LEDR[1] <= right_LEDs[1];
        LEDR[0] <= right_LEDs[2];
    end
    //BEHAVIOR 6: STRAIGHT BRAKE
    else if ((~SW[1] & SW[2] & KEY[0]) | (SW[0] & SW[1] & SW[2]))
    begin
        LEDR[2:0] <= 3'b111;
        LEDR[9:7] <= 3'b111;
    end
    //BEHAVIOR 7: HAZARDS
    else if (SW[0] & ~SW[2] & KEY[0])
    begin
        LEDR[9:7] <= left_LEDs;
        LEDR[2] <= right_LEDs[0];
        LEDR[1] <= right_LEDs[1];
        LEDR[0] <= right_LEDs[2];
    end
    else
    begin
        LEDR[9:0] = 10'b1111111111;
    end
end

endmodule
