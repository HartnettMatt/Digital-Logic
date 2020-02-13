module design2 (switches, leds, hex0, hex1, hex2, hex3, hex4, hex5);

input [9:0] switches;
output reg [9:0] leds;
output [7:0] hex0;
output reg [7:0] hex1;
output reg [7:0] hex2;
output reg [7:0] hex3;
output [7:0] hex4;
output reg [7:0] hex5;

sevenSeg U0 (.val(switches[3:0]), .seg(hex0));
sevenSeg U1 (.val(switches[7:4]), .seg(hex4));

always@ (switches[7:0])
begin
    leds[8] = 1'b0;
    leds[9] = 1'b0;
    hex2 = 8'b1111_1111;
    hex3 = 8'b1111_1111;
    if (switches[7:4] > switches[3:0])
    begin
        leds[0] = 1'b0;
        leds[1] = 1'b1;
        leds[2] = 1'b0;
        hex1 = 8'b1100_0111;
        hex5 = 8'b1111_1111;
    end
    else if (switches[7:4] < switches[3:0])
    begin
        leds[0] = 1'b1;
        leds[1] = 1'b0;
        leds[2] = 1'b0;
        hex1 = 8'b1111_1111;
        hex5 = 8'b1100_0111;
    end
    else
    begin
        leds[0] = 1'b0;
        leds[1] = 1'b0;
        leds[2] = 1'b1;
        hex1 = 8'b1000_0110;
        hex5 = 8'b1000_0110;
    end
end
endmodule
