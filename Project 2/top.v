module top (ADC_CLK_10, KEY, HEX0, HEX1, HEX2, HEX4, HEX5, LEDR);

input ADC_CLK_10;
input [1:0] KEY;

output [7:0] HEX0;
output [7:0] HEX1;
output [7:0] HEX2;
output [7:0] HEX4;
output [7:0] HEX5;
output [9:0] LEDR;

wire clock;
reg clock_reset;
wire [3:0] counter1;
wire [3:0] counter10;
wire [3:0] segCounter10;
reg ledValue;
reg [31:0] divide_by;

assign LEDR[9:1] = 9'b0_0000_0000;
assign LEDR[0] = ledValue;

counter C0(.clock(clock), .reset_n(KEY[0]), .counter10(counter10), .counter1(counter1), .segCounter10(segCounter10));
sevenSeg H4 (.val(counter1), .seg(HEX4));
sevenSeg H5 (.val(segCounter10), .seg(HEX5));
clockDivider U0 (.clock_in(ADC_CLK_10), .divide_by(divide_by), .reset_n(KEY[0]), .clock_out(clock));

initial begin
    ledValue = 0;
    divide_by = 2500000;
end

always @ (negedge clock or negedge KEY[0])
    begin
       if (~KEY[0])
            ledValue = 0;
        else
            ledValue <= ~ledValue;

    end

always @ (negedge clock or negedge KEY[1]) begin
  if(~KEY[1])
    divide_by = 1250000;
  else
    divide_by = 2500000;
end
endmodule
