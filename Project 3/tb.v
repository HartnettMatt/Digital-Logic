`timescale 1 ns / 100 ps

module tb();

reg [7:0] testSW;
reg [1:0] testKEY;
reg clock;
reg [7:0] counter;
wire [9:0] testLED;
wire [7:0] testHEX0;
wire [7:0] testHEX1;
wire [7:0] testHEX2;
wire [7:0] testHEX3;
wire [7:0] testHEX4;
wire [7:0] testHEX5;

top DUT(.KEY(testKEY), .SW(testSW), .ADC_CLK_10(clock), .LEDR(testLED),.HEX0(testHEX0));

// Begin stimulating inputs:
initial begin
  $dumpfile("test.vcd");
  $dumpvars;
  $display($time, "Starting simulation");

  //Initialize inputs (started with asserted reset signal):
  testSW = 10'b0000000000;
  testKEY = 0;
  clock = 1'b0;
  counter = 0;
  // Create a clock signal that has 256 cycles
  while(counter < 8'b00100000) begin
    #10 clock = ~clock;
    // De-assert the reset signal
    if(counter > 8'b00000010)
      begin
        testKEY[0] = 1;
      end
    if (counter > 8'b00000100)
    begin
      testSW[0] = 1;
    end
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
