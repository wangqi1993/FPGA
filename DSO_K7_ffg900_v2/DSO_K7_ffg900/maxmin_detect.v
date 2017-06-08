`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:59:04 02/24/2017 
// Design Name: 
// Module Name:    maxmin_detect 
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
module maxmin_detect(
	clk,
	data,
	n,
	enout,
	s20max,
	s20min,
	s21max,
	s21min,
	s22max,
	s22min,
	s23max,
	s23min
);


input	clk;
input	[127:0] data;
input	[31:0] n;
output	enout;
output	[7:0] s20max;
output	[7:0] s20min;
output	[7:0] s21max;
output	[7:0] s21min;
output	[7:0] s22max;
output	[7:0] s22min;
output	[7:0] s23max;
output	[7:0] s23min;

wire	[7:0] s10max;
wire	[7:0] s10min;
wire	[7:0] s11max;
wire	[7:0] s11min;
wire	[7:0] s12max;
wire	[7:0] s12min;
wire	[7:0] s13max;
wire	[7:0] s13min;





compare4pts	compare4pts_inst0(
	.clk(clk),
	.data0(data[7:0]),
	.data1(data[15:8]),
	.data2(data[23:16]),
	.data3(data[31:24]),
	.max(s10max),
	.min(s10min));
	
compare4pts	compare4pts_inst1(
	.clk(clk),
	.data0(data[39:32]),
	.data1(data[47:40]),
	.data2(data[55:48]),
	.data3(data[63:56]),
	.max(s11max),
	.min(s11min));

compare4pts	compare4pts_inst2(
	.clk(clk),
	.data0(data[71:64]),
	.data1(data[79:72]),
	.data2(data[87:80]),
	.data3(data[95:88]),
	.max(s12max),
	.min(s12min));

compare4pts	compare4pts_inst3(
	.clk(clk),
	.data0(data[103:96]),
	.data1(data[111:104]),
	.data2(data[119:112]),
	.data3(data[127:120]),
	.max(s13max),
	.min(s13min));

comparewihtlast_max	comparewihtlast_max_inst0(
	.clk(clk),
	.datain(s10max),
	.n(n),
	
	.dataout_max(s20max));


comparewihtlast_max	comparewihtlast_max_inst1(
	.clk(clk),
	.datain(s11max),
	.n(n),
	
	.dataout_max(s21max));


comparewihtlast_max	comparewihtlast_max_inst2(
	.clk(clk),
	.datain(s12max),
	.n(n),
	
	.dataout_max(s22max));


comparewihtlast_max	comparewihtlast_max_inst3(
	.clk(clk),
	.datain(s13max),
	.n(n),
	.clkenout(enout),
	.dataout_max(s23max));


comparewihtlast_min	comparewihtlast_min_inst0(
	.clk(clk),
	.datain(s10min),
	.n(n),
	
	.dataout_min(s20min));


comparewihtlast_min	comparewihtlast_min_inst1(
	.clk(clk),
	.datain(s11min),
	.n(n),
	
	.dataout_min(s21min));

comparewihtlast_min	comparewihtlast_min_inst2(
	.clk(clk),
	.datain(s12min),
	.n(n),
	
	.dataout_min(s22min));

comparewihtlast_min	comparewihtlast_min_inst3(
	.clk(clk),
	.datain(s13min),
	.n(n),
	
	.dataout_min(s23min));
	
endmodule

