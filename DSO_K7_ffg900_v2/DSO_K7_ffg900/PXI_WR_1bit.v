`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:57:40 01/06/2017 
// Design Name: 
// Module Name:    PXI_WR_1bit 
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
module PXI_WD_1bit(dataout,datain,data_en);


inout datain;
input data_en;
output reg dataout;

always@(posedge data_en)
begin
	dataout <= datain;
end


endmodule
