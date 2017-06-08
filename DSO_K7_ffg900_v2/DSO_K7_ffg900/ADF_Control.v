`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:13:40 02/20/2017 
// Design Name: 
// Module Name:    ADF_Control 
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
module ADF_Control(
    input clk_2M,
	 //input clk_100M,
	 input adf_data_h,
	 input adf_data_l,
	 input adf_clr,   
	 inout [15:0] data,
	 output adf_cs,
	 output adf_din,
	 output adf_sclk
	 );

//第一步加载数据
wire [31:0] pll_data;
//w_r_mod32 w_r_mod32_Inst(
//		.aw_r_in_L(adf_data_l),
//		.aw_r_in_H(adf_data_h),
//		.clkin(clk_100M),
//		.busdata(data),
//		.rstout(pll_data)
//		);

PXI_WD L16(
   .dataout  (pll_data[15:0]),
   .datain   (data),
   .data_en  (adf_data_l)//posedge
   );	
PXI_WD H16(
   .dataout  (pll_data[31:16]),
   .datain   (data),
   .data_en  (adf_data_h)//posedge
   );


//adf_clr
wire clr;
D_flip_flop D_flip_flop_inst0(
   .prn(1),
	.clk(adf_clr),
	.clrn(1),
	.d(data[0]),
	.q(clr),
	.qb()
	);
//spi
SPI_interface SPI_Interface_Inst(
	.data(pll_data),
	.clk(clk_2M),
	.clr(clr),
	.cs(adf_cs),
	.din(adf_din),
	.sclk(adf_sclk)
	);


endmodule
