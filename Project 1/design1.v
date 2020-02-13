module design1 (input [7:0] switch, input [1:0] key, output reg [9:0] leds,output [7:0] hex0,output [7:0] hex1,output [7:0] hex2,output [7:0] hex3,output [7:0] hex4,output [7:0] hex5);

always @(key[0])
begin
  if(key[0])
  begin
    leds[7:0] = switch;
  end
  else
  begin
    leds[7:0] = ~switch;
  end
end

//Displays that are the same between our birthdays
reg [3:0] seg2 = 4'b0011;
sevenSeg S0(.val(4'b0001), .seg(hex0));
sevenSeg S1(.val(4'b0000), .seg(hex1));
sevenSeg S2(.val(seg2), .seg(hex2));
sevenSeg S3(.val(4'b0010), .seg(hex3));
sevenSeg S4(.val(4'b1000), .seg(hex4));
sevenSeg S5(.val(4'b0000), .seg(hex5));


//Changing the values that need to be changed
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
