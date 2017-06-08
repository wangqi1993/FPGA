`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:57:36 02/23/2017 
// Design Name: 
// Module Name:    Channel_Control 
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
module Channel_Control(
    	input clk_1M,
      input dac_cfg_addr_w_L,     
		input dac_cfg_addr_w_H,		 
		input dac_cfg_clr_addr_w,   
		input hc4094_cfg1_addr_w,     
		input hc4094_cfg1_clr_addr_w, 
		input hc4094_cfg2_addr_w,     
		input hc4094_cfg2_clr_addr_w, 
		input pe4302_cfg_addr_w,    
		input pe4302_cfg_clr_addr_w,
		inout [15:0] busdata,
		output ltc2600_cs,
		output ltc2600_din,
		output ltc2600_sclk,
		output hc4094_str1,
		output hc4094_str2,
		output hc4094_din,
		output hc4094_sclk,
		output pe3402_le1,
		output pe3402_le2,
		output pe4302_data,
		output pe4302_sclk
	 
	 );


/*****************************************
**name:Channel Contorl
**propose:完成LTC2600控制 
**author:wangqi
**time:2017.02.23
*****************************************/
//第一步加载数据32bits
wire [31:0] dac_cfg_data;

hc74374b hc74374b_Inst0(
	 .ONE(0),
	 .CLK(dac_cfg_addr_w_L),
	 .D(busdata[7:0]),
	 .Q(dac_cfg_data[7:0])
	);
hc74374b hc74374b_Inst1(
	 .ONE(0),
	 .CLK(dac_cfg_addr_w_L),
	 .D(busdata[15:8]),
	 .Q(dac_cfg_data[15:8])
	);
hc74374b hc74374b_Inst2(
	 .ONE(0),
	 .CLK(dac_cfg_addr_w_H),
	 .D(busdata[7:0]),
	 .Q(dac_cfg_data[23:16])
	);
hc74374b hc74374b_Inst3(
	 .ONE(0),
	 .CLK(dac_cfg_addr_w_H),
	 .D(busdata[15:8]),
	 .Q(dac_cfg_data[31:24])
	);

//清除数据
wire dac_cfg_clr;

D_flip_flop D_flip_flop_inst0(
   .prn(1),
	.clk(dac_cfg_clr_addr_w),
	.clrn(1),
	.d(busdata[0]),
	.q(dac_cfg_clr),
	.qb()
	);

//发送配置数据
DAC_out DAC_out_Inst(
	.clk(clk_1M),
	.clr(dac_cfg_clr),
	.data(dac_cfg_data),
	.cs(ltc2600_cs),
	.din(ltc2600_din),
	.sclk(ltc2600_sclk)
	);


/*****************************************
**name:Channel Contorl
**propose:完成74hc4094控制 
**author:wangqi
**time:2017.02.23
*****************************************/
//一号控制
	//第一步加载数据8bits
wire [7:0] hc4094_1_cfg_data;
hc74374b hc74374b_Inst4(
	 .ONE(0),
	 .CLK(hc4094_cfg1_addr_w),
	 .D(busdata[7:0]),
	 .Q(hc4094_1_cfg_data)
	);		
	
	//清除数据
wire hc4094_1_cfg_clr;

D_flip_flop D_flip_flop_inst1(
   .prn(1),
	.clk(hc4094_cfg1_clr_addr_w),
	.clrn(1),
	.d(busdata[0]),
	.q(hc4094_1_cfg_clr),
	.qb()
	);		
	
	//发送配置数据
wire hc4094_1_din;
wire hc4094_1_sclk;	
hc4094_out hc4094_out_Inst0(
	.clk(clk_1M),
	.clr(hc4094_1_cfg_clr),
	.data(hc4094_1_cfg_data),
	.ch_str(hc4094_str1),
	.din(hc4094_1_din),
	.sclk(hc4094_1_sclk)
	);
assign hc4094_din = hc4094_str1 ? hc4094_1_din : 1'bz;
assign hc4094_sclk = hc4094_str1 ? hc4094_1_sclk : 1'bz;	

//二号控制
	//第一步加载数据8bits
wire [7:0] hc4094_2_cfg_data;
hc74374b hc74374b_Inst5(
	 .ONE(0),
	 .CLK(hc4094_cfg2_addr_w),
	 .D(busdata[7:0]),
	 .Q(hc4094_2_cfg_data)
	);		
	
	//清除数据
wire hc4094_2_cfg_clr;

D_flip_flop D_flip_flop_inst2(
   .prn(1),
	.clk(hc4094_cfg2_clr_addr_w),
	.clrn(1),
	.d(busdata[0]),
	.q(hc4094_2_cfg_clr),
	.qb()
	);		
	
	//发送配置数据
wire hc4094_2_din;
wire hc4094_2_sclk;	
hc4094_out hc4094_out_Inst1(
	.clk(clk_1M),
	.clr(hc4094_2_cfg_clr),
	.data(hc4094_2_cfg_data),
	.ch_str(hc4094_str2),
	.din(hc4094_2_din),
	.sclk(hc4094_2_sclk)
	);
assign hc4094_din = hc4094_str2 ? hc4094_2_din : 1'bz;
assign hc4094_sclk = hc4094_str2 ? hc4094_2_sclk : 1'bz;	


/*****************************************
**name:Channel Contorl
**propose:完成pe4302控制 
**author:wangqi
**time:2017.02.24
*****************************************/
//第一步加载数据8bits
wire [7:0] pe4302_cfg_data;
hc74374b hc74374b_Inst6(
	 .ONE(0),
	 .CLK(pe4302_cfg_addr_w),
	 .D(busdata[7:0]),
	 .Q(pe4302_cfg_data)
	);	

//清除数据
wire pe4302_cfg_clr;

D_flip_flop D_flip_flop_inst3(
   .prn(1),
	.clk(pe4302_cfg_clr_addr_w),
	.clrn(1),
	.d(busdata[0]),
	.q(pe4302_cfg_clr),
	.qb()
	);

//发送配置数据
PE4302_out PE4302_out_inst(
	.data_p(pe4302_cfg_data[5:0]),  
	.clk(clk_1M),   
	.clr(pe4302_cfg_clr),  
	.sel(pe4302_cfg_data[6]),  
	.le1(pe3402_le1),      
	.le2(pe3402_le2),      
	.data(pe4302_data),     
	.sclk(pe4302_sclk)
	);
	
	
endmodule
