`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:04:20 03/10/2017 
// Design Name: 
// Module Name:    oe_field_tri 
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
module oe_field_tri(
	clk_in,
	oe_in,                    // Odd/Even Field iutput                 
	even_field_tri,
	odd_field_tri
 );
input	   clk_in;
input	   oe_in;              // Odd/Even Field iutput
output 	odd_field_tri; 
output 	even_field_tri; 

reg      oe_in_reg;
reg      oe_in_reg1; 
reg      odd_field_tri;
reg      even_field_tri;
  
always @ (posedge clk_in)
begin
	oe_in_reg <= oe_in;
	oe_in_reg1 <= oe_in_reg;
end

always @ (posedge clk_in)
begin 
	if(oe_in_reg1 == 1'b0 && oe_in_reg == 1'b1)
	begin
		odd_field_tri  <= 1'b1;		
	end
	else if(oe_in_reg1 == 1'b1 && oe_in_reg == 1'b0)        
	begin
		even_field_tri <= 1'b1;		
	end	
	else 
	begin
		even_field_tri <= 1'b0;
		odd_field_tri  <= 1'b0;
	end	
end

endmodule
