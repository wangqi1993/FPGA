`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:52:44 03/14/2017 
// Design Name: 
// Module Name:    freq_measure 
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
module freq_measure(
    cnt_clr,
	 trigin,
	 rx_clk,
	 ref_clk_20M,
	 cnt_gap_sel,
	 status,
	 cnt_num
   );
input cnt_clr;
input trigin;
input rx_clk;
input ref_clk_20M;
input cnt_gap_sel;
output status;
output [31:0] cnt_num;
reg [15:0] ss;
reg [31:0] jj;

always @(posedge ref_clk_20M or negedge cnt_clr)
begin
    if(cnt_clr == 1'b0)
	   ss <= 16'h0;
	 else 
	     if(ss < 16'd499) 
	      ss <= ss +16'h1;
		  else 
		   ss <= 16'd0;
end
reg clk_20k;
always @(posedge ref_clk_20M or negedge cnt_clr)
begin
    if(cnt_clr == 1'b0)
     clk_20k <= 1'b0;
	 else if(ss == 16'd499)
	  clk_20k <= ~clk_20k;
end

always @(posedge ref_clk_20M or negedge cnt_clr)
begin
    if(cnt_clr == 1'b0)
	   jj <= 32'h0;
	 else if(jj < 32'd499999) 
	         jj <= jj + 32'h1;
		   else
            jj <= 32'h0;		
end	
	
reg clk_20Hz;
always @(posedge ref_clk_20M or negedge cnt_clr)
begin
    if(cnt_clr == 1'b0)
     clk_20Hz <= 1'b0;
	 else if(jj == 32'd499999)
	  clk_20Hz <= ~clk_20Hz;
end	

wire cnt_clk;
assign cnt_clk = cnt_gap_sel ? clk_20k : clk_20Hz;

reg cnt_clk_dly1,cnt_clk_dly2,cnt_clk_dly3;

always @(posedge rx_clk)
begin
    cnt_clk_dly1  <= cnt_clk;
	 cnt_clk_dly2  <= cnt_clk_dly1; 
	 cnt_clk_dly3  <= cnt_clk_dly2; 	 	 
end 


reg cnt_en;
reg first;
reg status;
always @(posedge rx_clk or negedge cnt_clr)
begin
    if(cnt_clr == 1'b0)
	    begin
		   cnt_en <= 1'b0;
			 first  <= 1'b1;
			 status <= 1'b0;
		 end
	 else if(cnt_clk_dly3 == 1'b0 && cnt_clk_dly2 == 1'b1 && first == 1'b1) 
	    begin
	    cnt_en <= 1'b1; 
		 first  <= 1'b0;
		 status <= 1'b0;
	    end
	 else if(cnt_clk_dly3 == 1'b0 && cnt_clk_dly2 == 1'b1 && first == 1'b0)
	    begin
		 cnt_en <= 1'b0;
		 first  <= 1'b0;
		 status <= 1'b1;
		 end
end	

reg [31:0] cnt_num;
always @(posedge trigin or negedge cnt_clr)
begin
     if(cnt_clr == 1'b0)
	    begin
		    cnt_num <= 32'h0;
		 end
	  else 
	    if(cnt_en == 1'b1)
	     begin
		    cnt_num <= cnt_num + 32'h1;
		  end
		 else
		  begin
		    cnt_num <= cnt_num;
		  end 
end

endmodule


