`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:30:14 02/10/2017 
// Design Name: 
// Module Name:    DMAport16 
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
module DMAport16(
     ADDR,
	  ADS,
	  LWR,
	  BLAST,
	  LCLK,
	  dmaw,
	  dmar,
	  DMAChannelInk
	 );

input [31:2] ADDR;
input ADS;
input LWR;
input BLAST;
input LCLK;
output wire [15:0] dmaw/* synthesis syn_keep = 1 */;
output wire [15:0] dmar/* synthesis syn_keep = 1 */;
output wire DMAChannelInk/* synthesis syn_keep = 1 */;

wire [15:0] aden/* synthesis syn_keep = 1 */;

wire ADS_dly1,ADS_dly2,ADS_dly3;

D_flip_flop D_flip_flop_inst1(
   .prn(1),
	.clk(!LCLK),
	.clrn(1),
	.d(ADS),
	.q(ADS_dly1),
	.qb()
	);
D_flip_flop D_flip_flop_inst2(
   .prn(1),
	.clk(LCLK),
	.clrn(1),
	.d(ADS_dly1),
	.q(ADS_dly2),
	.qb()
	);
D_flip_flop D_flip_flop_inst3(
   .prn(ADS_dly2),
	.clk(BLAST),
	.clrn(1),
	.d(0),
	.q(),
	.qb(ADS_dly3)
	);

assign DMAChannelInk = ADS_dly3 | !ADDR[21];//选通数据--这个功能可被DMAR端口替代

wire  addr_h_sel;//高位地址若不用则译0
assign   addr_h_sel=(ADDR[2]  | ADDR[3]  | ADDR[4]  | ADDR[5]  | ADDR[6]  | ADDR[7]  |
							ADDR[8]  | ADDR[9]  | ADDR[10] | ADDR[11] | ADDR[12] |
							ADDR[14] | ADDR[15] | ADDR[16] | ADDR[17] | ADDR[18] |
						   ADDR[22] | ADDR[23] | ADDR[24] | ADDR[25] | ADDR[26] | ADDR[27] |
						   ADDR[28] | ADDR[29] | ADDR[30] | ADDR[31] );

hc74154 	hc74154_inst0(
	.D(0),
	.C(ADDR[20]),
	.B(ADDR[19]),
	.A(ADDR[13]),
	.G1N((!ADDR[21] | addr_h_sel)),
	.G2N(ADS_dly3),
	.O0N(aden[0]),	
	.O1N(aden[1]),	
	.O2N(aden[2]),
	.O3N(aden[3]),
	.O4N(aden[4]),
	.O5N(aden[5]),	
	.O6N(aden[6]),	
	.O7N(aden[7]),
	.O8N(aden[8]),
	.O9N(aden[9]),
	.O10N(aden[10]),
	.O11N(aden[11]),
	.O12N(aden[12]),	
	.O13N(aden[13]),
	.O14N(aden[14]),
	.O15N(aden[15])	
	);

assign	dmaw[15] = (~aden[15]) & LWR & !LCLK;	
assign	dmaw[14] = (~aden[15]) & LWR & !LCLK;
assign	dmaw[13] = (~aden[15]) & LWR & !LCLK;	
assign	dmaw[12] = (~aden[15]) & LWR & !LCLK;
assign	dmaw[11] = (~aden[15]) & LWR & !LCLK;	
assign	dmaw[10] = (~aden[15]) & LWR & !LCLK;
assign	dmaw[9] = (~aden[15]) & LWR & !LCLK;	
assign	dmaw[8] = (~aden[15]) & LWR & !LCLK;
assign	dmaw[7] = (~aden[15]) & LWR & !LCLK;	
assign	dmaw[6] = (~aden[15]) & LWR & !LCLK;
assign	dmaw[5] = (~aden[15]) & LWR & !LCLK;	
assign	dmaw[4] = (~aden[15]) & LWR & !LCLK;
assign	dmaw[3] = (~aden[15]) & LWR & !LCLK;	
assign	dmaw[2] = (~aden[15]) & LWR & !LCLK;
assign	dmaw[1] = (~aden[15]) & LWR & !LCLK;	
assign	dmaw[0] = (~aden[15]) & LWR & !LCLK;


assign	dmar[15] = aden[15] | LWR | LCLK;	
assign	dmar[14] = aden[14] | LWR | LCLK;	
assign	dmar[13] = aden[13] | LWR | LCLK;	
assign	dmar[12] = aden[12] | LWR | LCLK;	
assign	dmar[11] = aden[11] | LWR | LCLK;	
assign	dmar[10] = aden[10] | LWR | LCLK;	
assign	dmar[9] = aden[9] | LWR | LCLK;	
assign	dmar[8] = aden[8] | LWR | LCLK;	
assign	dmar[7] = aden[7] | LWR | LCLK;	
assign	dmar[6] = aden[5] | LWR | LCLK;
assign	dmar[5] = aden[4] | LWR | LCLK;	
assign	dmar[4] = aden[4] | LWR | LCLK;	
assign	dmar[3] = aden[3] | LWR | LCLK;	
assign	dmar[2] = aden[2] | LWR | LCLK;
assign	dmar[1] = aden[1] | LWR | LCLK;	
assign	dmar[0] = aden[0] | LWR | LCLK;//DMAR端口读数时钟




endmodule
