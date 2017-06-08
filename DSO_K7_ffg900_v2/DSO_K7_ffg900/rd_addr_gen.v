`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:30 03/03/2017 
// Design Name: 
// Module Name:    rd_addr_gen 
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
module rd_addr_gen(
	input clk,
	input rst,///0 active reset
	input [3:0] DIMMdepth_ctrl,
	input rd_en,
	input [28:0] addr_init_rd,///有效为[27:0]
	input [27:0] num_rd,
	output reg [27:0] addr_rd_out,
	output reg syn_en_addr,
	output reg [26:0] cnt_num_rd,
	output reg	num_rd_r_o,
	(* equivalent_reg_removal = "no" *)
	output reg read_stop
	);

localparam BIT_CNT=27;

reg [BIT_CNT:0] num_rd_r;
reg cnt_clr;
reg [BIT_CNT-1:0] cnt_num;
reg cmp_result,cmp_result_reg;
(* equivalent_reg_removal = "no" *)
reg [BIT_CNT-1:0] byte_addr_rd_reg;
wire [27:0] byte_addr_rd_wire;
wire [27:0] addr_rd_out_r;
reg [3:0] DIMMdepth_ctrl_r;
always @(posedge clk) 
begin
  DIMMdepth_ctrl_r <= DIMMdepth_ctrl;
  num_rd_r <= num_rd;
  num_rd_r_o <= num_rd_r[0];
end

always @(posedge clk)
begin
	case(DIMMdepth_ctrl_r)
	4'b1111 : addr_rd_out[27:0] <= addr_rd_out_r[27:0];            ///2GB,256M,128M(bytes,addr,trigaddr)
	4'b1110 : addr_rd_out[27:0] <= {1'h0 ,addr_rd_out_r[26:0]};    ///1GB,128M,64M
	4'b1101 : addr_rd_out[27:0] <= {2'h0 ,addr_rd_out_r[25:0]};    ///512M,64M,32M
	4'b1100 : addr_rd_out[27:0] <= {3'h0 ,addr_rd_out_r[24:0]};    ///256M,32M,16M
	4'b1011 : addr_rd_out[27:0] <= {4'h0 ,addr_rd_out_r[23:0]};    ///128M,16M,8M
	4'b1010 : addr_rd_out[27:0] <= {5'h0 ,addr_rd_out_r[22:0]};    ///64M,8M,4M
	4'b1001 : addr_rd_out[27:0] <= {6'h0 ,addr_rd_out_r[21:0]};    ///32M,4M,2M
	4'b1000 : addr_rd_out[27:0] <= {7'h0 ,addr_rd_out_r[20:0]};    ///16M,2M,1M
	
	4'b0111 : addr_rd_out[27:0] <= {8'h0 ,addr_rd_out_r[19:0]};    ///8M,1M,512K
	4'b0110 : addr_rd_out[27:0] <= {9'h0 ,addr_rd_out_r[18:0]};    ///4M,512K,256K
	4'b0101 : addr_rd_out[27:0] <= {11'h0,addr_rd_out_r[16:0]};    ///1M,128K,64K
	4'b0100 : addr_rd_out[27:0] <= {12'h0,addr_rd_out_r[15:0]};    ///512KB,64K,32K
	4'b0011 : addr_rd_out[27:0] <= {14'h0,addr_rd_out_r[13:0]};    ///128KB,16K,8K
	4'b0010 : addr_rd_out[27:0] <= {16'h0,addr_rd_out_r[11:0]};    ///32KB,4K,2K
	4'b0001 : addr_rd_out[27:0] <= {18'h0,addr_rd_out_r[9:0]};     ///8KB,1K,512
	4'b0000 : addr_rd_out[27:0] <= {20'h0,addr_rd_out_r[7:0]};     ///2KB,256,128
   default:  addr_rd_out[27:0] <= {8'h0 ,addr_rd_out_r[19:0]};    ///8M,1M,512K
	endcase
end
assign byte_addr_rd_wire = {byte_addr_rd_reg,1'b0}+addr_init_rd;  /// unit 64bit 
assign addr_rd_out_r = {byte_addr_rd_wire[27:3],3'b000};///64bit*8

///每4个时钟周期产生一个同步使能，对应512bit的数据，DIMM的64bit*8，即8突发长度
always @ (posedge clk)
begin
	byte_addr_rd_reg[BIT_CNT-1:0] <= cnt_num[BIT_CNT-1:0];
end
always @(posedge clk) 
	begin
	 if(rst == 1'b0)
	  syn_en_addr <= 0;
	 else
	  begin
		if((byte_addr_rd_reg[2] ==0 && cnt_num[2]==1)||(byte_addr_rd_reg[2] ==1 && cnt_num[2]==0))
		 syn_en_addr <= 1;
		else
		 syn_en_addr <= 0;
		end
	end
///以下计数是以读命令使能为基础的，对应128bit数据，计数1024，共1024个128bit
always @ (posedge clk)
begin
	read_stop <= cnt_clr;
end
always @ (posedge clk)
begin
	if(rst == 1'b0)
		cnt_num[BIT_CNT-1:0] <= 27'h00000000;
	else
		begin
		if((rd_en == 1'b1)&&(cnt_clr == 1'b0))
			cnt_num[BIT_CNT-1:0] <= cnt_num[BIT_CNT-1:0]+1'b1;
		end
end

always @ (posedge clk)
begin
	if(rst == 1'b0)
		cmp_result <= 1'b0;
	else
		begin
		if(cnt_num[BIT_CNT-1:0] == num_rd_r[BIT_CNT:1])
			cmp_result <= 1'b1;
		else
			cmp_result <= 1'b0;
		end
end

always @ (posedge clk)
begin
	if(rst == 1'b0)
		cmp_result_reg<=1'b0;
	else
		cmp_result_reg <= cmp_result;
end

always @ (posedge clk)
begin
	if(rst == 1'b0)
		cnt_clr<=1'b0;
	else
		begin
		if((cmp_result_reg == 1'b0)&& (cmp_result==1'b1))
			cnt_clr<=1'b1;
		end
end

always @ (posedge clk)
begin
	if(rst == 1'b0)
		cnt_num_rd<=1'b0;
	else
	 cnt_num_rd <= cnt_num;
end

endmodule
