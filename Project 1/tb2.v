`timescale 1 ns / 100 ps

module tb2();

reg [9:0] testSW;
wire [9:0] testLED;
wire [7:0] testHEX0;
wire [7:0] testHEX1;
wire [7:0] testHEX2;
wire [7:0] testHEX3;
wire [7:0] testHEX4;
wire [7:0] testHEX5;

design2 DUT(.switch(testSW), .leds(testLED),.hex0(testHEX0),.hex1(testHEX1),.hex2(testHEX2),.hex3(testHEX3),.hex4(testHEX4),.hex5(testHEX5));

// Begin stimulating inputs:
initial begin
  $dumpfile("test.vcd");
  $dumpvars;
  $display($time, "Starting simulation");

  //Initialize inputs:
  testSW = 10'b0000000000;

  // Test left high versus equal versus right high
  #10 testSW[0] = 1'b1;
  #10 testSW[4] = 1'b1;
  #10 testSW[0] = 1'b0;
  #10 testSW[4] = 1'b0;
  #10
  // Test when the right ones are higher
  while(testSW[3:0] < 4'b1111) begin
    #10 testSW[3:0] = testSW[3:0] + 4'b0001;
  end
  #10 testSW[3:0] = 4'b0000;
  // Test when the left ones are higher
  while(testSW[7:4] < 4'b1111) begin
    #10 testSW[7:4] = testSW[7:4] + 4'b0001;
  end
  #10 testSW[7:4] = 4'b0000;

  // End testing
  #10 $finish;
end

// Monitor inputs and outputs
initial
  begin
    $monitor($time, "testSW = %b, testLED = %b, testHEX0 = %b, testHEX1 = %b, testHEX2 = %b, testHEX3 = %b, testHEX4 = %b, testHEX5 = %b",
           testSW, testLED, testHEX0, testHEX1, testHEX2, testHEX3, testHEX4, testHEX5);
  end
endmodule
