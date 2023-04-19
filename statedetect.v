`timescale 1ns / 1ps

module statedetect(result_start,result_stop,clk_50MHz,state);
input result_start,result_stop,clk_50MHz;
output reg state;

always@(posedge clk_50MHz)
begin
if(result_start)
   state=1'b0;
else if (result_stop)
	state=1'b1;
end

endmodule 