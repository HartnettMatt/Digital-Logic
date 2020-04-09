module blink (clock, hazards, reset_n, turnChange, rightLEDs, leftLEDs, hex);

input turnChange, clock, hazards, reset_n;
output reg [0:2] rightLEDs;
output reg [2:0] leftLEDs;
output [7:0] hex;


reg [1:0] blinkState;
reg [1:0] blink;
reg [1:0] next;
reg updateNext;

sevenSeg H0 (.val(blinkState), .seg(hex));


//NEXT STATE LOGIC
always @(blinkState or turnChange)
begin
if (blink == blinkState)
begin
    if (~hazards)
    begin
        next <= 0;
    end
end
next <= blinkState + 1;
//OUTPUT LOGIC
case (blinkState)
    0 : begin
        leftLEDs <= 0;
        rightLEDs <= 0;
        end
    1 : begin
        leftLEDs <= 1;
        rightLEDs <= 1;
        end
    2 : begin
        leftLEDs <= 3;
        rightLEDs <= 3;
        end
    3 : begin
        leftLEDs <= 7;
        rightLEDs <= 7;
        end
    default: begin 
        leftLEDs <= 0;
        rightLEDs <= 0;
        end
endcase
blink <= blinkState;
end


// CURRENT STATE LOGIC
always @(posedge clock or negedge reset_n)
begin
    if (~reset_n)
    begin
        blinkState <= 0;
    end
    else
    begin
        blinkState <= next;
    end
end


endmodule