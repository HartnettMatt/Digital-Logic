module calendar (clock, reset_n, SW9, c10, c1, hm,  hd10, hd1);

input clock;
input reset_n;
input SW9;
input [3:0] c10;
input [3:0] c1;

output reg [3:0] hm;
output reg [3:0] hd1;
output reg [3:0] hd10;

wire [6:0] binary_c;
assign binary_c = c10*10+c1;

initial begin
  hm = 1;
  hd1 = 1;
  hd10 = 0;
end

always @(negedge clock or negedge reset_n)
  begin
    if(~reset_n)
      begin
        hm <= 1;
        hd1 <= 1;
        hd10 <= 0;
      end
    if(binary_c == 1)

      begin
        hm <= 1;
        hd1 <= 1;
        hd10 <= 0;
      end

    else if(binary_c != 1 & binary_c < 31)

      begin
        hm <= 1;
        if(hd1 != 9)
          hd1 <= hd1 + 1;
        else if(hd1 == 9)
        begin
          hd1 <= 0;
          hd10 <= hd10 +1;
        end

      end

    else if (binary_c == 32)

    begin
      hm <= 2;
      hd1 <= 1;
      hd10 <= 0;
    end

    else if(binary_c != 32 & binary_c < 59+SW9)

    begin
      if(hd1 == 9)
      begin
        hd1 <= 0;
        hd10 <= hd10 +1;
      end
      else
      begin
        hd1 <= hd1 + 1;
      end
      hm <= 2;
    end

  end
endmodule
