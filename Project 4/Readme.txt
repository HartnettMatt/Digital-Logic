Notes from engineer prior to being arrested by Federal Marshalls

1.  The A/D converter logic is working, and a value representing die temperature is displayed on the 7 segment displays.  I also added the A/D channel to the display, think it is channel 17.

2.  The contract requires that 32,000 flip flops run at full toggle rate to add power.  16,000 flip flops should be clocked by one 50Mhz clock, and 16,000 clocked by the other 50Mhz clock.  I started on the code, but have not yet figured out how to keep Quartus from optimizing out the flip flops.

3.  The A/D temperature output should be captured in a FIFO, one sample per minute.  I have not yet created the FIFO or figured out how to connect it to the A/D.  I was thinking about using a FIFO from the Quartus IP catalog.  I will probably speed up the capture rate while doing development so things don't take so long.

4.  A customer requirement is that, once the FIFO contains 30 samples, I can read them out sequentially by pressing KEY[1] repeatedly until all data is read out.  I talked with the customer and they want the samples read out in the same order they were captured, and once the data is read out, they don't need to read it out again.  A FIFO sounds perfect for this.

5.  The document ug_m10_adc.pdf has a good table showing A/D output values for different temperatures.  Sure glad the customer didn't ask me to convert the output to a temperature value.

6.  I have a bad feeling I am about to be in a lot of trouble, sure hope I have time to finish this project.  If not, I will see if the poor engineer who has to finish this can contact me when I am locked up.
