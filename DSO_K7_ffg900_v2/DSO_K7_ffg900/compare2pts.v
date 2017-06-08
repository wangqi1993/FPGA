`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:33 02/24/2017 
// Design Name: 
// Module Name:    compare2pts 
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
module compare2pts(clk, data1, data2, max, min);
   input        clk;
   input [7:0]  data1;
   input [7:0]  data2;
   output [7:0] max;
   reg [7:0]    max;
   output [7:0] min;
   reg [7:0]    min;
   reg [7:0]    mdata1;
   reg [7:0]    mdata2;
always @(posedge clk)
	begin
		mdata1 <= data1;
		mdata2 <= data2;
		if (mdata1 >= mdata2)
		begin
			max <= mdata1;
			min <= mdata2;
		end
		else
		begin
			max <= mdata2;
			min <= mdata1;
		end
	end
   
endmodule
