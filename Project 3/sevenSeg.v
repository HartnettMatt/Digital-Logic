module sevenSeg (input [1:0] val, output reg [7:0] seg);

always @(val)
  begin
    case(val)
      2'b00 : seg = 8'b11000000;
      2'b01 : seg = 8'b11111001;
      2'b10 : seg = 8'b10100100;
      2'b11 : seg = 8'b10110000;
     
      default : seg = 8'b00000000;
    endcase
  end
endmodule