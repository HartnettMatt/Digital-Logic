// Written to pass in the divide by parameter.

module clock_divider (clock_in, reset_n, clock_out);

input clock_in, reset_n;
output reg clock_out;
reg [31:0] counter;
parameter divider = 0;  // Passed in at instantiation

always @(posedge clock_in or negedge reset_n)
    if (reset_n == 0)
        begin
            counter <= 0;
            clock_out <= 0;
        end
    else if (counter != divider)
        counter <= counter + 1'b1;
	else
        begin
		    counter <= 0;
            clock_out <= ~clock_out;
        end

endmodule