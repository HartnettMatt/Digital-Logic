module counter(clock, reset_n, counter10, counter1, segCounter10);

input clock;
input reset_n;
output [3:0] counter10;
output [3:0] counter1;
output [3:0] segCounter10;

reg [3:0] c10;
reg [3:0] c1;
reg [3:0] sC10;

assign counter10 = c10;
assign counter1 = c1;
assign segCounter10 = sC10;

initial begin
    c1 = 1;
    c10 = 0;
    sC10 = 4'b1111;
end

always @ (posedge clock or negedge reset_n)
    begin
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
            begin
                if (c10 != 4'b1001)
                begin
                    c1 <= 0;
                    c10 <= c10 + 1;
                    sC10 <= c10 + 1;
                end
                else
                begin
                    c1 <= 1;
                    c10 <= 0;
                    sC10 <= 4'b1111;
                end
            end
        end
    end

endmodule
