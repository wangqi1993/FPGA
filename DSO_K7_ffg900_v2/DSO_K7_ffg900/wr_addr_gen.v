`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:26 03/03/2017 
// Design Name: 
// Module Name:    wr_addr_gen 
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
module wr_addr_gen(
	input clk                          ,//数据随路时钟
	input rst                          ,//复位，0有效
	input [3:0] DIMMdepth_ctrl         ,//存储深度控制
	input wr_en                        ,//write address计数使能 ，ddr状态机产生
	input sync_en                      ,//数据的同步使能
	input auto_rd_en                   ,//边读边写状态的读使能，用来产生触发
	(* equivalent_reg_removal = "no" *)
	
	output reg [3:0] wr_state_out      ,

	output reg [27:0] addr_wr_out      ,///写地址输出,共28位，
	//(* equivalent_reg_removal = "no" *)
	output syn_en_addr_wr              ,///写地址的同步使能输出
	output reg write_stop              ,///写过程停止信号
	output reg [26:0] addr_trig         ///触发地址
	);

localparam START       = 4'b0001;
localparam PRE_TRIG    = 4'b0010;
localparam WAIT_TRIG   = 4'b0100;//READY
localparam POS_TRIG    = 4'b1000;
(* FSM_ENCODING="ONE-HOT", SAFE_IMPLEMENTATION="NO" *) 
reg [3:0] state;
wire [27:0] cnt_addr_cycle;
wire [27:0] cnt_out_wait;
reg cnt_addr_clr,
		cnt_en_addr,
		rst_cnt_wait,
		cnt_en_wait;
(* equivalent_reg_removal = "no" *)
reg [27:0] addr_wr_out_r;
reg cnt_equal_reg1,cnt_equal_reg2;
reg cnt_stop;
(* equivalent_reg_removal = "no" *)
reg syn_en_addr;
reg [26:0] addr_trigged;
reg [3:0] DIMMdepth_ctrl_r1,DIMMdepth_ctrl_r2,DIMMdepth_ctrl_r3;




always @(posedge clk) 
begin
	wr_state_out <= state;
end



always @(posedge clk) 
begin
  DIMMdepth_ctrl_r1 <=DIMMdepth_ctrl;
  DIMMdepth_ctrl_r2 <=DIMMdepth_ctrl;
  DIMMdepth_ctrl_r3 <=DIMMdepth_ctrl;
end

///触发地址输出控制
always @(posedge clk) 
begin
	case(DIMMdepth_ctrl_r3)
	4'b1111 : addr_trig[26:0] <= addr_trigged[26:0];            ///2GB,256M,128M(bytes,addr,trigaddr)
	4'b1110 : addr_trig[26:0] <= {1'h0,addr_trigged[25:0]};     ///1GB,128M,64M
	4'b1101 : addr_trig[26:0] <= {2'h0,addr_trigged[24:0]};    	///512M,64M,32M
	4'b1100 : addr_trig[26:0] <= {3'h0,addr_trigged[23:0]};   	///256M,32M,16M
	4'b1011 : addr_trig[26:0] <= {4'h0,addr_trigged[22:0]}; 		///128M,16M,8M
	4'b1010 : addr_trig[26:0] <= {5'h0,addr_trigged[21:0]};		///64M,8M,4M
	4'b1001 : addr_trig[26:0] <= {6'h0,addr_trigged[20:0]};   	///32M,4M,2M
	4'b1000 : addr_trig[26:0] <= {7'h0,addr_trigged[19:0]};   	///16M,2M,1M
	
	4'b0111 : addr_trig[26:0] <= {8'h0,addr_trigged[18:0]};     ///8M,1M,512K
	4'b0110 : addr_trig[26:0] <= {9'h0,addr_trigged[17:0]};     ///4M,512K,256K
	4'b0101 : addr_trig[26:0] <= {11'h0,addr_trigged[15:0]};    ///1M,128K,64K
	4'b0100 : addr_trig[26:0] <= {12'h0,addr_trigged[14:0]};    ///512KB,64K,32K
	4'b0011 : addr_trig[26:0] <= {14'h0,addr_trigged[12:0]};    ///128KB,16K,8K
	4'b0010 : addr_trig[26:0] <= {16'h0,addr_trigged[10:0]};    ///32KB,4K,2K
	4'b0001 : addr_trig[26:0] <= {18'h0,addr_trigged[8:0]};     ///8KB,1K,512
	4'b0000 : addr_trig[26:0] <= {20'h0,addr_trigged[6:0]};     ///2KB,256,128
	
	default:  addr_trig[26:0]  <= {8'h0,addr_trigged[18:0]};    ///8M,1M,512K
	endcase
end


///DIMM写地址与写使能的输出控制
always @(posedge clk) 
begin
	case(DIMMdepth_ctrl_r3)
	4'b1111 : addr_wr_out[27:0] <= addr_wr_out_r[27:0];            ///2GB,256M,128M(bytes,addr,trigaddr)
	4'b1110 : addr_wr_out[27:0] <= {1'h0 ,addr_wr_out_r[26:0]};    ///1GB,128M,64M
	4'b1101 : addr_wr_out[27:0] <= {2'h0 ,addr_wr_out_r[25:0]};    ///512M,64M,32M
	4'b1100 : addr_wr_out[27:0] <= {3'h0 ,addr_wr_out_r[24:0]};    ///256M,32M,16M
	4'b1011 : addr_wr_out[27:0] <= {4'h0 ,addr_wr_out_r[23:0]};    ///128M,16M,8M
	4'b1010 : addr_wr_out[27:0] <= {5'h0 ,addr_wr_out_r[22:0]};    ///64M,8M,4M
	4'b1001 : addr_wr_out[27:0] <= {6'h0 ,addr_wr_out_r[21:0]};    ///32M,4M,2M
	4'b1000 : addr_wr_out[27:0] <= {7'h0 ,addr_wr_out_r[20:0]};    ///16M,2M,1M
	
	4'b0111 : addr_wr_out[27:0] <= {8'h0 ,addr_wr_out_r[19:0]};    ///8M,1M,512K
	4'b0110 : addr_wr_out[27:0] <= {9'h0 ,addr_wr_out_r[18:0]};    ///4M,512K,256K
	4'b0101 : addr_wr_out[27:0] <= {11'h0,addr_wr_out_r[16:0]};    ///1M,128K,64K
	4'b0100 : addr_wr_out[27:0] <= {12'h0,addr_wr_out_r[15:0]};    ///512KB,64K,32K
	4'b0011 : addr_wr_out[27:0] <= {14'h0,addr_wr_out_r[13:0]};    ///128KB,16K,8K
	4'b0010 : addr_wr_out[27:0] <= {16'h0,addr_wr_out_r[11:0]};    ///32KB,4K,2K
	4'b0001 : addr_wr_out[27:0] <= {18'h0,addr_wr_out_r[9:0]};     ///8KB,1K,512
	4'b0000 : addr_wr_out[27:0] <= {20'h0,addr_wr_out_r[7:0]};     ///2KB,256,128
	
	default:  addr_wr_out[27:0]  <= {8'h0,addr_wr_out_r[19:0]};    ///8M,1M,512K
	endcase
end

always @(posedge clk) 
	begin 
		addr_wr_out_r <= {cnt_addr_cycle[26:2],3'b000}; //此产生的地址将要送往MIG，ddr物理接口的为64bit，突发长度为8
		                                                //该地址对应的位宽为64bit，突发长度为8，则为64bit*8=512bit
		                                                //adc一个时钟节拍产生128bit数据，则需要过4个时钟4*128bit=512bit，即4个时钟，ddr的地址加8
	end
	
assign syn_en_addr_wr = syn_en_addr;

always @(posedge clk) 
	begin
	 if(rst == 1'b0)
	  syn_en_addr <= 0;
	 else
	  begin
		if((addr_wr_out_r[3] ==0 && cnt_addr_cycle[2]==1)||(addr_wr_out_r[3] ==1 && cnt_addr_cycle[2]==0))
		 syn_en_addr <= 1;
		else
		 syn_en_addr <= 0;
		end
	end

counter_n_bit 
#(.cnt_width(28)
 ) cnt_addr_cycle_inst
 (
	.rst(cnt_addr_clr),
	.clk_in(clk),
	.cnt_en(cnt_en_addr),
	.cnt_out(cnt_addr_cycle)//28bit,including 27bit out for 32M*4*128bit,but must add 1 MSB for comparing to genrate stop signal
	);

counter_n_bit 
#(.cnt_width(28)
 ) cnt_wait_trig
 (
	.rst(rst_cnt_wait),
	.clk_in(clk),
	.cnt_en(cnt_en_wait),
	.cnt_out(cnt_out_wait)
	);

always @(posedge clk) 
	begin
	if(rst == 1'b0)
		begin
		cnt_addr_clr <= 1'b0;
		cnt_en_addr <= 1'b0;
		state <= START;
		rst_cnt_wait <= 1'b0;
		cnt_en_wait <= 1'b0;
		write_stop <= 1'b0;
		addr_trigged <= 27'h00000;
		end
	else
		begin
		cnt_addr_clr <= 1'b1;
		rst_cnt_wait <= 1'b1;
		//(* FULL_CASE, PARALLEL_CASE *)
		case(state)
			START:begin
						cnt_en_addr <= 0;
						cnt_en_wait <= 0;
						if(wr_en == 1'b1)
							begin
							state <= PRE_TRIG;
							end
						else
							begin
							state <= START;
							end
						end
			PRE_TRIG:begin
						cnt_en_addr <= sync_en; //addr counter enable 
						if(auto_rd_en == 1'b1)
							begin
							cnt_en_wait <= 0;
							state <= WAIT_TRIG;
							end
						else
							begin
							cnt_en_wait <= 0;
							state <= PRE_TRIG;
							end
						end
			WAIT_TRIG:begin
						cnt_en_addr <= sync_en; 
						if(auto_rd_en == 1'b1)
							begin
							cnt_en_wait <= sync_en; //wait counter enable 
							state <= WAIT_TRIG;
							end
						else
							begin
							cnt_en_wait <= 1'b0;
							state <= POS_TRIG;
							addr_trigged <= cnt_addr_cycle[26:0];
							end
						end
			POS_TRIG:begin
						cnt_en_wait <= 1'b0;
						if(cnt_stop==1)
							begin
							cnt_en_addr <= 1'b0;
							write_stop <= 1'b1;
							state <= START;
							end
						else
							begin
							cnt_en_addr <= sync_en;
							state <= POS_TRIG;
							end
						end
			default:begin
						state <= START;
						cnt_en_addr <= 0;
						cnt_en_wait <= 0;
						end
		endcase
		end
	end

always @(posedge clk)
begin
   case(DIMMdepth_ctrl_r3)
	4'b1111 : cnt_equal_reg1 <= (cnt_addr_cycle[26:0] == cnt_out_wait[26:0])&&(cnt_addr_cycle[27]   != cnt_out_wait[27]);          ///2GB,256M,128M(bytes,addr,trigaddr)
	4'b1110 : cnt_equal_reg1 <= (cnt_addr_cycle[25:0] == cnt_out_wait[25:0])&&(cnt_addr_cycle[26]   != cnt_out_wait[26]);          ///1GB,128M,64M	 
	4'b1101 : cnt_equal_reg1 <= (cnt_addr_cycle[24:0] == cnt_out_wait[24:0])&&(cnt_addr_cycle[25]   != cnt_out_wait[25]);          ///512M,64M,32M
	4'b1100 : cnt_equal_reg1 <= (cnt_addr_cycle[23:0] == cnt_out_wait[23:0])&&(cnt_addr_cycle[24]   != cnt_out_wait[24]);          ///256M,32M,16M	 
	4'b1011 : cnt_equal_reg1 <= (cnt_addr_cycle[22:0] == cnt_out_wait[22:0])&&(cnt_addr_cycle[23]   != cnt_out_wait[23]);          ///128M,16M,8M
	4'b1010 : cnt_equal_reg1 <= (cnt_addr_cycle[21:0] == cnt_out_wait[21:0])&&(cnt_addr_cycle[22]   != cnt_out_wait[22]);          ///64M,8M,4M
	4'b1001 : cnt_equal_reg1 <= (cnt_addr_cycle[20:0] == cnt_out_wait[20:0])&&(cnt_addr_cycle[21]   != cnt_out_wait[21]);        	 ///32M,4M,2M
	4'b1000 : cnt_equal_reg1 <= (cnt_addr_cycle[19:0] == cnt_out_wait[19:0])&&(cnt_addr_cycle[20]   != cnt_out_wait[20]);          ///16M,2M,1M
	4'b0111 : cnt_equal_reg1 <= (cnt_addr_cycle[18:0] == cnt_out_wait[18:0])&&(cnt_addr_cycle[19]   != cnt_out_wait[19]);          ///8M,1M,512K
	4'b0110 : cnt_equal_reg1 <= (cnt_addr_cycle[17:0] == cnt_out_wait[17:0])&&(cnt_addr_cycle[18]   != cnt_out_wait[18]);          ///4M,512K,256K
	4'b0101 : cnt_equal_reg1 <= (cnt_addr_cycle[15:0] == cnt_out_wait[15:0])&&(cnt_addr_cycle[16]   != cnt_out_wait[16]);          ///1M,128K,64K
	4'b0100 : cnt_equal_reg1 <= (cnt_addr_cycle[14:0] == cnt_out_wait[14:0])&&(cnt_addr_cycle[15]   != cnt_out_wait[15]);          ///512KB,64K,32K
	4'b0011 : cnt_equal_reg1 <= (cnt_addr_cycle[12:0] == cnt_out_wait[12:0])&&(cnt_addr_cycle[13]   != cnt_out_wait[13]);          ///128KB,16K,8K
	4'b0010 : cnt_equal_reg1 <= (cnt_addr_cycle[10:0] == cnt_out_wait[10:0])&&(cnt_addr_cycle[11]   != cnt_out_wait[11]);          ///32KB,4K,2K
	4'b0001 : cnt_equal_reg1 <= (cnt_addr_cycle[8:0]  == cnt_out_wait[8:0]) &&(cnt_addr_cycle[9]    != cnt_out_wait[9]);           ///8KB,1K,512
	4'b0000 : cnt_equal_reg1 <= (cnt_addr_cycle[6:0]  == cnt_out_wait[6:0]) &&(cnt_addr_cycle[7]    != cnt_out_wait[7]);           ///2KB,256,128
	default : cnt_equal_reg1 <= (cnt_addr_cycle[18:0] == cnt_out_wait[18:0])&&(cnt_addr_cycle[19]   != cnt_out_wait[19]);          ///8M,1M,512K
   endcase 
end

always @(posedge clk) 
	begin
	cnt_equal_reg2<=cnt_equal_reg1;
	end

always @(posedge clk) 
	begin
	if(rst == 1'b0)
		begin
			cnt_stop<=0;
		end
	else	if(cnt_equal_reg1==1&&cnt_equal_reg2==0)
	begin
			cnt_stop <= 1;
	end
	else
	begin
			cnt_stop <= 0;
	end
end

endmodule

