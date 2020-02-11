`timescale 1 ns / 100 ps

module tb();

reg a, b, c, d;
wire f;

week2 DUT (.a(a), .b(b), .c(c), .d(d), .f(f));


initial
  begin
    $dumpfile("week2.vcd");
	$dumpvars;
       a = 0; b = 0; c = 0; d = 0;
   #10 a = 0; b = 0; c = 0; d = 1;
   #10 a = 0; b = 0; c = 1; d = 0;
   #10 a = 0; b = 0; c = 1; d = 1;
   #10 a = 0; b = 1; c = 0; d = 0;
   #10 a = 0; b = 1; c = 0; d = 1;
   #10 a = 0; b = 1; c = 1; d = 0;
   #10 a = 0; b = 1; c = 1; d = 1;
   #10 a = 1; b = 0; c = 0; d = 0;
   #10 a = 1; b = 0; c = 0; d = 1;
   #10 a = 1; b = 0; c = 1; d = 0;
   #10 a = 1; b = 0; c = 1; d = 1;
   #10 a = 1; b = 1; c = 0; d = 0;
   #10 a = 1; b = 1; c = 0; d = 1;
   #10 a = 1; b = 1; c = 1; d = 0;
   #10 a = 1; b = 1; c = 1; d = 1;
   #10 $finish;
  end
  
initial
  begin
    $monitor($time, "a = %b, b = %b, c = %b, d = %b, f = %b",
	         a, b, c, d, f);
  end

endmodule