`timescale 1 ns / 100 ps

module tbtop();

reg [9:0] testSW;
reg [1:0] testKEY;
wire [9:0] testLED;
wire [7:0] testHEX0;
wire [7:0] testHEX1;
wire [7:0] testHEX2;
wire [7:0] testHEX3;
wire [7:0] testHEX4;
wire [7:0] testHEX5;

top DUT(.SW(testSW), .KEY(testKEY), .LEDR(testLED),.HEX0(testHEX0),.HEX1(testHEX1),.HEX2(testHEX2),.HEX3(testHEX3),.HEX4(testHEX4),.HEX5(testHEX5));

// Begin stimulating inputs:
initial begin
  $dumpfile("test.vcd");
  $dumpvars;
  $display($time, "Starting simulation");

  //Initialize inputs:
  testSW = 10'b0000000000;
  testKEY = 2'b00;

  // Test different outputs:
#10 testSW[9] = 1'b1;
#10 testSW[9] = 1'b0;

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
