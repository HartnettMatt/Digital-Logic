module top (input [7:0] SW, input [1:0] KEY, output [7:0] LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
//assign HEX0 = 8'b11111001;
//assign HEX1 = SW;
//assign HEX2 = 8'b10110000;
//assign HEX2 = 8'b10011001;
//assign HEX3 = 8'b10100100;
//assign HEX4 = 8'b10000000;
//assign HEX5 = 8'b11000000;

design1 U0(.switch(SW), .y(1'b1), .leds(LEDR),.hex0(HEX0),.hex1(HEX1),.hex2(HEX2),.hex3(HEX3),.hex4(HEX4),.hex5(HEX5));

endmodule
