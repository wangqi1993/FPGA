`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:23 12/29/2016 
// Design Name: 
// Module Name:    pxi_lock_addr 
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
module pxi_lock_addr(
    input CLK,
	 input ADS,
	 input [31:2] LA,
	 output reg [31:2] LQA	 
	 );

always @(negedge CLK)
	begin
		if(ADS == 1'b0)
			begin
				LQA <= LA;
			end
	end

endmodule
