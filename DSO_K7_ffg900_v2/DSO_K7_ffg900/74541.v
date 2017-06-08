// Copyright (C) 1991-2012 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 32-bit"
// VERSION		"Version 12.0 Build 178 05/31/2012 SJ Full Version"
// CREATED		"Tue Sep 20 10:15:52 2016"

module hc74541 (
	A7,
	A8,
	A6,
	A5,
	A3,
	A4,
	A2,
	A1,
	GN2,
	GN1,
	Y7,
	Y8,
	Y6,
	Y5,
	Y3,
	Y4,
	Y2,
	Y1
);


input wire	A7;
input wire	A8;
input wire	A6;
input wire	A5;
input wire	A3;
input wire	A4;
input wire	A2;
input wire	A1;
input wire	GN2;
input wire	GN1;
output wire	Y7;
output wire	Y8;
output wire	Y6;
output wire	Y5;
output wire	Y3;
output wire	Y4;
output wire	Y2;
output wire	Y1;

wire	SYNTHESIZED_WIRE_8;




assign	Y4 = SYNTHESIZED_WIRE_8 ? A4 : 1'bz;

assign	Y3 = SYNTHESIZED_WIRE_8 ? A3 : 1'bz;

assign	Y5 = SYNTHESIZED_WIRE_8 ? A5 : 1'bz;

assign	Y6 = SYNTHESIZED_WIRE_8 ? A6 : 1'bz;

assign	SYNTHESIZED_WIRE_8 = ~(GN1 | GN2);

assign	Y8 = SYNTHESIZED_WIRE_8 ? A8 : 1'bz;

assign	Y7 = SYNTHESIZED_WIRE_8 ? A7 : 1'bz;

assign	Y1 = SYNTHESIZED_WIRE_8 ? A1 : 1'bz;

assign	Y2 = SYNTHESIZED_WIRE_8 ? A2 : 1'bz;


endmodule
