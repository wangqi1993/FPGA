`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:25 02/07/2017 
// Design Name: 
// Module Name:    ADC_Ctrlword_Send 
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
module ADC_Ctrlword_Send(
		input adc_set_clk,
		input adc_ctrlDataH_Load_en,//控制数据H16加载到本地
		input adc_ctrlDataL_Load_en,//控制数据L16加载到本地
		input adc_ctrlWrod_Load_en,//控制字加载到SPI通信
		input adc_rstn,
		//input adc_clk100M,
		inout [15:0] adc_ctrlData,
		output ADC_SCLK,
		output ADC_CSN,
		output ADC_RSTN,
		output ADC_MOSI	 	 	 
	 );

	 	
		
//第一步加载数据24bit,一位读写控制R/W ，7位地址，16位数据
//wire [23:0] adc_con;
//w_r_mod24 w_r_mod24_Inst(
//		.aw_r_in_L(adc_ctrlDataL_Load_en),
//		.aw_r_in_H(adc_ctrlDataH_Load_en),
//		.clkin(adc_clk100M),
//		.busdata(adc_ctrlData),
//		.rstout(adc_con)
//		);

wire [31:0] adc_con/* synthesis syn_keep = 1 */;
PXI_WD L16(
   .dataout  (adc_con[15:0]),
   .datain   (adc_ctrlData),
   .data_en  (adc_ctrlDataL_Load_en)//posedge
   );	
PXI_WD H16(
   .dataout  (adc_con[31:16]),
   .datain   (adc_ctrlData),
   .data_en  (adc_ctrlDataH_Load_en)//posedge
   );

//SPI 发送
//分频500K
wire clk500K/* synthesis syn_keep = 1 */;
div_20 div_20_Inst(
		.clkin(adc_set_clk),
      .clkout(clk500K)
		);
//发送
//load信号
wire load;
//w_r_mod_1 w_r_mod_1_Inst0(
//		.aw_r_in(adc_ctrlWrod_Load_en),
//      .clkin(adc_clk100M),
//      .busdata(adc_ctrlData[0]),
//      .rstout(load)
//		);
PXI_WD_1bit load_Inst(
   .dataout  (load),
   .datain   (adc_ctrlData[0]),
   .data_en  (adc_ctrlWrod_Load_en)//posedge     
   );	
				
//ADC reset信号
//wire rst;
//w_r_mod_1 w_r_mod_1_Inst1(
//		.aw_r_in(adc_rstn),
//      .clkin(adc_clk100M),
//      .busdata(adc_ctrlData[0]),
//      .rstout(rst)	
//		);
PXI_WD_1bit rst_Inst(
   .dataout  (ADC_RSTN),
   .datain   (adc_ctrlData[0]),
   .data_en  (adc_rstn)//posedge     
   );	
		
//assign ADC_RSTN = !rst; 

wire sdata;
wire sldn;
wire sclk;
s2p s2p_Inst(
		.load(load),
		.clk(clk500K),
		.data(adc_con[24:0]),
		.sdata(sdata),
		.sldn(sldn),
		.sclk(sclk)
		);

D_flip_flop D_flip_flop_inst0(
   .prn(1),
	.clk(adc_set_clk),
	.clrn(1),
	.d(sdata),
	.q(ADC_MOSI),
	.qb()
	);	
D_flip_flop D_flip_flop_inst1(
   .prn(1),
	.clk(adc_set_clk),
	.clrn(1),
	.d(sldn),
	.q(ADC_CSN),
	.qb()
	);	
D_flip_flop D_flip_flop_inst2(
   .prn(1),
	.clk(adc_set_clk),
	.clrn(1),
	.d(sclk),
	.q(ADC_SCLK),
	.qb()
	);	

endmodule
