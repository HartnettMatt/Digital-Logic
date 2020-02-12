//-----------------------------------------------------
// Design Name : parity_using_function2
// File Name   : parity_using_function2.v
// Function    : Parity using function
// Coder       : Deepak Kumar Tala
//-----------------------------------------------------
module test (data_in, parity_out);
output reg parity_out ;
input [7:0] data_in ;     

function parity;
    input [7:0] data; 
    integer i; 
    begin 
        parity = 0; 
        for (i = 0; i < 8; i = i + 1) begin  
            parity = parity ^ data[i]; 
        end 
    end 
endfunction 

always @ (data_in)
    parity_out = parity(data_in);

endmodule