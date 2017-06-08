`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:17 03/13/2017 
// Design Name: 
// Module Name:    div1000 
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
module div1000(
   clkin,
	cnt_clr,
	clkout
);
input clkin;
input cnt_clr;
output clkout;
reg [15:0] ss;
reg  clkout;

always @(posedge clkin or negedge cnt_clr)
begin
     if(cnt_clr == 1'b0)
	    begin
		 ss <= 16'h0;
		 clkout <= 1'b0;
		 end
	  else 
	    begin
		   if (ss < 16'd500)
			    begin
				    ss <= ss +16'h1;
					 clkout <= clkout;
				 end
			else 
			    begin
				    ss <= 16'h0;
					 clkout <= ~clkout;
				 end  
		 end
end

endmodule 
