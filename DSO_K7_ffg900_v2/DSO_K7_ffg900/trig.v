`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:19:40 03/13/2017 
// Design Name: 
// Module Name:    trig 
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
module trig(
clk,
en_data,
wr_en,
cnt_clr,
pre_num,

clk_1k,
auto_normal_ctrl,

trigin,

auto_rd_en,
trigged
);
input clk;
input en_data;
input wr_en;
input cnt_clr;
input [31:0] pre_num;
input trigin;

input clk_1k;
input auto_normal_ctrl;

output auto_rd_en;
output trigged;

reg [31:0] ss; 
reg prefinished; 

reg [7:0] ee;
reg cnt_over;
reg auto_rd_en;
reg cnt_over_status;
reg trig_status;
reg trigged;

reg cnt_over_dly1,cnt_over_dly2;
reg trigin_dly1,trigin_dly2;
reg auto_normal_ctrl_dly1,auto_normal_ctrl_dly2;

//Ô¤´¥·¢
always @(posedge clk or negedge cnt_clr)
begin
  if(cnt_clr == 1'b0) //clr
    begin
      prefinished <= 1'b0;
      ss <= 32'h0;
    end
  else
    begin
      if((en_data == 1'b1) && (wr_en == 1'b1)) //data valid
       begin
         if(ss < pre_num) 
          begin
            ss <= ss +1;
            prefinished <= 1'b0;
          end
         else
          begin
            ss <= ss;  
            prefinished <= 1'b1;
          end            
       end
      else if(en_data == 1'b0)//data unable
        begin
          ss <= ss;
          prefinished <= prefinished; 
        end
    end
end 


always @(posedge clk_1k or negedge cnt_clr)
begin
   if(cnt_clr == 1'b0)
    begin 
     cnt_over <= 1'b0;
     ee <= 8'h0;
    end 
   else 
    begin
     if(prefinished == 1'b1)
     begin 
         if(ee < 8'd25) 
          begin
            ee <= ee + 1;
            cnt_over <= 1'b0;
          end
         else
          begin
            ee <= ee;  
            cnt_over <= 1'b1;
          end  
     end 
     else
     begin
            ee <= 8'h0;  
            cnt_over <= 1'b0;    
     end
    end
end



always @(posedge clk)
begin
   cnt_over_dly1 <= cnt_over;
   cnt_over_dly2 <= cnt_over_dly1;
   trigin_dly1 <= trigin;
   trigin_dly2 <= trigin_dly1;
   auto_normal_ctrl_dly1 <= auto_normal_ctrl;
   auto_normal_ctrl_dly2 <= auto_normal_ctrl_dly1; 
end

always @(posedge clk or negedge cnt_clr)
begin
   if(cnt_clr == 1'b0)
    cnt_over_status <= 1'b0; 
   else 
     if((cnt_over_dly2 == 1'b0)&&(cnt_over_dly1 == 1'b1)&&(prefinished == 1'b1))
        cnt_over_status <= 1'b1; 
    else 
        cnt_over_status <= cnt_over_status;
end 



always @(posedge clk or negedge cnt_clr)
begin
   if(cnt_clr == 1'b0)
    trig_status <= 1'b0; 
   else 
     if((trigin_dly2 == 1'b0)&&(trigin_dly1 == 1'b1)&&(prefinished == 1'b1))
        trig_status <= 1'b1; 
    else 
        trig_status <= trig_status;
end 


always @(posedge clk or negedge cnt_clr)
begin
   if(cnt_clr == 1'b0)
	  begin
   	auto_rd_en <= 1'b0;
      trigged    <= 1'b0;		
     end
	else
    if(prefinished == 1'b1)
      begin
       if(trig_status == 1'b1)
         begin
          auto_rd_en <= 1'b0;  
          trigged    <= 1'b1;	
         end
       else if((cnt_over_status == 1'b1)&&(auto_normal_ctrl_dly2 == 1'b1))
         begin
          auto_rd_en <= 1'b0;  
          trigged    <= trigged;	
         end
       else
          begin		 
          auto_rd_en <= 1'b1;     
			 trigged    <= trigged;	
			 end
      end   
    else 
	   begin
      auto_rd_en <= 1'b0;       
      trigged    <= trigged;	
		end
end 

endmodule 


