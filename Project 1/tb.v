`timescale 1 ns / 100 ps

module tb();

reg [9:0] testSW;
reg [1:0] testKEY;
wire [9:0] testLED;
top DUT(.SW(testSW), .KEY(testKEY), .LEDR(testLED));

endmodule
