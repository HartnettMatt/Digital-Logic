module calendar (switch, counter10, counter1, hexMonth, dayCounter10, segDay10, dayCounter1);

input switch;
input [3:0] counter10;
input [3:0] counter1;

output reg [3:0] hexMonth;
output reg [3:0] dayCounter10;
output reg [3:0] segDay10;
output reg [3:0] dayCounter1;

reg[6:0] binary_c;

always @(counter1 or counter10)
begin
    binary_c = counter1 + counter10*10;
    // January code (independant of leap year)
    if (binary_c <= 31)
    begin
        dayCounter1 <= counter1;
        hexMonth <= 1;
        if (counter10 < 1)
        begin
            dayCounter10 <= 0;
            segDay10 <= 4'b1111;
        end
        else
        begin
            dayCounter10 <= counter10;
            segDay10 <= counter10;
        end
    end
    // Leap year code:
    if (switch)
    begin
    // February:
        if (binary_c > 31 & binary_c <= 60)
        begin
          hexMonth <= 2;
          if (counter1 > 0)
          begin
              dayCounter1 <= counter1 - 1;
              dayCounter10 <= counter10 - 3;
          end
          else
          begin
              dayCounter1 <= 9;
              dayCounter10 <= counter10 - 4;
          end
        end
        // April
        if(binary_c >= 61 & binary_c <= 91)
        begin
          hexMonth <= 3;
          dayCounter1 <= counter1;
          dayCounter10 <= counter10 - 6;
        end
        // March
        if(binary_c > 91 & binary_c <= 99)
        begin
          hexMonth <= 4;
          dayCounter10 <= 0;
          if(counter1 != 0)
          begin
            dayCounter1 <= counter1-1;
            dayCounter10 <= counter10 - 9;
          end
          else
          begin
            dayCounter1 <= 9;
            dayCounter10 <= counter10 - 8;
          end
        end
    end
    // Non-leap year code:
    else if(~switch)
    begin
    // February
      if (binary_c > 31 & binary_c <= 59)
      begin
          hexMonth <= 2;
          if (counter1 > 0)
          begin
              dayCounter1 <= counter1 - 1;
              dayCounter10 <= counter10 - 3;
          end
          else
          begin
              dayCounter1 <= 9;
              dayCounter10 <= counter10 - 4;
          end
      end
      // April
      if(binary_c >= 60 & binary_c <= 90)
      begin
        hexMonth <= 3;
        if(counter1 != 9)
        begin
          dayCounter1 <= counter1+1;
          dayCounter10 <= counter10 - 6;
        end
        else
        begin
          dayCounter1 <= 0;
          dayCounter10 <= counter10 -5;
        end
      end
      // March:
      if(binary_c > 90 & binary_c <= 99)
      begin
        hexMonth <= 4;
        dayCounter10 <= counter10-9;
        dayCounter1 <= counter1;
      end
    end
    // Blank the display if the 10's place is zero
    if (dayCounter10 == 0)
    begin
        segDay10 <= 4'b1111;
    end
    else
    begin
        segDay10 <= dayCounter10;
    end
end

endmodule
