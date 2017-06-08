`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:21:09 03/16/2017 
// Design Name: 
// Module Name:    pulse_width_measure 
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
module pulse_width_measure(
    input 			refclk,
	 input    		meaclk,
	 output [31:0] outdata	 
	 );

reg [31:0] data;
reg [31:0] realdata;

reg reflk_dly1,reflk_dly2,reflk_dly3; 
//用被测时钟给参考时钟打拍-分析时序打3拍合适
always @(posedge meaclk)
begin
	reflk_dly1 <= refclk;
   reflk_dly2 <= reflk_dly1;
   reflk_dly3 <= reflk_dly2;
end

//计半个参考时钟的数
always @(posedge meaclk)
begin
   data <= data+32'd1;	
	
	if(reflk_dly1 == 1'b1 && reflk_dly2 == 1'b0)//每次上升沿
	  data <=32'd0;
	else if(reflk_dly2 == 1'b0 && reflk_dly3 == 1'b1)//检测上升沿后的第一个下降沿
	  realdata<= data;
	  
end

assign outdata = realdata;

endmodule