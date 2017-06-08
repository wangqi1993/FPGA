`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:59:21 12/30/2016 
// Design Name: 
// Module Name:    lock_blast 
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
module lock_blast(
    input CLK,
	 input BLAST,
	 output reg Q
	 );

always @(negedge CLK)
	begin
		if(BLAST == 1'b0)
			begin
				Q <= 1'b1;
			end
		else
			begin
				Q <= 1'b0;
			end
	end
endmodule
