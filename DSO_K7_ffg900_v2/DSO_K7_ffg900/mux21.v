`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:44:32 01/04/2017 
// Design Name: 
// Module Name:    mux21 
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
module mux21(
    input A,
	 input B,
	 input S,
	 output Y
	 );
wire dly1,dly2,dly3;

not(dly1,S);
and(dly2,A,S);
and(dly3,B,dly1);
or(Y,dly2,dly3);

endmodule
