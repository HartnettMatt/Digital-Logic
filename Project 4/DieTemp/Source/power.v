module power (input clock, output powerout);

// I am mad that Quartus won't let me create more than
// 5000 flip flops in a generate statement.  Guess I will
// just do 4000 and instantiate this module multiple times.

parameter n = 4000;
wire [n-1:0] qout;

genvar i;
generate
    for (i = 0; i <= n-1; i = i + 1)
        begin: addreg
            toggle U (clock, qout[i]);            
        end
endgenerate

// There must be some way to keep these flip flops here....
// assign powerout = 
assign powerout = 0;  // This dummy assignment must be replaced...
endmodule