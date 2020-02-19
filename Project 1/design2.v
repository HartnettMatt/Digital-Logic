module design2 (switch, leds, hex0, hex1, hex2, hex3, hex4, hex5);

input [9:0] switch;
output [9:0] leds;
output [7:0] hex0;
output reg [7:0] hex1;
output reg [7:0] hex2;
output reg [7:0] hex3;
output [7:0] hex4;
output reg [7:0] hex5;

sevenSeg U0 (.val(switch[3:0]), .seg(hex0));
sevenSeg U1 (.val(switch[7:4]), .seg(hex4));

reg [9:0] leds2;
assign leds = leds2;
always@ (switch[7:0])
begin
    // leds2[8] = 1'b0;
    // leds2[9] = 1'b0;
    leds2[9:0] = 10'b00_0000_0000;
    hex2 = 8'b1111_1111;
    hex3 = 8'b1111_1111;
    if (switch[7:4] > switch[3:0])
    begin
        leds2[0] = 1'b0;
        leds2[1] = 1'b1;
        leds2[2] = 1'b0;
        hex1 = 8'b1100_0111;
        hex5 = 8'b1111_1111;
    end
    else if (switch[7:4] < switch[3:0])
    begin
        leds2[0] = 1'b1;
        leds2[1] = 1'b0;
        leds2[2] = 1'b0;
        hex1 = 8'b1111_1111;
        hex5 = 8'b1100_0111;
    end
    else
    begin
        leds2[0] = 1'b0;
        leds2[1] = 1'b0;
        leds2[2] = 1'b1;
        hex1 = 8'b1000_0110;
        hex5 = 8'b1000_0110;
    end
end
endmodule
