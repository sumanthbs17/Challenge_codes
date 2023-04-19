`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:44:45 04/18/2023 
// Design Name: 
// Module Name:    count1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module digits(
    input clk_1Hz,
    input result_reset,
	 input updown,
	 input result_load,
	 input state,
	 output reg buzzer,
	 //input stop,
	 //input start,
    output reg [6:0] count
    );
	 reg temp;
	 always @(posedge clk_1Hz or posedge result_reset)
begin
    if(result_reset==1) begin
     if(updown)
      count <= 7'd99;
     else		// Reset button is pressed
    count <=7'd0;
	 end
	 else if(temp>0) begin
	     temp <= temp - 1;
		  buzzer <= 0;
		  end
   else if(state==1'b1) // When stop button is pressed
    count <= count;
    else if(state == 1'b0) // Start counting when stop is off
      if(updown==0 && result_load==0) // Up mode
        if(count==7'd99) begin
		    buzzer<=1'b1;
			 temp<=1;
          count<=7'd0; // Rollover from 99 to 0
			 end
        else
		    count<=count+7'd1;
				// Incrementing
      else if(updown==0 && result_load==1) // Up mode and load pressed 
        count<=7'd90;

      else if(updown==1 && result_load==0)
			// In down mode
        if(count==7'd0)begin
		    buzzer<=1'b1;
			 temp<=1;
          count<=7'd99; // Rollover from 0 to 99
			 end
        else
          count<=count-7'd1; // Decrementing
      else // In down mode and load pressed
        count<=7'd10;
end
endmodule
