`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:54 03/10/2017 
// Design Name: 
// Module Name:    TRIG_System 
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
module TRIG_System(
      input Signal_Trig_test,

      input trig_ch1,
	   input trig_ch2,
	   input trig_ch3,
		input trig_ch4,
		input CH_TRIG_Q0,
		
		input  Trig_PXISTAR,
	   inout  [7:0] Trig_PXITRIG,

		input EXTERN_TRIG_AND_ARM_IN,
		output EXTERN_TRIG_OUT,
		input Trig_Video_CH1,
		input Trig_Video_CH2,
		input soft_trig,
		
		input [3:0] pattern_choose,
		
	   input [3:0] arm_sel,
		input arm_channel_sel,
		input arm_polar_sel,
		
		input [4:0] trig_sel,
		input trig_edge_sel,
		input [8:0] trig_out_sel,
	
		input pul_width_cnt_clr,	
		input [15:0] pul_func,	
		input [31:0] pul_cmp_low,
		input [31:0] pul_cmp_high,	 
      input pul_sel,
		
		input trig_holdoff_sel,
		input trig_holdoff_reload,
	   input [47:0] trig_holdoff_time,
		
		input rxclk,
		input wr_en,
		output auto_rd_en,
		output auto_rd_en_dly4,
		input clkin1M,
		input clkin20M,
		input clkin200M,
		input [31:0] pre_num,
		input auto_normal_ctrl,
		input en_data,
		input cnt_clr,
		output trigged,
		
		input freq_meas_clr,
		input freq_meas_gap_sel,
		output freq_meas_status,
		output [31:0] freq_meas_cnt_num,
		
		input TDC_en,
		//input [1:0] TDC_sel,
		output Widen_pluse,
		input Expanded_T,
		output [31:0] TDC_T_num
	 );


/*****************************************
**name:
**propose:码型触发
**        TURE 
**        FALSE 
**        DO NOT CARE 
**author:wangqi
**time:2017.04.27
*****************************************/
//码型状态检测,Bit3：PXI星型触发/Bit2：外部触发/Bit1：通道2/Bit0：通道1
reg [3:0] pattern_state;
always@(posedge rxclk)
begin
	pattern_state <= {Trig_PXISTAR,EXTERN_TRIG_AND_ARM_IN,trig_ch2,trig_ch1};
end

//码型状态对比
reg pattern_match;
always@(posedge rxclk)
begin
	if(pattern_state == pattern_choose)
		begin
		pattern_match <= 1'b1;
		end
   else
		begin
		pattern_match <= 1'b0;
		end
end


/*****************************************
**name:
**propose:ARM事件处理
**author:wangqi
**time:2017.03.11
*****************************************/
wire arm_none;//不管ARM事件
assign arm_none=1'b1;
reg arm_in,arm_in_dly1,arm_in_dly2,arm_in_dly3;
reg arm_trig_rise;//检测ARM触发
reg arm_trig_fall;
wire auto_rd_en;
reg auto_rd_en_dly1,auto_rd_en_dly2,auto_rd_en_dly3,auto_rd_en_dly4;
wire arm_trig_enable;
wire armed;

//外部ARM选择
always @ (posedge rxclk)
begin
	case(arm_sel)
    4'b0000: arm_in <= EXTERN_TRIG_AND_ARM_IN;
    4'b0001: arm_in <= Trig_PXISTAR;	 
    4'b0010: arm_in <= Trig_PXITRIG[0];
	 4'b0011: arm_in <= Trig_PXITRIG[1];
	 4'b0100: arm_in <= Trig_PXITRIG[2];
	 4'b0101: arm_in <= Trig_PXITRIG[3];
	 4'b0110: arm_in <= Trig_PXITRIG[4];
	 4'b0111: arm_in <= Trig_PXITRIG[5];
	 4'b1000: arm_in <= Trig_PXITRIG[6];
	 4'b1001: arm_in <= Trig_PXITRIG[7];
    4'b1010: arm_in <= soft_trig;
	default: arm_in <= EXTERN_TRIG_AND_ARM_IN;
	endcase
end
//ARM打拍
always @(posedge rxclk)
begin
     arm_in_dly1 <= arm_in;
     arm_in_dly2 <= arm_in_dly1;
     arm_in_dly3 <= arm_in_dly2;    	  
end

always @(posedge rxclk)
begin
     auto_rd_en_dly1 <= auto_rd_en;
     auto_rd_en_dly2 <= auto_rd_en_dly1;
     auto_rd_en_dly3 <= auto_rd_en_dly2;
     auto_rd_en_dly4 <= auto_rd_en_dly3;
	  
end

//检测ARM_event是否到来
always @(posedge rxclk)
begin
     if((arm_in_dly3 == 1'b0) &&(arm_in_dly2 == 1'b1))
			begin
				arm_trig_rise<=1'b1;
				arm_trig_fall<=arm_trig_fall;
			end
	  else if((arm_in_dly3 == 1'b1) &&(arm_in_dly2 == 1'b0))
		   begin
				arm_trig_rise<=arm_trig_rise;
				arm_trig_fall<=1'b1;			
			end
     else if((auto_rd_en_dly4 == 1'b1)&&(auto_rd_en_dly3 == 1'b0))
         begin
				arm_trig_rise <= 1'b0;
				arm_trig_fall <= 1'b0;
         end	
     else 
         begin
				arm_trig_rise <= arm_trig_rise;
				arm_trig_fall <= arm_trig_fall;         
			end			
end

assign arm_trig_enable = arm_polar_sel ? arm_trig_fall : arm_trig_rise;
assign armed = arm_channel_sel? arm_trig_enable : arm_none;


/*****************************************
**name:
**propose:触发in处理
**author:wangqi
**time:2017.03.11
*****************************************/
reg trig_rise;
wire trig_fall;
wire trig_in;
wire trig_in_ok;
//触发源选择--默认通道1上升沿
always @ (posedge rxclk)
begin
	case(trig_sel)
    5'b00000: trig_rise <= trig_ch1;//Signal_Trig_test;//测试-和测试数据配合用
    5'b00001: trig_rise <= trig_ch2;	 
    5'b00010: trig_rise <= trig_ch3;
    5'b00011: trig_rise <= trig_ch4;
    5'b00100: trig_rise <= Trig_PXISTAR;	
    5'b00101: trig_rise <= Trig_PXITRIG[0];	 
    5'b00110: trig_rise <= Trig_PXITRIG[1];	 
	 5'b00111: trig_rise <= Trig_PXITRIG[2];
	 5'b01000: trig_rise <= Trig_PXITRIG[3];
	 5'b01001: trig_rise <= Trig_PXITRIG[4];
	 5'b01010: trig_rise <= Trig_PXITRIG[5];
	 5'b01011: trig_rise <= Trig_PXITRIG[6];
	 5'b01100: trig_rise <= Trig_PXITRIG[7];
	 5'b01101: trig_rise <= EXTERN_TRIG_AND_ARM_IN;
	 5'b01110: trig_rise <= Trig_Video_CH1;
	 5'b01111: trig_rise <= Trig_Video_CH2;	
	 5'b10000: trig_rise <= soft_trig;
	 5'b10001: trig_rise <= CH_TRIG_Q0;//通道触发解串
	 5'b10010: trig_rise <= pattern_match;//码型触发
	default: trig_rise <= trig_ch1;
	endcase
end
//触发边沿选择
assign trig_fall = ~trig_rise; 
assign trig_in = trig_edge_sel ? trig_rise : trig_fall;
//触发信号ok
assign trig_in_ok = trig_in & armed;


/*****************************************
**name:freq_measure
**propose:触发频率（信号频率）测量,带宽1G
**author:wangqi
**time:2017.03.14
*****************************************/
freq_measure freq_measure_inst0 (
    .cnt_clr(freq_meas_clr), 
    .trigin(trig_in_ok), 
    .rx_clk(rxclk), 
    .ref_clk_20M(clkin20M), 
    .cnt_gap_sel(freq_meas_gap_sel), 
    .status(freq_meas_status), 
    .cnt_num(freq_meas_cnt_num)
    );


/*****************************************
**name:
**propose:等效采样
**author:wangqi
**time:2017.03.15
*****************************************/
TDC TDC_Inst(
	 .TDC_en(TDC_en),
	 //.TDC_sel(TDC_sel),
	 .Widen_pluse(Widen_pluse),
	 .Expanded_T(Expanded_T),
	 .TDC_T_num(TDC_T_num),
    
	 .trigin(trig_in_ok),
	 .rxclk(rxclk)
);


/*****************************************
**name:pulsewidth
**propose:脉宽触发处理
**author:wangqi
**time:2017.03.13
*****************************************/
wire pul_trig_status;
wire trig_aft_pul;

pulsewidth pulsewidth_inst(
.cnt_clk(clkin200M),
.cnt_clr(pul_width_cnt_clr),
.trigin(trig_in_ok),
.func_sel(pul_func[1:0]),
.cmp_low(pul_cmp_low[31:0]),
.cmp_high(pul_cmp_high[31:0]),
.pul_trig_status(pul_trig_status)
);

assign trig_aft_pul = pul_sel ? pul_trig_status : trig_in_ok ;


/*****************************************
**name:holdoff
**propose:触发释抑处理
**author:wangqi
**time:2017.03.13
*****************************************/
wire trig_holdoff_status;
//real_trig
wire real_trig;

holdoff holdoff_inst (
    .clk_200M(clkin200M), 
    .trig_holdoff_reload(trig_holdoff_reload), 
    .trig_holdoff_time(trig_holdoff_time[47:0]), 
    .trig_aft_pul(trig_aft_pul), 
    .trig_holdoff_status(trig_holdoff_status)
    );
	 
assign real_trig = trig_holdoff_sel ? trig_holdoff_status : trig_aft_pul;


/*****************************************
**name:trig
**propose:real触发处理,写ddr输出,触发信号灯输出
**author:wangqi
**time:2017.03.13
*****************************************/
wire clk_1k/* synthesis syn_keep = 1 */;
div1000 div1000_inst0(
    .clkin(clkin1M), 
    .cnt_clr(cnt_clr), 
    .clkout(clk_1k)
    );

trig trig_inst0(
    .clk(rxclk), 
    .en_data(en_data), 
    .wr_en(wr_en), 
    .cnt_clr(cnt_clr), 
    .pre_num(pre_num), 
    .clk_1k(clk_1k), 
    .auto_normal_ctrl(auto_normal_ctrl), 
    .trigin(real_trig), 
    .auto_rd_en(auto_rd_en),//out
	 .trigged(trigged)//out
    );


/*****************************************
**name:trig_out
**propose:触发输出处理
**author:wangqi
**time:2017.03.13
*****************************************/
wire trig_out;
assign trig_out = ~auto_rd_en;

assign	EXTERN_TRIG_OUT = trig_out_sel[0] ? trig_out : 1'bz;

assign	Trig_PXITRIG[0] = trig_out_sel[1] ? trig_out : 1'bz;
assign	Trig_PXITRIG[1] = trig_out_sel[2] ? trig_out : 1'bz;
assign	Trig_PXITRIG[2] = trig_out_sel[3] ? trig_out : 1'bz;
assign	Trig_PXITRIG[3] = trig_out_sel[4] ? trig_out : 1'bz;
assign	Trig_PXITRIG[4] = trig_out_sel[5] ? trig_out : 1'bz;
assign	Trig_PXITRIG[5] = trig_out_sel[6] ? trig_out : 1'bz;
assign	Trig_PXITRIG[6] = trig_out_sel[7] ? trig_out : 1'bz;
assign	Trig_PXITRIG[7] = trig_out_sel[8] ? trig_out : 1'bz;


endmodule
