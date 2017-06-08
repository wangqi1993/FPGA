`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:48 02/23/2017 
// Design Name: 
// Module Name:    hc74374b 
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
module hc74374b(
     input ONE,
	  input CLK,
	  input [8:1] D,
	  input [8:1] Q 	 
	 );

wire A1;
wire A2;
wire A3;
wire A4;
wire A5;
wire A6;
wire A7;
wire A8;
 
wire	SYNTHESIZED_WIRE_8; 
assign	SYNTHESIZED_WIRE_8 = ~ ONE; 
         
D_flip_flop D_flip_flop_inst0(
   .prn(1),
	.clk(CLK),
	.clrn(1),
	.d(D[1]),
	.q(A1),
	.qb()
	);	
D_flip_flop D_flip_flop_inst1(
   .prn(1),
	.clk(CLK),
	.clrn(1),
	.d(D[2]),
	.q(A2),
	.qb()
	);
D_flip_flop D_flip_flop_inst2(
   .prn(1),
	.clk(CLK),
	.clrn(1),
	.d(D[4]),
	.q(A4),
	.qb()
	);
D_flip_flop D_flip_flop_inst3(
   .prn(1),
	.clk(CLK),
	.clrn(1),
	.d(D[4]),
	.q(A4),
	.qb()
	);
D_flip_flop D_flip_flop_inst4(
   .prn(1),
	.clk(CLK),
	.clrn(1),
	.d(D[5]),
	.q(A5),
	.qb()
	);
D_flip_flop D_flip_flop_inst5(
   .prn(1),
	.clk(CLK),
	.clrn(1),
	.d(D[6]),
	.q(A6),
	.qb()
	);
D_flip_flop D_flip_flop_inst6(
   .prn(1),
	.clk(CLK),
	.clrn(1),
	.d(D[7]),
	.q(A7),
	.qb()
	);
D_flip_flop D_flip_flop_inst7(
   .prn(1),
	.clk(CLK),
	.clrn(1),
	.d(D[8]),
	.q(A8),
	.qb()
	);

			 
assign	Q[1] = SYNTHESIZED_WIRE_8 ? A1 : 1'bz;

assign	Q[2] = SYNTHESIZED_WIRE_8 ? A2 : 1'bz;

assign	Q[3] = SYNTHESIZED_WIRE_8 ? A3 : 1'bz;
			 
assign	Q[4] = SYNTHESIZED_WIRE_8 ? A4 : 1'bz;

assign	Q[5] = SYNTHESIZED_WIRE_8 ? A5 : 1'bz;

assign	Q[6] = SYNTHESIZED_WIRE_8 ? A6 : 1'bz;

assign	Q[7] = SYNTHESIZED_WIRE_8 ? A7 : 1'bz;

assign	Q[8] = SYNTHESIZED_WIRE_8 ? A8 : 1'bz;			 

endmodule
