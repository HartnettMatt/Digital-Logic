`timescale 1 ns / 100 ps
module tb_HW8();

parameter data_width = 4;    // 4 bit data width
parameter addr_width = 3;    // 8 memory locations
reg   clock, write_enable;
reg  [data_width-1:0] data;  // data to write into memory
reg  [addr_width-1:0] addr;  // memory address
wire [data_width-1:0] q;     // memory output
integer i;

always
    #10 clock = ~clock;

initial
    begin
        $dumpfile ("tb_HW8.vcd");
	    $dumpvars;
        $display ($time, "<< Starting Simulation. >>");
        clock = 0; write_enable = 0; data = 0; addr = 0;

        #25;
        write_enable = 1;

        for (i = 0; i < 2**addr_width; i = i + 1)
            begin
                data <= i + 3;
                addr <= i;
                #20;
            end

        write_enable = 0;
        #20;

// Next two lines reads data from memory
        for (i = 0; i < 2**addr_width; i = i + 1)
            #20 addr = i;

        #20 $finish;
    end

initial
    $monitor($time, "   clock = %b, write_enable = %b, data = %h, addr = %h, q = %h",
             clock, write_enable, data, addr, q);

// Code for memory model
reg   [addr_width-1:0] addr_reg;  // registere address
reg   [data_width-1:0] ram [0:2**addr_width-1]; // indices reversed to make memory load work properly

// Next line will load memory from file prior to simulation
initial $readmemb("memory.lst", ram);

// Synchronous write using unregistered address
always @ (posedge clock)
begin
	if (write_enable)
		ram [addr] <= data;
	addr_reg <= addr;
end
// Memory reads use registered address value
assign q = ram [addr_reg];

endmodule
