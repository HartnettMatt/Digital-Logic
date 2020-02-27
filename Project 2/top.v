module top (ADC_CLK_10, KEY, HEX0, HEX1, HEX2, HEX4, HEX5, LEDR);

input ADC_CLK_10;
input [0:0] KEY;

output [7:0] HEX0;
output [7:0] HEX1;
output [7:0] HEX2;
output [7:0] HEX4;
output [7:0] HEX5;
output [9:0] LEDR;

wire clock;
reg clock_reset;

clockDivider U0 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .clock_out(clock));

reg [3:0] counter1;
reg [3:0] counter10;

reg [3:0] segCounter10;

sevenSeg H4 (.val(counter1), .seg(HEX4));
sevenSeg H5 (.val(segCounter10), .seg(HEX5));

reg ledValue;

assign LEDR[9:1] = 9'b0_0000_0000;
assign LEDR[0] = ledValue;

initial begin
    counter1 = 1;
    counter10 = 0;
    segCounter10 = 0;
    clock_reset = 1;
end

always @ (posedge clock or negedge KEY[0])
    begin

       if (~KEY[0])
       begin
            counter1 <= 1;
            counter10 <= 0;
            segCounter10 <= 4'b1111;
        end
        else
        begin
            ledValue <= ~ledValue;
            if (counter1 != 4'b1001)
            begin
                counter1 <= counter1 + 1;
            end
            else
            begin
                if (counter10 != 4'b1001)
                begin
                    counter1 <= 0;
                    counter10 <= counter10 + 1;
                    segCounter10 <= counter10 + 1;
                end
                else
                begin
                    counter1 <= 1;
                    counter10 <= 0;
                    segCounter10 <= 4'b1111;
                end
            end
        end
    end


endmodule
