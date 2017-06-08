`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:57:55 02/24/2017 
// Design Name: 
// Module Name:    scan 
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
module scan(
  scan_rst,
  rxclk,
  rxdata,
  div_n_maxmin,
  rden_scan,
  scan_dout,
  scan_over,
  scan_stop
  );
input scan_rst;
input rxclk;
input [127:0] rxdata;
input [31:0] div_n_maxmin;

input rden_scan;

output scan_over;
output scan_stop;
reg scan_stop;

output [15:0] scan_dout;
reg    [15:0] scan_dout;  

reg rden_scan_dly1,rden_scan_dly2;

wire [7:0] CHD_max; 
wire [7:0] CHD_min; 
wire [7:0] CHC_max; 
wire [7:0] CHC_min; 
wire [7:0] CHB_max; 
wire [7:0] CHB_min; 
wire [7:0] CHA_max; 
wire [7:0] CHA_min;  
wire [63:0] scan_dout_fifo;
reg fifo_rd_en;

wire scan_over;
wire fifo_empty;
assign scan_over = ~fifo_empty;

maxmin_detect	maxmin_detect_inst1(
	.clk(rxclk),
	.data(rxdata),
	.n(div_n_maxmin),
	.enout(enout),
	.s20max(CHD_max[7:0]),
	.s20min(CHD_min[7:0]),
	.s21max(CHC_max[7:0]),
	.s21min(CHC_min[7:0]),
	.s22max(CHB_max[7:0]),
	.s22min(CHB_min[7:0]),
	.s23max(CHA_max[7:0]),
	.s23min(CHA_min[7:0]));

fifo_scan fifo_scan_inst0 (
  .clk(rxclk),    // input clk
  .rst(~scan_rst), // input rst
  .din({CHD_max[7:0],CHD_min[7:0],
        CHC_max[7:0],CHC_min[7:0],
		  CHB_max[7:0],CHB_min[7:0],
		  CHA_max[7:0],CHA_min[7:0]}), // input [63 : 0] din
  .wr_en(enout & (~scan_stop)),      // input wr_en
  .rd_en(fifo_rd_en),                // input rd_en
  .prog_empty_thresh(10'h010), // input [9 : 0] prog_empty_thresh
  .prog_full_thresh(10'h3a0),  // input [9 : 0] prog_full_thresh
  .dout(scan_dout_fifo[63:0]), // output [63 : 0] dout
  .full(), // output full
  .empty(fifo_empty), // output empty
  .prog_full(), // output prog_full
  .prog_empty() // output prog_empty
);

reg [31:0] ss;
always @(posedge rxclk or negedge scan_rst)
begin
    if(scan_rst == 1'b0)
	  begin
      ss <= 1'b0;	 
	  end
	 else
	  begin
	    if((ss < 32'd521) && (enout == 1'b1))
        ss <= ss + 32'h1;
       else
	     ss <= ss;
	  end
end

always @(posedge rxclk or negedge scan_rst)
begin
    if(scan_rst == 1'b0)
      scan_stop <= 1'b0;		 
	 else
      if(ss >= 32'd520)
			  scan_stop <= 1'b1; 
		else 
		     scan_stop <= 1'b0; 
end

always @(posedge rxclk or negedge scan_rst)
begin
    if(scan_rst == 1'b0)
	 begin
    rden_scan_dly1 <= 1'b0;
    rden_scan_dly2 <= 1'b0;	 
	 end
	 else
	 begin
    rden_scan_dly1 <= rden_scan;
    rden_scan_dly2 <= rden_scan_dly1;
    end
end

localparam SCAN_IDLE        = 6'b000001;
localparam SCAN_READ        = 6'b000010;
localparam SCAN_FIRST       = 6'b000100;
localparam SCAN_SECOND      = 6'b001000;
localparam SCAN_THIRD       = 6'b010000;
localparam SCAN_FOURTH      = 6'b100000;


reg [5:0] CS_STATE;
reg [5:0] NEXT_STATE;

always @(posedge rxclk or negedge scan_rst)
begin
    if(scan_rst == 1'b0)
	    CS_STATE <= SCAN_IDLE;
	 else
	    CS_STATE <= NEXT_STATE;
end

always @(rden_scan_dly1 or rden_scan_dly2)
begin
  case(CS_STATE)
  SCAN_IDLE:
    begin  
     if((rden_scan_dly2 == 1'b0)&&(rden_scan_dly1 == 1'b1))
	    NEXT_STATE = SCAN_READ;
	  else
	    NEXT_STATE = SCAN_IDLE;	    
    end
  SCAN_READ:
  
	    NEXT_STATE = SCAN_FIRST;
		 
  SCAN_FIRST:
    begin  
	  if((rden_scan_dly2 == 1'b0)&&(rden_scan_dly1 == 1'b1))
	    NEXT_STATE = SCAN_SECOND;   
     else 
	    NEXT_STATE = SCAN_FIRST;
	 end  
  SCAN_SECOND:
    begin  
     if((rden_scan_dly2 == 1'b0)&&(rden_scan_dly1 == 1'b1))
	    NEXT_STATE = SCAN_THIRD;
	  else
	    NEXT_STATE = SCAN_SECOND;	    
    end    
  SCAN_THIRD:
    begin  
     if((rden_scan_dly2 == 1'b0)&&(rden_scan_dly1 == 1'b1))
	    NEXT_STATE = SCAN_FOURTH;
	  else
	    NEXT_STATE = SCAN_THIRD;	    
    end   
  SCAN_FOURTH:
    begin  
     if((rden_scan_dly2 == 1'b0)&&(rden_scan_dly1 == 1'b1))
	    NEXT_STATE = SCAN_READ;
	  else
	    NEXT_STATE = SCAN_FOURTH;	    
    end    
  default:
    begin
	    NEXT_STATE = SCAN_IDLE;		 
	 end
  endcase
end

always @(posedge rxclk or negedge scan_rst)
begin
     if(scan_rst == 1'b0)
	     begin
		  scan_dout <= 16'h0000;
        fifo_rd_en <= 1'b0;
		  end
	  else
	     begin
		  case(NEXT_STATE)
		  SCAN_IDLE:
		     begin
			  scan_dout <= 16'h0000;	
           fifo_rd_en <= 1'b0;			  
			  end
		  SCAN_READ:
		     begin
			  scan_dout  <= 16'h0000;
           fifo_rd_en <= 1'b1;			  
			  end
		  SCAN_FIRST:
		     begin
			  scan_dout  <= scan_dout_fifo[15+48:0+48];
           fifo_rd_en <= 1'b0;			  
			  end
		  SCAN_SECOND:
		     begin
			  scan_dout <= scan_dout_fifo[15+32:0+32];	
           fifo_rd_en <= 1'b0;				  
			  end
		  SCAN_THIRD:
		     begin
			  scan_dout <= scan_dout_fifo[15+16:0+16];
           fifo_rd_en <= 1'b0;				  
			  end
		  SCAN_FOURTH:
		     begin
			  scan_dout <= scan_dout_fifo[15:0];
           fifo_rd_en <= 1'b0;				  
			  end			  
		  default:
		     begin
			  scan_dout <= 16'h0000;	
           fifo_rd_en <= 1'b0;			  
			  end				  
		  endcase
		  end
end

endmodule 
