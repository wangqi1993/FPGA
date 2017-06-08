`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:33:31 03/13/2017 
// Design Name: 
// Module Name:    pulsewidth 
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
module pulsewidth(
cnt_clk,
cnt_clr,
trigin,
func_sel,
cmp_low,
cmp_high,
pul_trig_status
);
input cnt_clk;
input cnt_clr;
input trigin;
input [1:0] func_sel;
input [31:0] cmp_low;
input [31:0] cmp_high;
output pul_trig_status;
reg pul_trig_status;

reg trigin_dly1,trigin_dly2,trigin_dly3;
always @(posedge cnt_clk or negedge cnt_clr)
begin
   if(cnt_clr == 1'b0)
		begin
		trigin_dly1 <= 1'b0;
		trigin_dly2 <= 1'b0;
		trigin_dly3 <= 1'b0;
		end	   
	else
		begin
		trigin_dly1 <= trigin;
		trigin_dly2 <= trigin_dly1;
		trigin_dly3 <= trigin_dly2;
		end
end
wire auto_clr;
reg pulse;
always @(posedge cnt_clk or negedge cnt_clr)
begin
   if((cnt_clr == 1'b0) || (auto_clr == 1'b0) )
		begin
		     pulse <= 1'b0; 
		end	   
	else
		begin
       if((trigin_dly2 == 1'b1) && (trigin_dly3 == 1'b0)&&(auto_clr == 1'b1))
		     pulse <= 1'b1;
		 else if((trigin_dly2 == 1'b0) && (trigin_dly3 == 1'b1)&&(auto_clr == 1'b1))
		     pulse <= 1'b0;  
		 else
		     pulse <= pulse; 
		end
end

reg pulse_dly1;
always @(posedge cnt_clk or negedge cnt_clr)
begin
  if(cnt_clr == 1'b0)
    begin
     pulse_dly1 <= 1'b0;
    end
  else
    begin
    pulse_dly1 <= pulse;
    end  
end


reg cmp_enable;
always @(posedge cnt_clk or negedge cnt_clr)
begin
  if((cnt_clr == 1'b0) || (auto_clr == 1'b0))
    begin
    cmp_enable <= 1'b0;  
    end
  else
    begin
      if((pulse_dly1 == 1'b1) && (pulse == 1'b0))
         cmp_enable <= 1'b1;          
      else
         cmp_enable <= cmp_enable;         
    end
end


reg cmp_enable_dly1,cmp_enable_dly2;
always @(posedge cnt_clk)
begin
  cmp_enable_dly1 <= cmp_enable;
  cmp_enable_dly2 <= cmp_enable_dly1;
end

reg cmp_dly1,cmp_dly2,cmp_dly3,cmp_dly4,cmp_dly5;
always @(posedge cnt_clk or negedge cnt_clr)
begin
  if(cnt_clr == 1'b0)
    begin
      cmp_dly1 <= 1'b0;
      cmp_dly2 <= 1'b0;
      cmp_dly3 <= 1'b0;
      cmp_dly4 <= 1'b0;	
      cmp_dly5 <= 1'b0;	      
    end
  else
    begin
      cmp_dly1 <= cmp_enable_dly2;
      cmp_dly2 <= cmp_dly1;
      cmp_dly3 <= cmp_dly2;
      cmp_dly4 <= cmp_dly3;	
      cmp_dly5 <= cmp_dly4;	
    end
end
assign auto_clr = ~cmp_dly5;

wire cnt_enable;
assign cnt_enable = pulse;

reg [31:0] data_cnt;
always@(posedge cnt_clk or negedge cnt_clr)
 begin
      if((cnt_clr == 1'b0) || (auto_clr == 1'b0))
         data_cnt <= 32'b0;
      else
        begin		
		   if(cnt_enable == 1'b1)
          begin
          data_cnt <= data_cnt + 32'b1;
          end
			else
			 begin
			 data_cnt <= data_cnt;
			 end
		   end
 end

reg large_status;
always@(posedge cnt_clk)
 begin
      if(cmp_dly2 == 1'b0)
         large_status <= 1'b0;
      else if((cmp_dly4 == 1'b0) && (cmp_dly3 == 1'b1))
          begin
             if(data_cnt[31:0] > cmp_high[31:0])
                large_status <= 1'b1;
             else
                large_status <= 1'b0; 
          end
 end

reg small_status;
always@(posedge cnt_clk)
 begin
      if(cmp_dly2 == 1'b0)
         small_status <= 1'b0;
      else if((cmp_dly4 == 1'b0) && (cmp_dly3 == 1'b1))
          begin
             if(data_cnt[31:0] < cmp_low[31:0])
                small_status <= 1'b1;
             else
                small_status <= 1'b0; 
          end
 end

reg inside_status;
always@(posedge cnt_clk)
 begin
      if(cmp_dly2 == 1'b0)
         inside_status <= 1'b0;
      else if((cmp_dly4 == 1'b0) && (cmp_dly3 == 1'b1))
          begin
             if((data_cnt[31:0] > cmp_low[31:0]) && (data_cnt[31:0] < cmp_high[31:0]))
                inside_status <= 1'b1;
             else
                inside_status <= 1'b0; 
          end
 end

always @(posedge cnt_clk)
begin
  case(func_sel[1:0])
	 2'b00: pul_trig_status <= large_status;
	 2'b01: pul_trig_status <= small_status;	 
	 2'b10: pul_trig_status <= inside_status; 
	 default: pul_trig_status <= large_status; 
	 endcase
end

endmodule 
