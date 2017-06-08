`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:08 02/24/2017 
// Design Name: 
// Module Name:    normal_path 
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
module normal_path(
	data_clk,
	div_n,
	cnt_clr,
	data1in,
	data2in,
	data3in,
	data4in, 
	dataout,
	wr_en
);
input data_clk;
input [31:0] div_n;
input cnt_clr;
input [7:0]    data1in;
input [7:0]    data2in;
input [7:0]    data3in;
input [7:0]    data4in;
output [127:0] dataout;
output         wr_en;


reg [31:0] div_n_dly1;
reg          enout1;
reg   [31:0]   c;
reg [127:0]    dataout;

reg            wclken;
reg            cc;
reg [1:0]      ss;
reg [127:0]    data;

	
/*generate the first data enable signal */
always @(posedge data_clk)
	begin
			 div_n_dly1 <= div_n;
	end	
	
	
always @(posedge data_clk)
	begin
		if (c < div_n_dly1 - 1)
			c <= c + 1;
		else
			c <= 32'h00000000;
	end
   
always @(posedge data_clk)
	begin
		if (div_n_dly1 == 1)
			enout1 <= 1'b1;
		else if (c < (div_n_dly1 - 1))
			enout1 <= 1'b0;
		else
			enout1 <= 1'b1;
	end
		


   
always @(posedge data_clk or negedge cnt_clr)
begin 
	if (cnt_clr == 1'b0)
		ss <= 2'b00;
	else if (enout1 == 1'b1)
	begin
			ss <= ss + 1;
			case (ss)
				2'b00 :
					begin
						cc<= 1'b0;
						data[7:0] <= data1in;
						data[39:32] <= data2in;
						data[71:64] <= data3in;
						data[103:96] <= data4in;
					end
				2'b01 :
					begin
						cc<= 1'b0;
						data[15:8] <= data1in;
						data[47:40] <= data2in;
						data[79:72] <= data3in;
						data[111:104] <= data4in;
					end
				2'b10 :
					begin
						cc<= 1'b0;
						data[23:16] <= data1in;
						data[55:48] <= data2in;
						data[87:80] <= data3in;
						data[119:112] <= data4in;
					end
				2'b11 :
					begin
						cc<= 1'b1;
						data[31:24] <= data1in;
						data[63:56] <= data2in;
						data[95:88] <= data3in;
						data[127:120] <= data4in;
					end
				default :
				   begin
					data[127:0] <= 128'h00000000000000000000000000000000;
					cc<= 1'b0;
					end
			endcase
	end
end

always @(posedge data_clk )   
	begin
		dataout[127:0] <= data[127:0];
		wclken <= cc;
	end

assign wr_en = enout1 & wclken;	
	
endmodule 

