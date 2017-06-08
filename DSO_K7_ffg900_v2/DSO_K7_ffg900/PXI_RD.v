`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:52:08 01/04/2017 
// Design Name: 
// Module Name:    PXI_RD 
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
module PXI_RD(dout,din,den);
output[15:0] dout;
input[15:0] din;
input den;
hc74541 	hc74541_inst0(
	.GN2(den),
	.A1(din[0]),
	.A2(din[1]),
	.A3(din[2]),
	.A4(din[3]),
	.A5(din[4]),
	.A6(din[5]),
	.A7(din[6]),
	.A8(din[7]),
	.GN1(den),
	.Y8(dout[7]),
	.Y7(dout[6]),
	.Y6(dout[5]),
	.Y5(dout[4]),
	.Y4(dout[3]),
	.Y3(dout[2]),
	.Y2(dout[1]),
	.Y1(dout[0]));


hc74541 	hc74541_inst1(
	.GN2(den),
	.A1(din[8]),
	.A2(din[9]),
	.A3(din[10]),
	.A4(din[11]),
	.A5(din[12]),
	.A6(din[13]),
	.A7(din[14]),
	.A8(din[15]),
	.GN1(den),
	.Y8(dout[15]),
	.Y7(dout[14]),
	.Y6(dout[13]),
	.Y5(dout[12]),
	.Y4(dout[11]),
	.Y3(dout[10]),
	.Y2(dout[9]),
	.Y1(dout[8]));
endmodule

