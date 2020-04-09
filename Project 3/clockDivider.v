module clockDivider(clock_in, reset_n, divide_by, clock_out);
input clock_in;
input reset_n;
input [31:0] divide_by;
output reg clock_out;

reg [31:0] clock_divider = 0;

initial begin
  clock_out = 0;
  clock_divider = 0;
end
always @(posedge clock_in or negedge reset_n)
  begin
    if (~reset_n)
      begin
        clock_out = 0;
        clock_divider = 0;
      end
    else
      begin
        if(clock_divider != divide_by - 1)
          clock_divider <= clock_divider + 1;
        else
          begin
            clock_divider <= 0;
            clock_out <= ~clock_out;
          end
      end
  end
endmodule