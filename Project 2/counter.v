module counter(clock, reset_n, c10, c1, sC10);

input clock;
input reset_n;

// c1 is the binary represetation of the 1's place in the counter
// c10 is the 10's place
// sC10 is a value that stores "0" as "F" so that the display can be blanked properly
output reg [3:0] c1;
output reg [3:0] c10;
output reg [3:0] sC10;

initial begin
    c1 = 0;
    c10 = 0;
    sC10 = 4'b1111;
end

// On the negative edge of the clock, increase the counter by 1
always @ (negedge clock or negedge reset_n)
    begin
    // Reset block:
      if (~reset_n)
       begin
            c1 <= 1;
            c10 <= 0;
            sC10 <= 4'b1111;
        end
        else
        begin
            if (c1 != 4'b1001)
            begin
                c1 <= c1 + 1;
            end
            else
            // Handle when c1 is 9 and c10 isn't 9 (EX: increase from 9 to 10)
            begin
                if (c10 != 4'b1001)
                begin
                    c1 <= 0;
                    c10 <= c10 + 1;
                    sC10 <= c10 + 1;
                end
                else
                // Handle rollover from 99 back to 01
                begin
                    c1 <= 1;
                    c10 <= 0;
                    sC10 <= 4'b1111;
                end
            end
        end
    end

endmodule
