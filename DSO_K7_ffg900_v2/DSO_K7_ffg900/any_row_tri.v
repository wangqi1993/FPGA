`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:18 03/10/2017 
// Design Name: 
// Module Name:    any_row_tri 
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
module any_row_tri
 (
	clk_in, 
	hs_in,
	odd_field_tri,
	video_mode,	 
	hs_out
 );
 
input		clk_in; 
input		hs_in;
input		odd_field_tri;
input	   video_mode;	 
output   hs_out;

reg	[9:0]  count;
reg	   count_reg;
reg	   count_reg1;
reg		hs_out;
reg		hs_in_reg;
reg		hs_in_reg1;

always @(posedge clk_in)
begin
	hs_in_reg <= hs_in;
	hs_in_reg1 <= hs_in_reg;
end

always @(posedge clk_in )
begin
	case (video_mode)
	1'b0: // NTSC
	begin
		if (odd_field_tri == 1'b1)
		begin
			count <= 1;
			count_reg <= 0;
		end						  
		else if(hs_in_reg1 == 1'b1 && hs_in_reg == 1'b0)
		begin	   
			if (count == 1 || count == 3 || count == 5 || count == 7 || count == 9 || count == 11 || count == 538 || count == 540 || count == 542)
			begin
				count_reg <= count_reg;
			end
			else if(count == 266 || count == 268 || count == 270 || count == 272 || count == 274 || count == 276 || count == 278 || count == 280 || count == 282)
			begin
				count_reg <= count_reg;
			end
			else
				count_reg <= ~count_reg; 	
			count <= count + 1'b1; 
		end		
	end

	1'b1: //PAL
	begin
		if (odd_field_tri == 1'b1)
		begin
			count <= 1;
			count_reg <= 0;
		end						  
		else if(hs_in_reg1 == 1'b1 && hs_in_reg == 1'b0)
		begin	   
			if (count == 1 || count == 3 || count == 5 || count == 7 || count == 9 || count == 635 || count == 637 || count == 639)
			begin
				count_reg <= count_reg;
			end
			else if(count == 316 || count == 318 || count == 320 || count == 322 || count == 324 || count == 326 || count == 328)
			begin
				count_reg <= count_reg;
			end
			else
				count_reg <= ~count_reg; 
			count <= count + 1'b1; 	
		end		
	end
	endcase
end

always @(posedge clk_in)
begin
   if (odd_field_tri == 1'b1)
	begin
		count_reg1 <= 0;
	end
   else	
	   count_reg1 <= count_reg;
end

always @(posedge clk_in)
begin
   if (odd_field_tri == 1'b1)
	begin
		hs_out <= 1'b1;
	end	
	else if (count_reg1 != count_reg)
	begin
	   hs_out <= 1'b0;
	end
	else
	   hs_out <= 1'b1;
end

endmodule
