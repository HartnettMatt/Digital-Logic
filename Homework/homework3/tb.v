`timescale 1 ns / 100 ps

module tb();

reg [7:0]in;
wire out;

test DUT (.data_in(in), .parity_out(out));


initial
  begin
  $dumpfile("test.vcd");
	$dumpvars;
  $display($time, "Starting simulation");
  in = 8'b00000000;
  while(in < 8'b1111_1111) begin
    #10 in = in + 8'b00000101;
  end
   #10 $finish;
  end

initial
  begin
    $monitor($time, "in = %b, out = %b",
	         in, out);
  end

endmodule
