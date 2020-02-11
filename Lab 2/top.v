module top (input [3:0] SW, output [0:0] LEDR);

week2 U0 (.a(SW[3]), .b(SW[2]), .c(SW[1]), .d(SW[0]), .f(LEDR[0]));

endmodule