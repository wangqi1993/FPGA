`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:55 03/10/2017 
// Design Name: 
// Module Name:    MUX_41 
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
module MUX_41(
    input d0,
	 input d1,
	 input d2,
	 input d3,
	 input s0,
	 input s1,
	 output q	 
	 );

wire dly0,dly1,dly2,dly3;

and(dly0,!s1,!s0,d0);
and(dly1,!s1,s0,d1);
and(dly2,s1,!s0,d2);
and(dly3,s1,s0,d3);

or(q,dly0,dly1,dly2,dly3);

endmodule
