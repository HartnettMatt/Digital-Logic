module top (SW, KEY, ADC_CLK_10, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

input [9:0] SW;
input [1:0] KEY;
input ADC_CLK_10;
output reg [9:0] LEDR;
output reg [7:0] HEX0;
output reg [7:0] HEX1;
output reg [7:0] HEX2;
output reg [7:0] HEX3;
output reg [7:0] HEX4;
output reg [7:0] HEX5;

reg [7:0]count;

initial begin
   count = 8'b0000_0001;
   LEDR[9:1] = 8'b0000_0000;
end

always @(posedge ADC_CLK_10 or posedge KEY[0]) begin
  LEDR[0] = ~LEDR[0];
  if(KEY[0])
    count = 1;
  else
    count = count + 1;
end

endmodule
