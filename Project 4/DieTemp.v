module DieTemp(
      input            MAX10_CLK1_50,
      input            MAX10_CLK2_50,
      input    [1:0]   KEY,
      input    [9:0]   SW,
      output   [9:0]   LEDR,
      output   [7:0]   HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
      );

// Creating this top level module was a pain, but it runs great.
// misc
wire sys_clk, slow_clock, slower_clock;
reg blip;
wire [11:0] bcd_disp;
wire [11:0] bcd_hold;
reg [3:0] HEX4val;

wire empty;
wire full;
reg allow_write = 1;
reg allow_read = 0;
wire [4:0] fifo_size;

wire [8:0] fifo_test;
assign fifo_test[8:5] = 4'b0000;
assign fifo_test[4:0] = fifo_size;
wire [11:0] fifo_dec;

// command
wire command_ready;

// response
wire response_valid/* synthesis keep */;
wire [4:0] response_channel;
wire [11:0] response_data;
wire response_startofpacket;
wire response_endofpacket;
reg [4:0]  cur_adc_ch /* synthesis noprune */;
reg [11:0] adc_sample_data /* synthesis noprune */;

    adc_qsys U0 (
        .clk_clk                              (MAX10_CLK1_50),          //  50Mhz input to adc_qsys module
        .reset_reset_n                        (1'b1),                   //  set reset inactive
        .modular_adc_0_command_valid          (1'b1),                   //
        .modular_adc_0_command_channel        (5'b10001),               //  channel 17 for temperature diode
        .modular_adc_0_command_startofpacket  (1'b1),                   //
        .modular_adc_0_command_endofpacket    (1'b1),                   //
        .modular_adc_0_command_ready          (command_ready),          //  .ready
        .modular_adc_0_response_valid         (response_valid),         //  .modular_adc1_response.valid
        .modular_adc_0_response_channel       (response_channel),       //  .channel
        .modular_adc_0_response_data          (response_data),          //  .data
        .modular_adc_0_response_startofpacket (response_startofpacket), //  .startofpacket
        .modular_adc_0_response_endofpacket   (response_endofpacket),   //  .endofpacket
        .clock_bridge_sys_out_clk_clk         (sys_clk)                 //  .clock_bridge_sys_out_clk.clk
    );

// This setups the sample rate
clock_divider #(100000) U1 (.clock_in (MAX10_CLK1_50), .reset_n (KEY[0]), .clock_out(slow_clock));
clock_divider #(1500000000) U6 (.clock_in (MAX10_CLK1_50), .reset_n (KEY[0]), .clock_out(slower_clock));
// I decided to display a smaller value, the temperature table explains this
always @ (posedge slow_clock)
    begin
	    if (response_valid)
	    begin
		    adc_sample_data <= response_data - 12'd3431;
		    cur_adc_ch <= response_channel;
        blip = ~blip;
	    end
    end
// I love blinking lights
assign LEDR[9] = blip;

// That bin2bcd code is real pain, I won't touch it again
bin2bcd U2 (.binary_in(adc_sample_data[8:0]), .bcd_out(bcd_hold));
bin2bcd T1 (.binary_in(fifo_test), .bcd_out(fifo_dec));

seg7 U3 (.oSEG(HEX2), .iDIG(bcd_disp[11:8]));
seg7 U4 (.oSEG(HEX1), .iDIG(bcd_disp[7:4]));
seg7 U5 (.oSEG(HEX0), .iDIG(bcd_disp[3:0]));

seg7 T2 (.oSEG(HEX4), .iDIG(fifo_dec[3:0]));
seg7 T3 (.oSEG(HEX5), .iDIG(fifo_dec[7:4]));
assign HEX3 = 8'hff;

// display channel in BCD, A/D is channel 17
always @ (cur_adc_ch)
        if (cur_adc_ch <= 9)
                HEX4val = cur_adc_ch[3:0];
        else
                HEX4val = cur_adc_ch - 4'd10;

// Add power //

// assign LEDR[0] = 1'b0;
// power U7 (.clock(MAX10_CLK1_50), .powerout(LEDR[8]));
// power U8 (.clock(MAX10_CLK1_50), .powerout(LEDR[7]));
// power U9 (.clock(MAX10_CLK1_50), .powerout(LEDR[6]));
// power U10 (.clock(MAX10_CLK1_50), .powerout(LEDR[5]));
// power U11 (.clock(MAX10_CLK2_50), .powerout(LEDR[4]));
// power U12 (.clock(MAX10_CLK2_50), .powerout(LEDR[3]));
// power U13 (.clock(MAX10_CLK2_50), .powerout(LEDR[2]));
// power U14 (.clock(MAX10_CLK2_50), .powerout(LEDR[1]));

// FIFO

fifo F0 (.aclr(~KEY[0]), .data(bcd_hold), .rdclk(~KEY[1]), .rdreq(readOn), .wrclk(slower_clock), .wrreq(allow_write), .q(bcd_disp), .rdempty(empty), .wrfull(full), .wrusedw(fifo_size));
//
// assign LEDR[0] = empty;

// Ensure the FIFO only fills up to 30 values instead of 32
always @(posedge MAX10_CLK1_50)
  begin
    if (allow_write == 1 && fifo_size >= 5'b11101)
      begin
        allow_read = 1;
        allow_write = 0;
      end
    else if (allow_read == 1 && fifo_size == 5'b00000)
      begin
        allow_write = 1;
        allow_read = 0;
      end
    end
endmodule
