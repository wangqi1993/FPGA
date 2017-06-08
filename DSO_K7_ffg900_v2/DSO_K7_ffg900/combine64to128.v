`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:01 02/24/2017 
// Design Name: 
// Module Name:    combine64to128 
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
module combine64to128(clk, clr, wen, data1in, data2in, data3in, data4in, dataout, wclk);
   input          clk;
   input          clr;
   input          wen;
   input [15:0]   data1in;
   input [15:0]   data2in;
   input [15:0]   data3in;
   input [15:0]   data4in;
   output [127:0] dataout;
   output         wclk;
   reg            c;
   reg            ss;
   reg [127:0]    data;
   
always @(posedge clk or negedge clr)
begin
	if (clr == 1'b0)
		ss <= 1'b0;
	else if (wen == 1'b1)
	begin
			ss <= ss + 1;
			case (ss)
				1'b0 :
					begin
						c <= 1'b0;
						data[15:0] <= data1in;
						data[47:32] <= data2in;
						data[79:64] <= data3in;
						data[111:96] <= data4in;
					end
				1'b1 :
					begin
						c <= 1'b1;
						data[31:16] <= data1in;
						data[63:48] <= data2in;
						data[95:80] <= data3in;
						data[127:112] <= data4in;
					end
				default :
					c <= 1'b0;
			endcase
	end
end
   assign dataout = data;
   assign wclk = c;
   
endmodule
