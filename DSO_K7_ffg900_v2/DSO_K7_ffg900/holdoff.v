`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:19:17 03/13/2017 
// Design Name: 
// Module Name:    holdoff 
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
module holdoff(
  clk_200M,
  trig_holdoff_reload,
  trig_holdoff_time,
  trig_aft_pul,
  trig_holdoff_status
);
input clk_200M;
input trig_holdoff_reload;
input [47:0] trig_holdoff_time;
input trig_aft_pul;
output trig_holdoff_status;
reg trig_holdoff_status;

reg trig_holdoff_reload_reg1,trig_holdoff_reload_reg2,trig_holdoff_reload_reg3;
always @(posedge clk_200M)
begin
     trig_holdoff_reload_reg1 <= trig_holdoff_reload;
     trig_holdoff_reload_reg2 <= trig_holdoff_reload_reg1;
     trig_holdoff_reload_reg3 <= trig_holdoff_reload_reg2;
end

reg trig_aft_pul_reg1,trig_aft_pul_reg2,trig_aft_pul_reg3;
always @(posedge clk_200M)
begin
     trig_aft_pul_reg1 <= trig_aft_pul;
     trig_aft_pul_reg2 <= trig_aft_pul_reg1;
     trig_aft_pul_reg3 <= trig_aft_pul_reg2;
end

reg holdoff_enable;
reg [47:0] holdoff_cnt;
always @(posedge clk_200M or negedge trig_holdoff_reload_reg2)
begin
   if(trig_holdoff_reload_reg2 == 1'b0)
	  begin
		  holdoff_enable <= 1'b1;
		  holdoff_cnt[47:0] <= trig_holdoff_time[47:0];
		  trig_holdoff_status <= 1'b0;
	  end
	else if((trig_aft_pul_reg3 == 1'b0)&&(trig_aft_pul_reg2 == 1'b1)&&(holdoff_cnt[47:0] == trig_holdoff_time[47:0]))
		     begin
			  holdoff_enable    <= 1'b0;
	        holdoff_cnt[47:0] <= 48'h0;
			  trig_holdoff_status    <= 1'b1;
			  end
	else if(holdoff_enable == 1'b0) //start to repress trig signal 
	  begin
	        if(holdoff_cnt[47:0] < trig_holdoff_time[47:0])
			    begin
	          holdoff_cnt[47:0] <= holdoff_cnt[47:0]+48'h1;
             holdoff_enable    <= 1'b0; //hold repress
			    trig_holdoff_status    <= 1'b0;				 
			    end
			  else
			    begin
	          holdoff_cnt[47:0] <= holdoff_cnt[47:0];	
             holdoff_enable    <= 1'b1; //stop repress
			    trig_holdoff_status    <= 1'b0;					 
			    end
	  end
	else 
	  begin   
	        holdoff_cnt[47:0]      <= holdoff_cnt[47:0];
	        holdoff_enable         <= 1'b1;		 
			  trig_holdoff_status    <= 1'b0;  
	  end
end

endmodule

