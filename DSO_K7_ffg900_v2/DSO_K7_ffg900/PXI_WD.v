`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:49:59 01/04/2017 
// Design Name: 
// Module Name:    PXI_WD 
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
module PXI_WD(dataout,datain,data_en);


inout[15:0] datain;
input data_en;
output reg[15:0] dataout;

always@(posedge data_en)
begin
	dataout <= datain;
end


endmodule