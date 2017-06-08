`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:19:19 03/10/2017 
// Design Name: 
// Module Name:    certain_row_tri 
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
module certain_row_tri
 (
	clk_in, 
	hs_out,
	odd_field_tri,
	sync_number, 
	video_mode,	 
	tri_out
 );
 
input		clk_in; 
input		hs_out;
input		odd_field_tri;
input	[9:0] sync_number; 
input	 	video_mode;	 
output	tri_out;

reg	[9:0] count;
reg		tri_out;
reg		count_en;
reg		hs_out_reg;
reg		hs_out_reg1;
reg	[9:0]	sync_number_buf;

always @(posedge clk_in)
begin
	sync_number_buf <= sync_number;
end

always @(posedge clk_in)
begin
	hs_out_reg <= hs_out;
	hs_out_reg1 <= hs_out_reg;
end

always @(posedge clk_in )
begin
	case (video_mode)
	1'b0: // NTSC
	begin
		if (odd_field_tri == 1'b1)
		begin
			count_en <= 1;
			count <= 5;
			tri_out <= 0;	
		end						  
		else if(hs_out_reg1 == 1'b1 && hs_out_reg == 1'b0 && count_en == 1'b1)
		begin
			if (count == sync_number_buf)
			begin
				tri_out <= 1;
				count_en <= 0;
			end

			if(count == 525)
			begin
				count <= 10'h001;	
			end	
		   else	
		   count <= count + 1'b1; 			
		end
	end

	1'b1: // PAL
	begin
		if (odd_field_tri == 1'b1)
		begin
			count_en <= 1;
			count <= 2;
			tri_out <= 0;	
		end						  
		else if(hs_out_reg1 == 1'b1 && hs_out_reg == 1'b0 && count_en == 1'b1)
		begin
			if (count == sync_number_buf)
			begin
				tri_out <= 1;
				count_en <= 0;
			end
			
			if(count == 625)
			begin
				count <= 10'h001;	
			end	 
			else
		   count <= count + 1'b1; 
		end
	end
	/*
	3'b010: // 480I?????
	begin
		if (odd_field_tri == 1'b1)
		begin
			count_en <= 1;
			count <= 1;
		end						  
		else if(HSOUT_reg1 == 1'b1 && HSOUT_reg == 1'b0 && count_en == 1'b1)
		begin
			if (count == sync_number_buf)
			begin
				tri_out <= 1;
				count_en <= 0;
			end
			else
			begin
				tri_out <= 0;
				count <= count + 1; 								 
			end
		end
	end

	3'b011: // 480P?????
	begin
		if (VSOUT_reg == 1'b1 && VSOUT == 1'b0)
		begin
			count_en <= 1;
			count <= 1;
		end						  
		else if(HSOUT_reg1 == 1'b1 && HSOUT_reg == 1'b0 && count_en == 1'b1)
		begin
			if (count == sync_number_buf)
			begin
				tri_out <= 1;
				count_en <= 0;
			end
			else
			begin
				tri_out <= 0;
				count <= count + 1; 								 
			end
		end
	end

	3'b100: // 576I?????
	begin
		if (odd_field_tri == 1'b1)
		begin
			count_en <= 1;
			count <= 1;
		end						  
		else if(HSOUT_reg1 == 1'b1 && HSOUT_reg == 1'b0 && count_en == 1'b1)
		begin
			if (count == sync_number_buf)
			begin
				tri_out <= 1;
				count_en <= 0;
			end
			else
			begin
				tri_out <= 0;
				count <= count + 1; 								 
			end
		end
	end

	3'b101: // 576P?????
	begin
		if (VSOUT_reg == 1'b1 && VSOUT == 1'b0)
		begin
			count_en <= 1;
			count <= 1;
		end						  
		else if(HSOUT_reg1 == 1'b1 && HSOUT_reg == 1'b0 && count_en == 1'b1)
		begin
			if (count == sync_number_buf)
			begin
				tri_out <= 1;
				count_en <= 0;
			end
			else
			begin
				tri_out <= 0;
				count <= count + 1; 								 
			end
		end
	end
	*/
	endcase
end

endmodule
