// ALTERED SEVEN SEG so that there is blanking and no letters. See project 1 for full SevenSeg module
module sevenSeg (input [3:0] val, output reg [7:0] seg, output reg [7:0] seg1);

always @(val)
  begin
    case(val[3:0])
      4'b0000 : seg = 8'b11000000;
      4'b0001 : seg = 8'b11111001;
      4'b0010 : seg = 8'b10100100;
      4'b0011 : seg = 8'b10110000;
      4'b0100 : seg = 8'b10011001;
      4'b0101 : seg = 8'b10010010;
      4'b0110 : seg = 8'b10000010;
      4'b0111 : seg = 8'b11111000;
      4'b1000 : seg = 8'b10000000;
      4'b1001 : seg = 8'b10011000;

      //Code to blank the display
      4'b1111 : seg = 8'b11111111;
      default : seg = 8'b11111111;
    endcase
  end
endmodule
