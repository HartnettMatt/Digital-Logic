module design1 (input [7:0] switch, input y, output [7:0] leds,output [7:0] hex0,output [7:0] hex1,output [7:0] hex2,output [7:0] hex3,output [7:0] hex4,output [7:0] hex5);

assign leds = ~switch;

sevenSeg S0(.val(4'b0001), .seg(hex0));
sevenSeg S1(.val(4'b0000), .seg(hex1));
sevenSeg S2(.val(4'b0011), .seg(hex2));
sevenSeg S3(.val(4'b0010), .seg(hex3));
sevenSeg S4(.val(4'b1000), .seg(hex4));
sevenSeg S5(.val(4'b0000), .seg(hex5));

endmodule
