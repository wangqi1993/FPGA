`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:38 05/08/2017 
// Design Name: 
// Module Name:    Signal_Generator 
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
module Signal_Generator(
    input clkin,
	 output [127:0] dataout,
    output trigout	 
	 );
reg [7:0] data = 8'd10;
reg trig;
//产生锯齿波
always@(negedge clkin)//下降沿更新数，好上升沿打出去
begin
	data <= data + 8'd1;
   if(data>245)
		begin
		data <= 8'd10;
		end
end

//产生触发信号
always@(negedge clkin)
begin
	if(data>118)
		begin
			trig <= 1'b1;
		end
	else
		begin
			trig <= 1'b0; 
		end
end

assign dataout ={data[7:0],data[7:0],data[7:0],data[7:0],
					  data[7:0],data[7:0],data[7:0],data[7:0],
					  data[7:0],data[7:0],data[7:0],data[7:0],
					  data[7:0],data[7:0],data[7:0],data[7:0]};
					  
assign trigout =	trig;				  
					  

endmodule
