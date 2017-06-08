`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:01:46 03/15/2017 
// Design Name: 
// Module Name:    TDC 
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
module TDC(
    	input TDC_en,
		//input [1:0] TDC_sel,
		output Widen_pluse,
		input Expanded_T,
		output [31:0] TDC_T_num,
      
		input trigin,
		input rxclk
		
    );
//产生脉冲
wire A;
wire B;
wire C;
D_flip_flop D_flip_flop_inst1(
   .prn(1),
	.clk(trigin),
	.clrn(TDC_en),
	.d(1),
	.q(A),
	.qb()
	);
D_flip_flop D_flip_flop_inst2(
   .prn(1),
	.clk(~rxclk),
	.clrn(B),
	.d(1),
	.q(),
	.qb(C)
	);
D_flip_flop D_flip_flop_inst3(
   .prn(1),
	.clk(rxclk),
	.clrn(1),
	.d(A),
	.q(B),
	.qb()
	);
	
wire D;
and(D,B,C);
		
D_flip_flop D_flip_flop_inst4(
   .prn(1),
	.clk(A),
	.clrn(D),
	.d(1),
	.q(Widen_pluse),
	.qb()
	);	

//测量展宽后脉冲
//出来的数为Expanded_T的高电平记的数
pulse_width_measure Expanded_T_measure_Inst(
   .refclk(Expanded_T),
	.meaclk(rxclk),
   .outdata(TDC_T_num)
);

endmodule
