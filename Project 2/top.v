module top (ADC_CLK_10, SW, KEY, HEX0, HEX1, HEX2, HEX4, HEX5, LEDR);

input ADC_CLK_10;
input [1:0] KEY;
input [9:0] SW;

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
wire [3:0] hexMonth;
wire [3:0] hexDay1;
wire [3:0] hexDay10;
reg ledValue;
reg [31:0] divide_by;

assign LEDR[9:1] = 9'b0_0000_0000;
assign LEDR[0] = ledValue;

counter C0(.clock(clock), .reset_n(KEY[0]), .c10(counter10), .c1(counter1), .sC10(segCounter10));

calendar Cal0 (.clock(clock), .reset_n(KEY[0]), .SW9(SW[9]), .c10(counter10), .c1(counter1), .hm(hexMonth),  .hd10(hexDay10), .hd1(hexDay1));

sevenSeg H0 (.val(hexDay1), .seg(HEX0));
sevenSeg H1 (.val(hexDay10), .seg(HEX1));
sevenSeg H2 (.val(hexMonth), .seg(HEX2));

sevenSeg H4 (.val(counter1), .seg(HEX4));
sevenSeg H5 (.val(segCounter10), .seg(HEX5));
clockDivider U0 (.clock_in(ADC_CLK_10), .divide_by(divide_by), .reset_n(KEY[0]), .clock_out(clock));

initial begin
    ledValue = 0;
    divide_by = 2500000;
    // divide_by = 2;
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
    divide_by = 1000000;
    // divide_by = 1;
  else
    divide_by = 2500000;
    // divide_by = 2;
end
endmodule
