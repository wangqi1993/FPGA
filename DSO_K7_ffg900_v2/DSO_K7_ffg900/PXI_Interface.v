`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:10 12/29/2016 
// Design Name: 
// Module Name:    PXI_Interface 
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
module PXI_Interface(
    input ADSN,
	 input LHOLD,
	 input LCLK,//µ◊∞Â20M
	 input LWRN,
	 input BLASTN,
	 input [31:2] LA,
	 inout [15:0] LD,
	 output READYN,
	 output LHOLDA,
	 output [15:0] DMAW,
	 output [15:0] DMAR,
	 output [255:0] AW,
	 output [255:0] AR,
	 output DMAChannelInk 	 	 	 
    );





//µÿ÷∑À¯∂®
wire [31:2] LQA;
pxi_lock_addr pxi_lock_addr_inst0(
	 .CLK(LCLK),
	 .ADS(ADSN),
	 .LA(LA),
	 .LQA(LQA)
	 );	
//µÿ÷∑“Î¬Î	
pxi_decoder pxi_decoder_inst0(
    .A(LQA),
	 .ADS(ADSN),
	 .LWR(LWRN),
	 .BLAST(BLASTN),
	 .LCLK(LCLK),
	 .LHOLD(LHOLD),
	 .DMAW(DMAW),
	 .DMAR(DMAR),
	 .AW(AW),
	 .AR(AR),
	 .DMAChannelInk(DMAChannelInk),
	 .LHOLDA(LHOLDA),
	 .READYN(READYN)	 
    );

//PXI∂¡–¥≤‚ ‘
wire [15:0] test_pxi_data/* synthesis syn_keep = 1 */;	
PXI_WD pxidata_test_w(
   .dataout  (test_pxi_data[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[1])//posedge
   );		
PXI_RD pxidata_test_r0(
   .dout  (LD[15:0]),
   .din   (test_pxi_data[15:0]),
   .den  (AR[1])//low active
   );
PXI_RD pxidata_test_r1(
   .dout  (LD[15:0]),
   .din   (16'h55aa),
   .den  (AR[2])
   );	
PXI_RD pxidata_test_r2(
   .dout  (LD[15:0]),
   .din   (16'h55aa),
   .den  (DMAR[1])
   );	


endmodule
