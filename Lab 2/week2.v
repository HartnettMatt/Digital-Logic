module week2 (input a, input b, input c, input d, output reg f);

always @ (a, b, c, d)
    case ({a,c,d,b})
        0:  f = 1;
        3:  f = 1;
        5:  f = 1;
        6:  f = 1;
        9:  f = 1;
        10: f = 1;
        12: f = 1;
        15: f = 1;
        default:  f = 0;
    endcase 

endmodule