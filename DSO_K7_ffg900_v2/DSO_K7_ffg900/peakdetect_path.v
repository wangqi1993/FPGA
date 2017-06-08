`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:08 02/24/2017 
// Design Name: 
// Module Name:    peakdetect_path 
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
module peakdetect_path(
	DATA_CLK,
	CNTCLR,
	datain,
	div_n_maxmin,
	wr_enable,
	dataout
);
input	DATA_CLK;
input CNTCLR;
input	[127:0] datain;
input	[31:0] div_n_maxmin;
output	wr_enable;
output	[127:0] dataout;
wire	CNTCLR;
wire	[15:0] data1in;
wire	[15:0] data2in;
wire	[15:0] data3in;
wire	[15:0] data4in;

maxmin_detect	maxmin_detect_inst0(
	.clk(DATA_CLK),
	.data(datain),
	.n(div_n_maxmin),
	.enout(enout),
	.s20max(data1in[15:8]),
	.s20min(data1in[7:0]),
	.s21max(data2in[15:8]),
	.s21min(data2in[7:0]),
	.s22max(data3in[15:8]),
	.s22min(data3in[7:0]),
	.s23max(data4in[15:8]),
	.s23min(data4in[7:0]));


combine64to128	combine64to128_inst0(
	.clk(DATA_CLK),
	.clr(CNTCLR),
	.wen(enout),
	.data1in(data1in),
	.data2in(data2in),
	.data3in(data3in),
	.data4in(data4in),
	.wclk(enout1),
	.dataout(dataout));

assign	wr_enable = enout & enout1;

endmodule
