`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:17 03/03/2017 
// Design Name: 
// Module Name:    counter_n_bit 
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
module counter_n_bit #(
 parameter cnt_width = 16///用于设置计数位宽
 )
 (
	rst,///复位信号，0为复位，1为计数开始
	clk_in,///参考时钟输入
	cnt_en,//计数使能，1为计数开始，0为停止

	cnt_out///计数结果输出
	);

input rst;
input clk_in;
input cnt_en;                                                                                                                                               

output [cnt_width-1:0] cnt_out;

reg [cnt_width-1:0] cnt_out;

always @ (posedge clk_in)
begin
	if(rst == 1'b0)
	begin
		cnt_out[cnt_width-1:0] <= 0;
	end
	else if(cnt_en == 1'b1)
	begin
		cnt_out[cnt_width-1:0] <= cnt_out[cnt_width-1:0] + 1;
	end
end

endmodule

