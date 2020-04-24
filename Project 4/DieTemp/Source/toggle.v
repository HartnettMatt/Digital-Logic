module toggle (input clock, output qout);

// I'm not sure if these compiler directives have to be here,
// but they don't hurt anything so better leave them.

//(* preserve *) reg q;
reg q /* synthesis preserve */;
always @ (posedge clock)
    q <= ~q;

assign qout = q;
endmodule