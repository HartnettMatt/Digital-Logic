module DieTemp(
      input            MAX10_CLK1_50,
      input            MAX10_CLK2_50,
      input    [0:0]   KEY,
//      input    [9:0]   SW,
      output   [9:0]   LEDR,
      output   [7:0]   HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
      );

// Creating this top level module was a pain, but it runs great.
// misc
wire sys_clk, slow_clock;
reg blip;
wire [11:0] bcd_disp;
reg [3:0] HEX4val;
 
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
bin2bcd U2 (.binary_in(adc_sample_data[8:0]), .bcd_out(bcd_disp));
seg7 U3 (.oSEG(HEX2), .iDIG(bcd_disp[11:8]));
seg7 U4 (.oSEG(HEX1), .iDIG(bcd_disp[7:4]));
seg7 U5 (.oSEG(HEX0), .iDIG(bcd_disp[3:0]));
assign HEX3 = 8'hff;

// display channel in BCD, A/D is channel 17
always @ (cur_adc_ch)
        if (cur_adc_ch <= 9)    
                HEX4val = cur_adc_ch[3:0];
        else
                HEX4val = cur_adc_ch - 4'd10;

assign HEX5 = (cur_adc_ch <= 9) ? 8'b11111111 : 8'b11111001;
seg7 U6 (.oSEG(HEX4), .iDIG(HEX4val));

// Add power //
// This code looks OK, if I could just figure out how to keep the flipflop in the design
// I will have to add this code back in at some point.
// assign LEDR[0] = 1'b0;
// power U7 (.clock(MAX10_CLK1_50), .powerout(LEDR[8]));
// power U8 (.clock(MAX10_CLK1_50), .powerout(LEDR[7]));
// power U9 (.clock(MAX10_CLK1_50), .powerout(LEDR[6]));
// power U10 (.clock(MAX10_CLK1_50), .powerout(LEDR[5]));
// power U11 (.clock(MAX10_CLK2_50), .powerout(LEDR[4]));
// power U12 (.clock(MAX10_CLK2_50), .powerout(LEDR[3]));
// power U13 (.clock(MAX10_CLK2_50), .powerout(LEDR[2]));
// power U14 (.clock(MAX10_CLK2_50), .powerout(LEDR[1]));

endmodule
