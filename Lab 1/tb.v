`timescale 1 ns / 100 ps
module tb();

reg a, b;
wire c;

top U1 (.ain(a), .bin(b), .cout(c));

initial
  begin
    $dumpfile("output.vcd");
    $dumpvars;
    $display("Starting simulation");
      a = 0;
      b = 0;
    #10 a = 1;
    #10 b = 1;
    #10 a = 0;
    #10 $display("Simulation ended.");
    $finish;
  end

initial
  $monitor($time, " a = %b, b = %b, c = %b", a, b, c);
endmodule
