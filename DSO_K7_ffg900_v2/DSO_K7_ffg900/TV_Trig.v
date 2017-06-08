`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:32 03/10/2017 
// Design Name: 
// Module Name:    TV_Trig 
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
module TV_Trig(
    input 			clk_in10M,
	 input 			OE_IN,
	 input 			HS_IN,
	 input 			ROW_SEL,
	 input 			VIDEO_MODE_SEL,
	 inout [15:0]  DATA,
	 output        even_trig,
	 output        odd_trig,
	 output        anyrow_trig,
	 output	      certainrow_trig
	 );

wire odd_trie;
wire anyrow_trig;

wire video_mode;
wire [15:0] row_number;

//vedio_mode
D_flip_flop D_flip_flop_inst0(
   .prn(1),
	.clk(!VEDIO_MODE_SEL),
	.clrn(1),
	.d(DATA[0]),
	.q(vedio_mode),
	.qb()
	);

//row_number
PXI_WD row_number_Inst(
   .dataout  (row_number[15:0]),
   .datain   (DATA[15:0]),
   .data_en  (ROW_SEL)
   );

//out

oe_field_tri(
   .clk_in(clk_in10M),
   .oe_in(OE_IN),
   .even_field_tri(even_trig),
	.odd_field_tri(odd_trig)
);

any_row_tri(
   .clk_in(clk_in10M),
	.hs_in(HS_IN),
	.odd_field_tri(odd_trig),
	.video_mode(video_mode),
	.hs_out(anyrow_trig)
);

certain_row_tri(
   .clk_in(clk_in10M),
	.hs_out(anyrow_trig),
   .odd_field_tri(odd_trig),
	.sync_number(row_number[9:0]),
	.video_mode(video_mode),
	.tri_out(certainrow_trig)
);



endmodule
