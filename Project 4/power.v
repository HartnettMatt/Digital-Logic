module power (input clock, output powerout);

// Quartus only allows for a maximum of 5000 flip flops in one generate
parameter n = 4000;
wire [n-1:0] qout;

genvar i;
generate
    for (i = 0; i <= n-1; i = i + 1)
        begin: addreg
            toggle U (clock, qout[i]);
        end
endgenerate
// Ensures that Quartus doesn't optimize out the flip flops (value is not important / meaningless):
assign powerout = qout[n-1:(n-1)/2] != qout[(n-1)/2:0];
endmodule
