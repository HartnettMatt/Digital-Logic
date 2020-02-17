`timescale 1 ns / 100 ps

module tb1();

reg [9:0] testSW;
reg [1:0] testKEY;
wire [9:0] testLED;
wire [7:0] testHEX0;
wire [7:0] testHEX1;
wire [7:0] testHEX2;
wire [7:0] testHEX3;
wire [7:0] testHEX4;
wire [7:0] testHEX5;

design1 DUT(.switch(testSW), .key(testKEY), .leds(testLED),.hex0(testHEX0),.hex1(testHEX1),.hex2(testHEX2),.hex3(testHEX3),.hex4(testHEX4),.hex5(testHEX5));

// Begin stimulating inputs:
initial begin
  $dumpfile("test.vcd");
  $dumpvars;
  $display($time, "Starting simulation");

  //Initialize inputs:
  testSW = 10'b0000000000;
  testKEY = 2'b00;

  // Test birthday switch:
  #10 testKEY = 2'b10;

  // Test LED switching:
  while(testSW < 10'b1111_1111) begin
    #10 testSW = testSW + 10'b00000001;
  end

  // End testing
  #10 $finish;
end

// Monitor inputs and outputs
initial
  begin
    $monitor($time, "testSW = %b, testKEY = %b, testLED = %b, testHEX0 = %b, testHEX1 = %b, testHEX2 = %b, testHEX3 = %b, testHEX4 = %b, testHEX5 = %b",
           testSW, testKEY, testLED, testHEX0, testHEX1, testHEX2, testHEX3, testHEX4, testHEX5);
  end
endmodule
