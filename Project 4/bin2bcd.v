module bin2bcd (input [8:0] binary_in, output reg [11:0] bcd_out);

// This is some strange code, but it works.  Thank goodness for Google.

integer i;

always @ (binary_in)
    begin
        bcd_out = 0;

        for (i = 8; i >= 0; i = i-1)
            begin
                if (bcd_out[11:8] >= 5)
                    bcd_out[11:8] = bcd_out[11:8] + 4'd3;
                if (bcd_out[7:4] >= 5)
                    bcd_out[7:4] = bcd_out[7:4] + 4'd3;
                if (bcd_out[3:0] >= 5)
                    bcd_out[3:0] = bcd_out[3:0] + 4'd3;   

                bcd_out[11:8] = bcd_out[11:8] << 1;
                bcd_out[8] = bcd_out[7];
                bcd_out[7:4] = bcd_out[7:4] << 1;
                bcd_out[4] = bcd_out[3];
                bcd_out[3:0] = bcd_out[3:0] << 1;
                bcd_out[0] = binary_in[i];
            end
    end

endmodule
         
       


