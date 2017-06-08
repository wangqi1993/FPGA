`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:28 02/24/2017 
// Design Name: 
// Module Name:    comparewihtlast_max 
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
module comparewihtlast_max(clk, n, datain, dataout_max, clkenout);
   input        clk;
   input [31:0] n;
   input [7:0]  datain;
   output [7:0] dataout_max;
   reg [7:0]    dataout_max;
   output       clkenout;
   reg          clkenout;
   reg [31:0]   c;
   reg [7:0]    mdata;
   reg [7:0]    mhdata;
   
always @(posedge clk)
begin
	mdata <= datain;
	if (n == 1)
	begin
		dataout_max <= mdata;
		clkenout <= 1'b1;
	end
	else
	begin
		if (mdata > mhdata)
			mhdata <= mdata;
		if (c < (n - 1))
		begin
			clkenout <= 1'b0;
			c <= c + 1;
		end
		else
		begin
			dataout_max <= mhdata;
			mhdata <= mdata;
			clkenout <= 1'b1;
			c <= 32'b00000000000000000000000000000000;
		end
	end
end
   
endmodule
