module top (ADC_CLK_10, SW, KEY, LEDR, HEX0, HEX1);

input ADC_CLK_10;
input [9:0] SW;
input [1:0] KEY;
reg [2:0] counter = 0;
reg counter_clock;

output [9:0] LEDR;
output [7:0] HEX0;
output [7:0] HEX1;

reg [7:0] hexReg;

assign HEX1 = hexReg;

wire [7:0] state;
wire [7:0] inputs;

wire [9:0] switches;
wire [1:0] keys;

reg [9:0] switchReg;
reg [1:0] keyReg;


assign state[7:3] = 5'b00000;
assign state[2:0] = counter;

assign switches = switchReg;
assign keys = keyReg;


memoryBlock I2 (.address(state), .clock(counter_clock), .q(inputs));

manual I3 (.ADC_CLK_10(ADC_CLK_10), .SW(switches), .KEY(keys), .LEDR(LEDR), .HEX0(HEX0));

clockDivider C0 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .divide_by(2500000), .clock_out(counter_clock));

initial
begin
    counter = 0;
end

always @(SW[9])
begin
    if(~SW[9])
    begin
        switchReg = SW;
        keyReg = KEY;
        hexReg = 8'b11111111;
    end
    else
    begin
        switchReg[9:3] = 7'b0000000;
        switchReg[2:0] = inputs[2:0];
        keyReg[1] = inputs[3];
        keyReg[0] = KEY[0];
        hexReg = 8'b00000000;
    end
end

always @(posedge counter_clock)
begin
    if (counter == 6)
    begin
        counter = 0;
    end
    else
    begin
        counter = counter + 1;
    end
end

endmodule
