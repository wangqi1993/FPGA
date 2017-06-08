`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:09:22 12/29/2016 
// Design Name: 
// Module Name:    pxi_decoder 
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
module pxi_decoder(
    input [31:2] A,
	 input ADS,
	 input LWR,
	 input BLAST,
	 input LCLK,
	 input LHOLD,
	 output [15:0] DMAW,
	 output [15:0] DMAR,
	 output [255:0] AW,
	 output [255:0] AR,
	 output DMAChannelInk,
	 output LHOLDA,
	 output READYN	 
	 );

//����-D������--�ϵ�
D_flip_flop D_flip_flop_inst0(
   .prn(1),
	.clk(LCLK),
	.clrn(1),
	.d(LHOLD),
	.q(LHOLDA),
	.qb()
	);		
//׼����-21mux--�ϵ�
mux21 mux21_inst0(
	.A(0),
	.B(0),
	.S(0),
	.Y(READYN)
	);


//ֱ�Ӷ�д�˿�����
//��д��256���˿ں�
IOport256 IOport256_Inst(
	.ADDR(A),
	.LWR(LWR),
	.BLAST(BLAST),
	.LCLK(LCLK),
	.aw(AW),
	.ar(AR)
	);
	
//DMA��д�˿�����
//��д��16���˿ں�
DMAport16 DMAport16_Inst(
   .ADDR(A),
	.ADS(ADS),
	.LWR(LWR),
	.BLAST(BLAST),
	.LCLK(LCLK),
	.dmaw(DMAW),
	.dmar(DMAR),
	.DMAChannelInk(DMAChannelInk)
	);
	
endmodule