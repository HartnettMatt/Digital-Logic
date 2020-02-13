module top (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

input [9:0] SW;
input [1:0] KEY;
output reg [9:0] LEDR;
output reg [7:0] HEX0;
output reg [7:0] HEX1;
output reg [7:0] HEX2;
output reg [7:0] HEX3;
output reg [7:0] HEX4;
output reg [7:0] HEX5;

wire [9:0] ledsa;
wire [7:0] hex0a;
wire [7:0] hex1a;
wire [7:0] hex2a;
wire [7:0] hex3a;
wire [7:0] hex4a;
wire [7:0] hex5a;

wire [9:0] ledsb;
wire [7:0] hex0b;
wire [7:0] hex1b;
wire [7:0] hex2b;
wire [7:0] hex3b;
wire [7:0] hex4b;
wire [7:0] hex5b;

design1 U0(.switch(SW), .key(KEY), .leds(ledsa),.hex0(hex0a),.hex1(hex1a),.hex2(hex2a),.hex3(hex3a),.hex4(hex4a),.hex5(hex5a));
design2 U1(.switches(SW), .leds(ledsb),.hex0(hex0b),.hex1(hex1b),.hex2(hex2b),.hex3(hex3b),.hex4(hex4b),.hex5(hex5b));

always @(SW[9]) begin
  if(~SW[9])
  begin
    LEDR = ledsa;
    HEX0 = hex0a;
    HEX1 = hex1a;
    HEX2 = hex2a;
    HEX3 = hex3a;
    HEX4 = hex4a;
    HEX5 = hex5a;
  end
  else
  begin
    LEDR = ledsb;
    HEX0 = hex0b;
    HEX1 = hex1b;
    HEX2 = hex2b;
    HEX3 = hex3b;
    HEX4 = hex4b;
    HEX5 = hex5b;
  end
end

endmodule
