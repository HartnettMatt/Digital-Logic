`timescale 1 ns / 100 ps

module tbtop();

reg [9:0] testSW;
reg  testKEY;
reg clock;
reg [15:0] counter;
wire [9:0] testLED;
wire [7:0] testHEX0;
wire [7:0] testHEX1;
wire [7:0] testHEX2;
wire [7:0] testHEX3;
wire [7:0] testHEX4;
wire [7:0] testHEX5;

top DUT(.KEY(testKEY), .ADC_CLK_10(clock), .LEDR(testLED),.HEX0(testHEX0),.HEX1(testHEX1),.HEX2(testHEX2),.HEX4(testHEX4),.HEX5(testHEX5));

// Begin stimulating inputs:
initial begin
  $dumpfile("test.vcd");
  $dumpvars;
  $display($time, "Starting simulation");

  //Initialize inputs:
  testSW = 10'b0000000000;
  testKEY = 1;
  clock = 1'b0;
  counter = 0;
  while(counter < 16'b1111111111111111) begin
    #10 clock = ~clock;
    counter = counter + 1;
  end
  // End testing
  #10 $finish;
end

// Monitor inputs and outputs
initial
  begin
    $monitor($time, "testSW = %b, testKEY = %b, clock = %b, testLED = %b, testHEX0 = %b, testHEX1 = %b, testHEX2 = %b, testHEX3 = %b, testHEX4 = %b, testHEX5 = %b",
           testSW, testKEY, testLED, clock, testHEX0, testHEX1, testHEX2, testHEX3, testHEX4, testHEX5);
  end
endmodule
