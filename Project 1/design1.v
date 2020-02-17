//The purpose of this design is to have LEDR[7:0] to be controlled by SW[7:0], and have KEY[0] invert the values. Additionally, HEX[5:0] are used to display lab partners birthday, and when KEY[1] is high, change to my birthday
module design1 (switch,key,leds,hex0,hex1,hex2,hex3,hex4,hex5);

input [9:0] switch;
input [1:0] key;
output [9:0] leds;
output [7:0] hex0;
output [7:0] hex1;
output [7:0] hex2;
output [7:0] hex3;
output [7:0] hex4;
output [7:0] hex5;

//Light the leds based on the switch positions, and invert the leds when key0 is high
reg [9:0] leds1;
assign leds = leds1;
always @(key[0])
begin
  leds1[9:8] = 2'b00;
  leds1[7:0] = 8'b00000000;
  if(key[0])
  begin
    leds1[7:0] = switch[7:0];
  end
  else
  begin
    leds1[7:0] = ~switch[7:0];
  end
end

//seg2 is a reg for the display that needs to be changed
reg [3:0] seg2 = 4'b0011;
sevenSeg S2(.val(seg2), .seg(hex2));

//These displays stay the same between the two dates
sevenSeg S0(.val(4'b0001), .seg(hex0));
sevenSeg S1(.val(4'b0000), .seg(hex1));
sevenSeg S3(.val(4'b0010), .seg(hex3));
sevenSeg S4(.val(4'b1000), .seg(hex4));
sevenSeg S5(.val(4'b0000), .seg(hex5));


//Changing the displays that need to be changed based on key1
always @(key[1])
begin
  if(key[1])
  begin
    seg2 = 4'b0011;
  end
  else
  begin
    seg2 = 4'b0100;
  end
end

endmodule
