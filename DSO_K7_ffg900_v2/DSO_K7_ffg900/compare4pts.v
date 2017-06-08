`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:41 02/24/2017 
// Design Name: 
// Module Name:    compare4pts 
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
module compare4pts(
	clk,
	data0,
	data1,
	data2,
	data3,
	max,
	min
);
input	clk;
input	[7:0] data0;
input	[7:0] data1;
input	[7:0] data2;
input	[7:0] data3;
output	[7:0] max;
output	[7:0] min;

wire	[7:0] m0_max;
wire	[7:0] m0_min;
wire	[7:0] m1_max;
wire	[7:0] m1_min;





compare2pts	b2v_inst(
	.clk(clk),
	.data1(data0),
	.data2(data1),
	.max(m0_max),
	.min(m0_min));


compare2pts	b2v_inst2(
	.clk(clk),
	.data1(data2),
	.data2(data3),
	.max(m1_max),
	.min(m1_min));


compare2pts	b2v_inst5(
	.clk(clk),
	.data1(m0_max),
	.data2(m1_max),
	.max(max)
	);


compare2pts	b2v_inst7(
	.clk(clk),
	.data1(m0_min),
	.data2(m1_min),
	
	.min(min));


endmodule

