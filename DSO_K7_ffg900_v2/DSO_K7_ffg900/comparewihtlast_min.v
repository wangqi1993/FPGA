`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:36 02/24/2017 
// Design Name: 
// Module Name:    comparewihtlast_min 
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
module comparewihtlast_min(clk, n, datain, dataout_min, clkenout);
   input        clk;
   input [31:0] n;
   input [7:0]  datain;
   output [7:0] dataout_min;
   reg [7:0]    dataout_min;
   output       clkenout;
   reg          clkenout;
   reg [31:0]   c;
   reg [7:0]    mdata;
   reg [7:0]    mldata;
   
always @(posedge clk)
   begin
         mdata <= datain;
         if (n == 1)
         begin
            dataout_min <= mdata;
            clkenout <= 1'b1;
         end
         else
         begin
            if (mdata < mldata)
               mldata <= mdata;
            
            if (c < (n - 1))
            begin
               clkenout <= 1'b0;
               c <= c + 1;
            end
            else
            begin
               dataout_min <= mldata;
               mldata <= mdata;
               clkenout <= 1'b1;
               c <= 32'b00000000000000000000000000000000;
            end
         end
   end
   
endmodule
