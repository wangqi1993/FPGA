`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UESTC
// Engineer: \    /\    /                          
//            \  /  \  / 
// 				\/    \/  angQi                         
// Create Date:    16:25:26 12/22/2016 
// Design Name: 
// Module Name:    PXI_DAQ 
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
module PXI_DAQ(
//通道控制
		//CH1
   	output CH1_ltc2600_cs,
		output CH1_ltc2600_din,
		output CH1_ltc2600_sclk,
		output CH1_4094_str1,
		output CH1_4094_str2,
		output CH1_4094_din,
		output CH1_4094_sclk,
		output CH1_pe3402_le,
		output CH1_pe4302_data,
		output CH1_pe4302_sclk,
		//CH2
   	output CH2_ltc2600_cs,
		output CH2_ltc2600_din,
		output CH2_ltc2600_sclk,
		output CH2_4094_str1,
		output CH2_4094_str2,
		output CH2_4094_din,
		output CH2_4094_sclk,
		output CH2_pe3402_le,
		output CH2_pe4302_data,
		output CH2_pe4302_sclk,

//system clock
      input CLK_10M_IN, //DAQ system clock

//pxi interface(pci9054 INTERFACE)
		input ADSN,
		input LHOLD,
		input LCLK_20M,//底板20M
		input LWRN,
		input BLASTN,
		input [31:2] LA,
		inout [15:0] LD,
		output READYN,
		output LHOLDA,
		
//采样时钟配置
	   output PE4320_10MHz_CHOOSE,
	   output PE4320SMPCLK_CHOOSE,
	   output ADCLK9418_SEL_CLK,
		
		output FRQ_DIV_Reset,
		output FRQ_DIV_SEL0,
		output FRQ_DIV_SEL1,
		output FRQ_DIV_SEL2,			
		input  EXT_CLK_Measure_p,
		input  EXT_CLK_Measure_n,
		
		output ADF4350_CS,
		output ADF4350_DIN,
		output ADF4350_SCLK,
		//ADF4350_clkin
	   output ADF4350_CLK_IN,	
		
		output ADF4355_CS,
		output ADF4355_DIN,
		output ADF4355_SCLK,
		
//ADC   
		input [7:0] ADC_AHD,
		input [7:0] ADC_AHDN,
		input [7:0] ADC_ALD,
		input [7:0] ADC_ALDN,
		input [7:0] ADC_BHD,
		input [7:0] ADC_BHDN,
		input [7:0] ADC_BLD,
		input [7:0] ADC_BLDN,
		input [7:0] ADC_CHD,
		input [7:0] ADC_CHDN,
		input [7:0] ADC_CLD,
		input [7:0] ADC_CLDN,
		input [7:0] ADC_DHD,
		input [7:0] ADC_DHDN,
		input [7:0] ADC_DLD,
		input [7:0] ADC_DLDN,	
		input ADC_CDR,   //MRCC时钟管相邻3个bank输入时钟可变,需要2路时钟接受减速后在用统一时钟进DDR
		input ADC_CDRN,
		input ADC_BDR,
		input ADC_BDRN,
		output ADC_SYNCP,//数据输出控制DATA SYNC
	   output ADC_SYNCN,
		//ADC的控制字输出，通过SPI控制ADC工作模式
	   output ADC_SCLK,
	   output ADC_CSN,
	   output ADC_RSTN,
	   output ADC_MOSI,

//触发系统
		//通道
		input Trig_CH1_IN_P,
		input Trig_CH1_IN_N,
		input Trig_CH2_IN_P,
		input Trig_CH2_IN_N,
		input Trig_CH3_IN_P,
		input Trig_CH3_IN_N,
		input Trig_CH4_IN_P,
		input Trig_CH4_IN_N,
      //背板
		input Trig_PXISTAR,
		inout [7:0] Trig_PXITRIG,

	   //外部
		output PE4320_EXTERN_TRIG_INOUT_CHOOSE,
		input EXTERN_TRIG_AND_ARM_IN,
		output EXTERN_TRIG_OUT,
		//视频
		input CH1_VIDEO_TRI_SYN,
		input CH1_VIDEO_TRI_FIELD,
		input CH2_VIDEO_TRI_SYN,
		input CH2_VIDEO_TRI_FIELD,
		//指示灯
		output trigged_indicate,
		output rdy_indicate,
		
//DDR3接口
		inout [63:0]   ddr3_dq,
		inout [7:0]    ddr3_dqs_n,
		inout [7:0]    ddr3_dqs_p,
		// Outputs
		output [14:0] ddr3_addr,
		output [2:0]  ddr3_ba,
		output        ddr3_ras_n,
		output        ddr3_cas_n,
		output        ddr3_we_n,
		output        ddr3_reset_n,
		output        ddr3_ck_p,
		output        ddr3_ck_n,
		output        ddr3_cke,
		output        ddr3_cs_n,
		output [7:0]  ddr3_dm,
		output        ddr3_odt,	
//eeprom接口
      output eeprom1_SCl,//保存校准参数
		inout  eeprom1_SDA,
		output eeprom2_SCl,//保存出厂参数
		inout  eeprom2_SDA,

/**************上面为基本功能完成*************/

/****************华丽的分割线****************/

/**************下面为扩展功能完成*************/
//触发解串接口
//此功能和通道触发输入功能不同时使用-改善ADC分频影响
      output CH_TRIG_SINSEL0,
		output CH_TRIG_SINSEL1,
      output CH_TRIG_RESET,
		output CH_TRIG_SYNC,
		output CH_TRIG_CKEN,
		output CH_TRIG_CKSEL,
		
		input CH_TRIG_Q0,
		
//等效采样
      output Widen_pluse_p,
      output Widen_pluse_n,
		input Expanded_T
		
	
);




//Instantiate the module



/*****************************************
**name:PXI接口模块
**propose:1.PXI接口译码A32/D16
**        2.上位机控制读写端口测试     
**author:wangqi
**time:2017.01.06
*****************************************/
wire LCLK;
wire [15:0]    DMAW;
wire [15:0]    DMAR/* synthesis syn_keep = 1 */;
wire [255:0]   AW/* synthesis syn_keep = 1 */;
wire [255:0]   AR/* synthesis syn_keep = 1 */;
wire  [15:0]   LD/* synthesis syn_keep = 1 */;
wire          DMAChannelInk;

BUFG BUFG_inst1(
      .O(LCLK),     // 1-bit output: Clock output
      .I(LCLK_20M)  // 1-bit input: Clock input
   );
PXI_Interface PXI_interface_Inst(
    /*PXI interface*/
	 .ADSN(ADSN),
	 .LHOLD(LHOLD),
	 .LCLK(LCLK),//底板20M
	 .LWRN(LWRN),
	 .BLASTN(BLASTN),
	 .LA(LA),
	 .LD(LD),
	 .READYN(READYN),
	 .LHOLDA(LHOLDA),
	 .DMAW(DMAW),
	 .DMAR(DMAR),
	 .AW(AW),
	 .AR(AR),
	 .DMAChannelInk(DMAChannelInk)	 	 
	);


/*****************************************
**name:system clock
**propose:1.背板或晶振10M进来，倍频成系统时钟
**          10M 
**          20M   
**          50M   
**          100M  
**          200M 
**        2.PLL输出时钟分频，得到所需时钟
**          2M
**				1M
**
**author:wangqi
**time:2017.01.06
*****************************************/
//10M_in
wire SYSCLK_10M/* synthesis syn_keep = 1 */;//aw7-to choose XTAL or Backboard
BUFG BUFG_inst0(
      .O(SYSCLK_10M), // 1-bit output: Clock output
      .I(CLK_10M_IN)  // 1-bit input: Clock input
       );
//pll
SYS_PLL PLL_inst0(
      .CLK_IN1(SYSCLK_10M),   // IN (NO BUFF)
    // Clock out ports
      .CLK_OUT1(clk_200M),    // OUT BUFG
      .CLK_OUT2(clk_100M),    // OUT
      .CLK_OUT3(clk_50M),     // OUT
      .CLK_OUT4(clk_20M),     // OUT
      .CLK_OUT5(clk_10M),     // OUT
    // Status and control signals
      .RESET(PLL_RESET),// IN
      .LOCKED(PLL_LOCKED)
		);     
PXI_WD_1bit PLL_RESET_Inst(
   .dataout  (PLL_RESET),
   .datain   (LD[0]),
   .data_en  (AW[48])//aw48      
   );
PXI_RD PLL_LOCKED_Inst(
   .dout  (LD[15:0]),
   .din   ({15'h0,PLL_LOCKED}),
   .den   (AR[48])   //ar48
   );
//div
wire clk_2M/* synthesis syn_keep = 1 */;
wire clk_1M/* synthesis syn_keep = 1 */;
div_10 div_10_Inst0(
		.clkin(clk_20M),
      .clkout(clk_2M)
		);
div_10 div_10_Inst1(
		.clkin(clk_10M),
      .clkout(clk_1M)
		);


/*****************************************
**name:Channel Contorl
**propose:1.完成2路通道的控制，pxi采集卡使用2路
**        2.每路控制单元为LTC2600/74hc4094/PE4302三个模块 
**author:wangqi
**time:2017.02.20
*****************************************/
//ch1
Channel_Control Channel_1_Control_Inst(
		.clk_1M(clk_1M),
      .dac_cfg_addr_w_L(AW[15]),        //aw15
		.dac_cfg_addr_w_H(AW[16]),		    //aw16
		.dac_cfg_clr_addr_w(AW[17]),      //aw17
		.hc4094_cfg1_addr_w(AW[18]),      //aw18
		.hc4094_cfg1_clr_addr_w(AW[19]),  //aw19
		.hc4094_cfg2_addr_w(AW[20]),      //aw20
		.hc4094_cfg2_clr_addr_w(AW[21]),  //aw21
		.pe4302_cfg_addr_w(AW[22]),       //aw22
		.pe4302_cfg_clr_addr_w(AW[23]),   //aw23
		.busdata(LD),
		.ltc2600_cs(CH1_ltc2600_cs),
		.ltc2600_din(CH1_ltc2600_din),
		.ltc2600_sclk(CH1_ltc2600_sclk),
		.hc4094_str1(CH1_4094_str1),
		.hc4094_str2(CH1_4094_str2),
		.hc4094_din(CH1_4094_din),
		.hc4094_sclk(CH1_4094_sclk),
		.pe3402_le1(CH1_pe3402_le),
		.pe3402_le2(),
		.pe4302_data(CH1_pe4302_data),
		.pe4302_sclk(CH1_pe4302_sclk)
		);
//ch2
Channel_Control Channel_2_Control_Inst(
		.clk_1M(clk_1M),
      .dac_cfg_addr_w_L(AW[24]),        //aw24
		.dac_cfg_addr_w_H(AW[25]),		    //aw25
		.dac_cfg_clr_addr_w(AW[26]),      //aw26
		.hc4094_cfg1_addr_w(AW[27]),      //aw27
		.hc4094_cfg1_clr_addr_w(AW[28]),  //aw28
		.hc4094_cfg2_addr_w(AW[29]),      //aw29
		.hc4094_cfg2_clr_addr_w(AW[30]),  //aw30
		.pe4302_cfg_addr_w(AW[31]),       //aw31
		.pe4302_cfg_clr_addr_w(AW[32]),   //aw32
		.busdata(LD),
		.ltc2600_cs(CH2_ltc2600_cs),
		.ltc2600_din(CH2_ltc2600_din),
		.ltc2600_sclk(CH2_ltc2600_sclk),
		.hc4094_str1(CH2_4094_str1),
		.hc4094_str2(CH2_4094_str2),
		.hc4094_din(CH2_4094_din),
		.hc4094_sclk(CH2_4094_sclk),
		.pe3402_le1(CH2_pe3402_le),
		.pe3402_le2(),
		.pe4302_data(CH2_pe4302_data),
		.pe4302_sclk(CH2_pe4302_sclk)
		);


/***********************************************************
**name:ADC采样时钟配置
**propose:1.系统时钟10M选择（晶振、背板10M）PE4320_10MHz_CHOOSE
**        2.时钟路径选择（分频、倍频）PE4320SMPCLK_CHOOSE        
**        3.分频器控制
**        4.ADF4350控制
**        5.ADF4355控制
**			 6.ADC采样时钟选择（内部、外部）ADCLK9418_SEL_CLK
**        7.外部时钟测量1M~2G
**author:wangqi
**time:2017.02.13
***********************************************************/
PXI_WD_1bit PE4320_10MHz_CHOOSE_Inst(
   .dataout  (PE4320_10MHz_CHOOSE),
   .datain   (LD[0]),
   .data_en  (AW[7])//aw7      
   );
PXI_WD_1bit PE4320SMPCLK_CHOOSE_Inst(
   .dataout  (PE4320SMPCLK_CHOOSE),
   .datain   (LD[1]),
   .data_en  (AW[7])//aw7      
   );
PXI_WD_1bit ADCLK9418_SEL_CLK_Inst(
   .dataout  (ADCLK9418_SEL_CLK),
   .datain   (LD[2]),
   .data_en  (AW[7])//aw7      
   );
//分频器
PXI_WD_1bit FRQ_DIV_Reset_Inst(
   .dataout  (FRQ_DIV_Reset),
   .datain   (LD[3]),
   .data_en  (AW[8])//aw8     
   );
PXI_WD_1bit FRQ_DIV_SEL0_Inst(
   .dataout  (FRQ_DIV_SEL0),
   .datain   (LD[0]),
   .data_en  (AW[8])//aw8      
   );
PXI_WD_1bit FRQ_DIV_SEL1_Inst(
   .dataout  (FRQ_DIV_SEL1),
   .datain   (LD[1]),
   .data_en  (AW[8])//aw8      
   );
PXI_WD_1bit FRQ_DIV_SEL2_Inst(
   .dataout  (FRQ_DIV_SEL2),
   .datain   (LD[2]),
   .data_en  (AW[8])//aw8      
   );
//ADF4350控制
ADF_Control ADF4350_Control_Inst(
	.clk_2M(clk_2M),
	//.clk_100M(clk_100M),
	.adf_data_h(AW[9]), //aw9
	.adf_data_l(AW[10]),//aw10
	.adf_clr(AW[11]),   //aw11
	.data(LD),
	.adf_cs(ADF4350_CS),
	.adf_din(ADF4350_DIN),
	.adf_sclk(ADF4350_SCLK)
	);
//PLL输出20M给ADF4550
assign ADF4350_CLK_IN =clk_20M;
//ADF4355控制
ADF_Control ADF4355_Control_Inst(
	.clk_2M(clk_2M),
	//.clk_100M(clk_100M),
	.adf_data_h(AW[12]),//aw12
	.adf_data_l(AW[13]),//aw13
	.adf_clr(AW[14]),   //aw14
	.data(LD),
	.adf_cs(ADF4355_CS),
	.adf_din(ADF4355_DIN),
	.adf_sclk(ADF4355_SCLK)
	);		
//外部时钟测量1M~2G:（选择分频器8分频，FPGA测量125K~250M)
wire 			EXT_CLK_Measure/* synthesis syn_keep = 1 */;
wire 			clk_500Hz;
wire [31:0] EXT_CLK_DATA;

IBUFGDS	#(.IOSTANDARD("LVDS_25"),.DIFF_TERM("TRUE"))	//IBUFGDS:外部时钟
	ibuf_d_EXT_CLK (.I(EXT_CLK_Measure_p), .IB(EXT_CLK_Measure_n), .O(EXT_CLK_Measure));		
	
div_2000 div_2000_Inst0(
		.clkin(clk_1M),
      .clkout(clk_500Hz)
		);				
//以标准低频时钟1k测高频时钟125K~250M	，出来的数为clk_500Hz的高电平记的数
pulse_width_measure EXT_CLK_Measure_Inst(
   .refclk(clk_500Hz),
	.meaclk(EXT_CLK_Measure),
   .outdata(EXT_CLK_DATA)
);
//软件读上去数--要乘以8才是原始外部时钟频率（单位KHz）	
PXI_RD EXT_CLK_DATA_Inst0(
   .dout  (LD[15:0]),
   .din   (EXT_CLK_DATA[15:0]),
   .den  (AR[7])     //ar7
   );	
PXI_RD EXT_CLK_DATA_Inst1(
   .dout  (LD[15:0]),
   .din   (EXT_CLK_DATA[31:16]),
   .den  (AR[8])     //ar8
   );
	
/*****************************************
**name:ADC
**propose:1.ADC sync contorl
**        2.ADC随路时钟（可变的）
**        3.ADC SPI通信控制
**        4.ADC数据接收
**author:wangqi
**time:2017.01.06
*****************************************/

//DATA SYNC 送给ADC的数据同步
//将此信号送给ADC一段时间后，ADC的数据开始同步输出
//adc_sync
PXI_WD_1bit ADC_SYNC_inst0(
   .dataout  (ADC_SYNC_in),
   .datain   (LD[0]),
   .data_en  (AW[2])//aw2      
   );
OBUFDS #(.IOSTANDARD("LVDS_25"))
obuf(.I(ADC_SYNC_in),.O(ADC_SYNCP),.OB(ADC_SYNCN));

//ADC CLK-(IBUFDS+BUFG方案-上全局时钟）
wire adc_clk_out1/* synthesis syn_keep = 1 */,adc_clk_out2/* synthesis syn_keep = 1 */;
IBUFGDS	#(.IOSTANDARD("LVDS_25"),.DIFF_TERM("TRUE"))	//IBUFGDS:CHANAL AB
	ibuf_d_BHD0 (.I(ADC_BDR), .IB(ADC_BDRN), .O(adc_clk_out1));	
IBUFGDS	#(.IOSTANDARD("LVDS_25"),.DIFF_TERM("TRUE"))	//IBUFGDS:CHANAL CD
	ibuf_d_CHD0 (.I(ADC_CDR), .IB(ADC_CDRN), .O(adc_clk_out2));		
	
//ADC SPI
ADC_Ctrlword_Send ADC_Ctrlword_Send_Inst
	(
    .adc_set_clk(clk_10M),//10M
	 .adc_ctrlDataH_Load_en(AW[3]),//控制数高16位加载到本地  aw3
	 .adc_ctrlDataL_Load_en(AW[4]),//控制数低16位加载到本地  aw4
	 .adc_ctrlWrod_Load_en(AW[5]), //控制字加载到SPI通信    aw5
	 .adc_rstn(AW[6]),             //复位                 aw6
	 //.adc_clk100M(clk_100M),//100M
	 .adc_ctrlData(LD),
	 .ADC_SCLK(ADC_SCLK),
	 .ADC_CSN(ADC_CSN),
	 .ADC_RSTN(ADC_RSTN),
	 .ADC_MOSI(ADC_MOSI)
	 
	);
	
//ADC DATA_RX  1:2DMUX MODE
wire adc_count_clr;
wire peak_mode;
wire [31:0] div_n_maxmin;
wire extract_enable;
wire [31:0] div_n;

PXI_WD_1bit adc_count_clr_Inst(
   .dataout  (adc_count_clr),
   .datain   (LD[0]),
   .data_en  (AW[33])//aw33      
   );
PXI_WD_1bit peak_mode_Inst(
   .dataout  (peak_mode),
   .datain   (LD[0]),
   .data_en  (AW[34])//aw34      
   );
PXI_WD div_n_maxmin_1_Inst(
   .dataout  (div_n_maxmin[31:16]),
   .datain   (LD[15:0]),
   .data_en  (AW[35])//aw35
   );	
PXI_WD div_n_maxmin_2_Inst(
   .dataout  (div_n_maxmin[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[36])//aw36
   );
PXI_WD_1bit extract_enable_Inst(
   .dataout  (extract_enable),
   .datain   (LD[0]),
   .data_en  (AW[37])//aw37      
   );
PXI_WD div_n_1_Inst(
   .dataout  (div_n[31:16]),
   .datain   (LD[15:0]),
   .data_en  (AW[35])//aw38
   );	
PXI_WD div_n_2_Inst(
   .dataout  (div_n[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[36])//aw39
   );
	
wire scan_rst;
wire [31:0] div_n_scan;
wire rden_scan;
wire [15:0] scan_dout;
wire scan_over;
wire scan_stop;

PXI_WD_1bit scan_rst_Inst(
   .dataout  (scan_rst),
   .datain   (LD[0]),
   .data_en  (AW[40])//aw40      
   );
PXI_WD div_n_scan_1_Inst(
   .dataout  (div_n_scan[31:16]),
   .datain   (LD[15:0]),
   .data_en  (AW[41])//aw41
   );	
PXI_WD div_n_scan_2_Inst(
   .dataout  (div_n_scan[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[42])//aw42
   );

assign rden_scan = AR[43];//ar43

PXI_RD scan_dout_Inst(
   .dout  (LD[15:0]),
   .din   (scan_dout[15:0]),
   .den   (AR[43])    //ar43
   );
PXI_RD scan_status_Inst(
   .dout  (LD[15:0]),
   .din   ({14'h0,scan_stop,scan_over}),
   .den   (AR[44])    //ar44
   );

wire        fifo_all_wen;
wire   [127:0]   rx_CH_DCBA_fix_out;


//单通道采集ABCD            data_format0
//双通道采集AC AD BC BD     data_format1
//4通道采集 A B C D         data_format2
wire [1:0]   data_format_choose_from_ADC;
PXI_WD_1bit data_format_choose_from_ADC_Inst0(
   .dataout  (data_format_choose_from_ADC[0]),
   .datain   (LD[0]),
   .data_en  (AW[116])//aw116      
   );
PXI_WD_1bit data_format_choose_from_ADC_Inst1(
   .dataout  (data_format_choose_from_ADC[1]),
   .datain   (LD[1]),
   .data_en  (AW[116])//aw116      
   );

//抽点插值系统
wire [15:0] DUC_Factor_WR_Addr;
wire [15:0] DUC_Factor_WR_Data;
wire        DUC_Factor_WR_Rst;



//信号发生器产生的触发信号
wire Signal_Trig_test;

ADC_DATA_RX ADC_DATA_RX_Inst(	

	.count_clr(adc_count_clr),                                 //aw33 active low
	//peak detect mode select, high peak dectect low normal 
	.peak_mode(peak_mode),                                     //aw34 1: peak 0:normal
	//peakdetect multiple factor 
   .div_n_maxmin(div_n_maxmin),                               //aw35 high16bit; aw36 low16bit
	//enable extract 4, high enable low disable 
   .extract_enable(extract_enable),                           //aw37 1:extract 0: bypass
   //extract 4 multiple factor 
   .div_n(div_n),                                             //aw38 high16bit; aw39 low16bit
	
	.scan_rst(scan_rst),                                       //aw40
	.div_n_scan(div_n_scan[31:0]),                             //aw41 high16bit; aw42 low16bit 
	.rden_scan(rden_scan),					              //ar43-enable
	.scan_dout(scan_dout),					              //ar43-data
	.scan_over(scan_over),					              //ar44	
	.scan_stop(scan_stop),	                          //ar44

	.rx_clk1(adc_clk_out1),   
	.rx_clk2(adc_clk_out2), 
	.AHD	(ADC_AHD),
	.AHDN	(ADC_AHDN),
	.ALD	(ADC_ALD),
	.ALDN	(ADC_ALDN),
	.BHD	(ADC_BHD),
	.BHDN	(ADC_BHDN),
	.BLD	(ADC_BLD),
	.BLDN	(ADC_BLDN),
	.CHD	(ADC_CHD),
	.CHDN	(ADC_CHDN),
	.CLD	(ADC_CLD),
	.CLDN	(ADC_CLDN),
	.DHD	(ADC_DHD),
	.DHDN	(ADC_DHDN),
	.DLD	(ADC_DLD),
	.DLDN	(ADC_DLDN),
   .data_format_choose_from_ADC(data_format_choose_from_ADC), //硬件拼数设置	
	
	//抽点插值
	.DUC_Factor_WR_Addr(DUC_Factor_WR_Addr),
	.DUC_Factor_WR_Data(DUC_Factor_WR_Data),
   .DUC_Factor_WR_Rst(DUC_Factor_WR_Rst),
	
	
	
	
	
	
	
	
	.rx_CH_DCBA_fix_out(rx_CH_DCBA_fix_out),//ADC数据流整理后输出
	.fifo_all_wen(fifo_all_wen),//输出的fifo写使能
	
	
	.Signal_Trig_test(Signal_Trig_test)
	
	);
	
	
/*****************************************
**name:TRIG_System
**propose:触发系统
**author:wangqi
**time:2017.03.09
*****************************************/
wire auto_rd_en;
wire begin_wr_ddr3;
wire rst_rx_ddr3;//用作trig_clr
wire [31:0] pre_num/* synthesis syn_keep = 1 */;
wire auto_normal_ctrl/* synthesis syn_keep = 1 */;
wire [15:0] trig_sel;
wire trig_edge_sel;
wire [15:0] trig_out_sel;
wire [15:0] pattern_choose;
wire [15:0] arm_sel;
wire arm_channel_sel;
wire arm_polar_sel;


wire pul_width_cnt_clr;
wire [15:0]  pul_func;
wire [31:0] pul_cmp_low;
wire [31:0] pul_cmp_high;
wire pul_sel; 

wire trig_holdoff_sel; 
wire trig_holdoff_reload;
wire [47:0] trig_holdoff_time; 

//通道
wire Trig_CH1/* synthesis syn_keep = 1 */;
wire Trig_CH2/* synthesis syn_keep = 1 */;
wire Trig_CH3/* synthesis syn_keep = 1 */;
wire Trig_CH4/* synthesis syn_keep = 1 */;
//视频
wire even_trig_CH1;
wire odd_trig_CH1;
wire anyrow_trig_CH1;
wire certainrow_trig_CH1;
wire even_trig_CH2;
wire odd_trig_CH2;
wire anyrow_trig_CH2;
wire certainrow_trig_CH2;
wire [1:0] Video_Trig_CH1_choose;
wire [1:0] Video_Trig_CH2_choose;
wire Trig_Video_CH1;
wire Trig_Video_CH2;

//指示灯
wire trigged;

//CH1触发信号，进行差分转单端，上全局时钟
IBUFGDS #(
.DIFF_TERM("TRUE"), // Differential Termination (Virtex-4/5, Spartan-3E/3A)
.IOSTANDARD("DEFAULT") // Specifies the I/O standard for this buffer
) IBUFGDS_inst1 (
.O(Trig_CH1), // Clock buffer output
.I(Trig_CH1_IN_P), // Diff_p clock buffer input
.IB(Trig_CH1_IN_N) // Diff_n clock buffer input
);
//CH2触发信号，进行差分转单端，上全局时钟
IBUFGDS #(
.DIFF_TERM("TRUE"), // Differential Termination (Virtex-4/5, Spartan-3E/3A)
.IOSTANDARD("DEFAULT") // Specifies the I/O standard for this buffer
) IBUFGDS_inst2 (
.O(Trig_CH2), // Clock buffer output
.I(Trig_CH2_IN_P), // Diff_p clock buffer input
.IB(Trig_CH2_IN_N) // Diff_n clock buffer input
);
//CH3触发信号，进行差分转单端，上全局时钟
IBUFGDS #(
.DIFF_TERM("TRUE"), // Differential Termination (Virtex-4/5, Spartan-3E/3A)
.IOSTANDARD("DEFAULT") // Specifies the I/O standard for this buffer
) IBUFGDS_inst3 (
.O(Trig_CH3), // Clock buffer output
.I(Trig_CH3_IN_P), // Diff_p clock buffer input
.IB(Trig_CH3_IN_N) // Diff_n clock buffer input
);
//CH4触发信号，进行差分转单端，上全局时钟
IBUFGDS #(
.DIFF_TERM("TRUE"), // Differential Termination (Virtex-4/5, Spartan-3E/3A)
.IOSTANDARD("DEFAULT") // Specifies the I/O standard for this buffer
) IBUFGDS_inst4 (
.O(Trig_CH4), // Clock buffer output
.I(Trig_CH4_IN_P), // Diff_p clock buffer input
.IB(Trig_CH4_IN_N) // Diff_n clock buffer input
);
//通道触发解串-软件配置放在ADC前即可
PXI_WD_1bit CH_TRIG_SINSEL0_Inst(
   .dataout  (CH_TRIG_SINSEL0),
   .datain   (LD[0]),
   .data_en  (AW[110]) //aw110      
   );
PXI_WD_1bit CH_TRIG_SINSEL1_Inst(
   .dataout  (CH_TRIG_SINSEL1),
   .datain   (LD[1]),
   .data_en  (AW[110]) //aw110      
   );
PXI_WD_1bit CH_TRIG_RESET_Inst(
   .dataout  (CH_TRIG_RESET),
   .datain   (LD[0]),
   .data_en  (AW[111]) //aw111      
   );
PXI_WD_1bit CH_TRIG_SYNC_Inst(
   .dataout  (CH_TRIG_SYNC),
   .datain   (LD[0]),
   .data_en  (AW[112]) //aw112      
   );
PXI_WD_1bit CH_TRIG_CKEN_Inst(
   .dataout  (CH_TRIG_CKEN),
   .datain   (LD[0]),
   .data_en  (AW[113]) //aw113      
   );
PXI_WD_1bit CH_TRIG_CKSEL_Inst(
   .dataout  (CH_TRIG_CKSEL),
   .datain   (LD[0]),
   .data_en  (AW[114]) //aw114      
   );

//视频	
TV_Trig TV_Trig_Inst0(
	.clk_in10M(clk_10M),
	.OE_IN(CH1_VIDEO_TRI_FIELD),
	.HS_IN(CH1_VIDEO_TRI_SYN),
	.ROW_SEL(AW[67]),		    //aw67
	.VIDEO_MODE_SEL(AW[68]), //aw68
	.DATA(LD[15:0]),
	.even_trig(even_trig_CH1),
	.odd_trig(odd_trig_CH1),
	.anyrow_trig(anyrow_trig_CH1),
	.certainrow_trig(certainrow_trig_CH1)
);
TV_Trig TV_Trig_Inst1(
	.clk_in10M(clk_10M),
	.OE_IN(CH2_VIDEO_TRI_FIELD),
	.HS_IN(CH2_VIDEO_TRI_SYN),
	.ROW_SEL(AW[69]),		    //aw69
	.VIDEO_MODE_SEL(AW[70]), //aw70
	.DATA(LD[15:0]),
	.even_trig(even_trig_CH2),
	.odd_trig(odd_trig_CH2),
	.anyrow_trig(anyrow_trig_CH2),
	.certainrow_trig(certainrow_trig_CH2)
);
PXI_WD_1bit Video_Trig_CH1_choose_Inst0(
   .dataout  (Video_Trig_CH1_choose[0]),
   .datain   (LD[0]),
   .data_en  (AW[71]) //aw71      
   );
PXI_WD_1bit Video_Trig_CH1_choose_Inst1(
   .dataout  (Video_Trig_CH1_choose[1]),
   .datain   (LD[1]),
   .data_en  (AW[71]) //aw71      
   );
PXI_WD_1bit Video_Trig_CH2_choose_Inst0(
   .dataout  (Video_Trig_CH2_choose[0]),
   .datain   (LD[0]),
   .data_en  (AW[72]) //aw72      
   );
PXI_WD_1bit Video_Trig_CH2_choose_Inst1(
   .dataout  (Video_Trig_CH2_choose[1]),
   .datain   (LD[1]),
   .data_en  (AW[72]) //aw72      
   );
MUX_41 MUX_41_Inst0(
   .d0(even_trig_CH1),
   .d1(odd_trig_CH1),
	.d2(anyrow_trig_CH1),
	.d3(certainrow_trig_CH1),
   .s0(Video_Trig_CH1_choose[0]),
	.s1(Video_Trig_CH1_choose[1]),
	.q(Trig_Video_CH1)
);
MUX_41 MUX_41_Inst1(
   .d0(even_trig_CH2),
   .d1(odd_trig_CH2),
	.d2(anyrow_trig_CH2),
	.d3(certainrow_trig_CH2),
   .s0(Video_Trig_CH2_choose[0]),
	.s1(Video_Trig_CH2_choose[1]),
	.q(Trig_Video_CH2)
);

//软件
wire soft_trig;
PXI_WD_1bit soft_trig_Inst(
   .dataout  (soft_trig),
   .datain   (LD[0]),
   .data_en  (AW[76]) //aw76
   );
//pre_num
PXI_WD pre_num_L_Inst(
   .dataout  (pre_num[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[63]) //aw63
   );
	
PXI_WD pre_num_H_Inst(
   .dataout  (pre_num[31:16]),
   .datain   (LD[15:0]),
   .data_en  (AW[64]) //aw64
   );
//auto_normal_ctrl
PXI_WD_1bit auto_normal_ctrl_Inst(
   .dataout  (auto_normal_ctrl),
   .datain   (LD[0]),
   .data_en  (AW[65]) //aw65
   );
//外部触发进出选择
PXI_WD_1bit PE4320_EXTERN_TRIG_INOUT_CHOOSE_Inst(
   .dataout  (PE4320_EXTERN_TRIG_INOUT_CHOOSE),
   .datain   (LD[0]),
   .data_en  (AW[66]) //aw66
   );	
//Trig_choose
PXI_WD Trig_choose_Inst(
   .dataout  (trig_sel[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[73]) //aw73
   );
PXI_WD_1bit trig_edge_sel_Inst(
   .dataout  (trig_edge_sel),
   .datain   (LD[0]),
   .data_en  (AW[74]) //aw74
   );
//pattern	
PXI_WD pattern_choose_Inst(
   .dataout  (pattern_choose[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[118]) //aw118
   );		
//arm	
PXI_WD arm_sel_Inst(
   .dataout  (arm_sel[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[75]) //aw75
   );
PXI_WD_1bit arm_channel_sel_Inst(
   .dataout  (arm_channel_sel),
   .datain   (LD[0]),
   .data_en  (AW[77]) //aw77
   );
PXI_WD_1bit arm_polar_sel_Inst(
   .dataout  (arm_polar_sel),
   .datain   (LD[0]),
   .data_en  (AW[78]) //aw78
   );	
//trig out sel	
PXI_WD trig_out_sel_Inst(
   .dataout  (trig_out_sel[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[79]) //aw79
   );		
//脉宽触发处理
PXI_WD_1bit pul_width_cnt_clr_inst(
   .dataout  (pul_width_cnt_clr),
   .datain   (LD[0]),
   .data_en  (AW[80])//aw80
   );
PXI_WD pul_func_inst0(
   .dataout  (pul_func[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[81])//aw81
   );		
PXI_WD pul_cmp_low_inst0(
   .dataout  (pul_cmp_low[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[82])//aw82
   );
PXI_WD pul_cmp_low_inst1(
   .dataout  (pul_cmp_low[31:16]),
   .datain   (LD[15:0]),
   .data_en  (AW[83])//aw83
   );
PXI_WD pul_cmp_high_inst0(
   .dataout  (pul_cmp_high[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[84])//aw84
   );
PXI_WD pul_cmp_high_inst1(
   .dataout  (pul_cmp_high[31:16]),
   .datain   (LD[15:0]),
   .data_en  (AW[85])//aw85
   );
PXI_WD_1bit pul_sel_inst0(
   .dataout  (pul_sel),
   .datain   (LD[0]),
   .data_en  (AW[86])//aw86
   );
//holdoff
PXI_WD trig_holdoff_time_inst0(
   .dataout  (trig_holdoff_time[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[87])//aw87
   );
PXI_WD trig_holdoff_time_inst1(
   .dataout  (trig_holdoff_time[31:16]),
   .datain   (LD[15:0]),
   .data_en  (AW[88])//aw88
   );
PXI_WD trig_holdoff_time_inst2(
   .dataout  (trig_holdoff_time[47:32]),
   .datain   (LD[15:0]),
   .data_en  (AW[89])//aw89
   );	
PXI_WD_1bit trig_holdoff_inst(
   .dataout  (trig_holdoff_sel),
   .datain   (LD[0]),
   .data_en  (AW[90])//aw90
   );			
PXI_WD_1bit trig_holdoff_reload_inst(
   .dataout  (trig_holdoff_reload),
   .datain   (LD[0]),
   .data_en  (AW[91])//aw91
   );
//触发（信号）频率测量
wire freq_meas_clr;	
wire freq_meas_gap_sel;	//20kHz/20Hz
wire freq_meas_status;
wire [31:0] freq_meas_cnt_num;

PXI_WD_1bit freq_meas_clr_Inst(
   .dataout  (freq_meas_clr),
   .datain   (LD[0]),
   .data_en  (AW[104])//aw104
   );	
PXI_WD_1bit freq_meas_gap_sel_Inst(
   .dataout  (freq_meas_gap_sel),//1:20kHz/ 0:20Hz
   .datain   (LD[0]),
   .data_en  (AW[105])//aw105
   );	
PXI_RD freq_meas_status_Inst(
   .dout  (LD[15:0]),
   .din   ({15'h0,freq_meas_status}),
   .den  (AR[104])    //ar104
   );	
PXI_RD freq_meas_cnt_num_L_Inst(
   .dout  (LD[15:0]),
   .din   (freq_meas_cnt_num[15:0]),
   .den  (AR[105])    //ar105
   );	
PXI_RD freq_meas_cnt_num_H_Inst(
   .dout  (LD[15:0]),
   .din   (freq_meas_cnt_num[31:16]),
   .den  (AR[106])    //ar106
   );

/**************下面为扩展功能*************/
//等效采样
wire TDC_en;
//wire [1:0] TDC_sel;
wire [31:0] TDC_T_num;

PXI_WD_1bit TDC_en_Inst(
   .dataout  (TDC_en),
   .datain   (LD[0]),
   .data_en  (AW[107])//aw107
   );	
//PXI_WD_1bit TDC_sel_Inst0(
//   .dataout  (TDC_sel[0]),
//   .datain   (LD[0]),
//   .data_en  (AW[108])//aw108
//   );
//PXI_WD_1bit TDC_sel_Inst1(
//   .dataout  (TDC_sel[1]),
//   .datain   (LD[1]),
//   .data_en  (AW[108])//aw108
//   );	
PXI_RD TDC_T_num_Inst0(
   .dout  (LD[15:0]),
   .din   (TDC_T_num[15:0]),
   .den  (AR[108])   //ar108
   );
PXI_RD TDC_T_num_Inst1(
   .dout  (LD[15:0]),
   .din   (TDC_T_num[31:16]),
   .den  (AR[109])   //ar109
   );	
//TRIG_System
TRIG_System TRIG_System_Inst(
	 //test
    .Signal_Trig_test(Signal_Trig_test),//From Signal_Generator
	 //通道
    .trig_ch1(Trig_CH1),
	 .trig_ch2(Trig_CH2),
	 .trig_ch3(Trig_CH3),
	 .trig_ch4(Trig_CH4),
	 //通道触发解串
	 .CH_TRIG_Q0(CH_TRIG_Q0),
	 //背板
    .Trig_PXISTAR(Trig_PXISTAR),
	 .Trig_PXITRIG(Trig_PXITRIG),
    //外部
    .EXTERN_TRIG_AND_ARM_IN(EXTERN_TRIG_AND_ARM_IN),
    .EXTERN_TRIG_OUT(EXTERN_TRIG_OUT),
    //视频
	 .Trig_Video_CH1(Trig_Video_CH1),
	 .Trig_Video_CH2(Trig_Video_CH2),
	 //软件
	 .soft_trig(soft_trig),	 
	 //Pattern
	 .pattern_choose(pattern_choose),
	 //ARM
	 .arm_sel(arm_sel[3:0]),
	 .arm_channel_sel(arm_channel_sel),
	 .arm_polar_sel(arm_polar_sel),
	 //tirg in/out
	 .trig_sel(trig_sel[4:0]),
	 .trig_edge_sel(trig_edge_sel),
	 .trig_out_sel(trig_out_sel[8:0]),
	 //pluse
	 .pul_width_cnt_clr(pul_width_cnt_clr),	
    .pul_func(pul_func[15:0]),	
    .pul_cmp_low(pul_cmp_low[31:0]),
    .pul_cmp_high(pul_cmp_high[31:0]),	 
	 .pul_sel(pul_sel),
	 //holdoff
	 .trig_holdoff_sel(trig_holdoff_sel),
	 .trig_holdoff_reload(trig_holdoff_reload),
	 .trig_holdoff_time(trig_holdoff_time[47:0]),
	 
	 .rxclk(adc_clk_out1),
    .wr_en(begin_wr_ddr3),//in
	 .auto_rd_en(auto_rd_en),//out
	 .auto_rd_en_dly4(auto_rd_en_dly4),//out
	 .clkin1M(clk_1M),
	 .clkin20M(clk_20M),
	 .clkin200M(clk_200M),
	 .pre_num(pre_num),
	 .auto_normal_ctrl(auto_normal_ctrl),
	 .en_data(fifo_all_wen),
    .cnt_clr(rst_rx_ddr3),
    .trigged(trigged),
	 //信号频率测量
	 .freq_meas_clr(freq_meas_clr),
	 .freq_meas_gap_sel(freq_meas_gap_sel),
	 .freq_meas_status(freq_meas_status),
	 .freq_meas_cnt_num(freq_meas_cnt_num),
	 	 
	 //等效采样
	 .TDC_en(TDC_en),
	 //.TDC_sel(TDC_sel),
	 .Widen_pluse(Widen_pluse),//out
	 .Expanded_T(Expanded_T),//in
	 .TDC_T_num(TDC_T_num)
	 	 		 
);
//触发指示灯,rdy指示灯
assign trigged_indicate = trigged;

PXI_WD_1bit rdy_indicate_Inst(
   .dataout  (rdy_indicate),
   .datain   (LD[0]),
   .data_en  (AW[117])//aw117
   );


//输出脉冲（等效采样）
OBUFDS #(.IOSTANDARD("LVDS_25"))
obuf_wide(.I(Widen_pluse),.O(Widen_pluse_p),.OB(Widen_pluse_n));

//读触发地址
wire dimm_sys_rst;//DDR_IP复位
reg [26:0] addr_trig_ddr3_dly1;

always @(negedge auto_rd_en_dly4 or negedge dimm_sys_rst)
begin
      if(dimm_sys_rst == 1'b0)
		addr_trig_ddr3_dly1[26:0] <= 27'h0; 		
		else 
      addr_trig_ddr3_dly1[26:0] <= addr_trig_ddr3[26:0]; 
end

//读触发地址[15:0]
PXI_RD addr_trig_ddr3_L_Inst(
   .dout  (LD[15:0]),
   .din   (addr_trig_ddr3_dly1[15:0]),
   .den  (AR[61])     //ar61
   );	
//读触发地址[26:16]
PXI_RD addr_trig_ddr3_H_Inst(
   .dout  (LD[15:0]),
   .din   ({5'b00000,addr_trig_ddr3_dly1[26:16]}),
   .den  (AR[62])     //ar62
   );	


/*****************************************
**name:DDR_APP_ctrl
**propose:DDR存储操作
**author:wangqi
**time:2017.03.02
*****************************************/
wire [127:0] data_from_ADC/* synthesis syn_keep = 1 */;

wire [127:0] data_from_compensation;
wire         data_to_ram_choose;
wire [127:0] data_to_ram;
reg  [127:0] data_to_ram_dly1;
reg          fifo_all_wen_dly1;

wire 		    rd_fifo_ready;
wire 		    num_rd_r_o;
wire [3:0]   DDR3_state;
wire [15:0]  DIMMdepth_ctrl;
wire         wen_ddr3;
wire [15:0]  addr_wr_init;
wire         ren_ddr3;

wire [31:0]  addr_init_rd;
wire [31:0]  num_rd_ddr3;
wire [3:0]   wr_state_out;
wire         write_stop_ddr3;
wire         read_stop_ddr3;
wire [26:0]  cnt_num_rd;
wire [26:0]  addr_trig_ddr3;
wire [63:0]  d_rfifo;
wire [511:0] dout_fifo_adc;//测试用，512bit进DDR-App接口
wire         ui_clk;//ddr_app_clk
wire         init_calib_complete;//DDR硬件初始化完成
wire [2:0]   app_cmd;
wire         app_en;
wire [511:0] app_wdf_data;
wire         app_wdf_end;
wire [63:0]  app_wdf_mask;
wire [28:0]  app_addr;
wire 			 app_wdf_wren;
wire [511:0] app_rd_data;
wire			 app_rd_data_valid;
wire			 app_rdy;
wire 			 app_wdf_rdy;

//DDR接收复位
PXI_WD_1bit rst_rx_ddr3_Inst(
   .dataout  (rst_rx_ddr3),
   .datain   (LD[0]),
   .data_en  (AW[45])//aw45      
   );
//选择通道补偿前数据 or 通道补偿后数据		
PXI_WD_1bit data_to_ram_choose_Inst(
   .dataout  (data_to_ram_choose),
   .datain   (LD[0]),
   .data_en  (AW[115])//aw115      
   );	
//adc_RX_out_DATA -ADC出来原始数据-硬件拼好数了
//assign data_from_ADC = {rx_ch_DH_fix[15:0],rx_ch_DL_fix[15:0],
//								rx_ch_CH_fix[15:0],rx_ch_CL_fix[15:0],
//								rx_ch_BH_fix[15:0],rx_ch_BL_fix[15:0],
//								rx_ch_AH_fix[15:0],rx_ch_AL_fix[15:0]};	

assign data_from_ADC[127:0] = rx_CH_DCBA_fix_out[127:0];
//进DDR数据选择
assign data_to_ram = data_to_ram_choose ? data_from_ADC :data_from_compensation;
//数据和写使能打一拍
always @(posedge adc_clk_out1)//阻塞赋值，同步
begin
  data_to_ram_dly1[127:0] <= data_to_ram[127:0];
  fifo_all_wen_dly1       <= fifo_all_wen;  
end
//读DDR控制状态
//读DDR状态

PXI_RD DDR_state_Inst0(
   .dout  (LD[15:0]),
   .din   ({13'b0,wen_ddr3,ren_ddr3,dimm_sys_rst}),
   .den  (AR[46])     //ar46
   ); 
	
PXI_RD DDR_state_Inst1(
   .dout  (LD[15:0]),
   .din   ({9'b0,num_rd_r_o,rd_fifo_ready,init_calib_complete,DDR3_state}),
   .den  (AR[47])     //ar47
   ); 
//存储深度控制	
PXI_WD DIMMdepth_ctrl_Inst(
   .dataout  (DIMMdepth_ctrl),
   .datain   (LD[15:0]),
   .data_en  (AW[49]) //aw49
   );
//写“ddr写”
PXI_WD_1bit wen_ddr3_Inst(
   .dataout  (wen_ddr3),
   .datain   (LD[0]),
   .data_en  (AW[50]) //aw50       
   );
//写偏移地址	
PXI_WD addr_wr_init_Inst(
   .dataout  (addr_wr_init),
   .datain   (LD[15:0]),
   .data_en  (AW[51]) //aw51
   );
//写“ddr读”
PXI_WD_1bit ren_ddr3_Inst(
   .dataout  (ren_ddr3),
   .datain   (LD[0]),
   .data_en  (AW[52]) //aw52      
   );
//写“后端FIFO读”sel
wire [1:0] rden_least_fifo_sel;
reg                      rden ;
wire rd_clka;
wire rd_clkb;
wire rd_clkc;
wire rd_clkd;
//assign rd_clka = ~DMAR[2];
//assign rd_clkb = ~DMAR[3];
//assign rd_clkc = ~DMAR[4];
//assign rd_clkd = ~DMAR[5];
assign rd_clka = ~AR[80];
assign rd_clkb = ~AR[81];
assign rd_clkc = ~AR[82];
assign rd_clkd = ~AR[83];
PXI_WD_1bit rden_least_fifo_Inst0(
   .dataout  (rden_least_fifo_sel[0]),
   .datain   (LD[0]),
   .data_en  (AW[53]) //aw53      
   );
PXI_WD_1bit rden_least_fifo_Inst1(
   .dataout  (rden_least_fifo_sel[1]),
   .datain   (LD[1]),
   .data_en  (AW[53]) //aw53      
   );
//生成上位机读上升沿--去硬件更新所读数
always @( rden_least_fifo_sel[1] or rden_least_fifo_sel[0] or rd_clka or rd_clkb or rd_clkc or rd_clkd)
begin
     case (rden_least_fifo_sel)
		  2'b00: rden <= rd_clka;
		  2'b01: rden <= rd_clkb;
		  2'b10: rden <= rd_clkc;
		  2'b11: rden <= rd_clkd;
			default: rden <= rd_clka;	
     endcase 	  
end
		
//写“读地址的初始地址[15:0]"	
PXI_WD addr_init_rd_L_Inst(
   .dataout  (addr_init_rd[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[54]) //aw54
   );	
//写"读地址的初始地址[28:16]"
PXI_WD addr_init_rd_H_Inst(
   .dataout  (addr_init_rd[31:16]),
   .datain   (LD[15:0]),
   .data_en  (AW[55]) //aw55
   );
//写"读数据个数[15:0]"
PXI_WD num_rd_ddr3_L_Inst(
   .dataout  (num_rd_ddr3[15:0]),
   .datain   (LD[15:0]),
   .data_en  (AW[56]) //aw56
   );
//写"读数据个数[27:16]"
PXI_WD num_rd_ddr3_H_Inst(
   .dataout  (num_rd_ddr3[31:16]),
   .datain   (LD[15:0]),
   .data_en  (AW[57]) //aw57
   );
//读‘触发’状态	
//读‘写地址产生’状态	
//读‘读停止’状态-采集完成状态
//读‘写停止’状态
PXI_RD DDR_wr_state_Inst(
   .dout  (LD[15:0]),
   .din   ({9'b0,trigged,read_stop_ddr3,write_stop_ddr3,wr_state_out}),
   .den  (AR[58])     //ar58
   ); 
//读"读数据个数[15:0]"
PXI_RD cnt_num_rd_L_Inst(
   .dout  (LD[15:0]),
   .din   (cnt_num_rd[15:0]),
   .den  (AR[59])     //ar59
   );	
//读"读数据个数[26:16]"
PXI_RD cnt_num_rd_H_Inst(
   .dout  (LD[15:0]),
   .din   ({5'b00000,cnt_num_rd[26:16]}),
   .den  (AR[60])     //ar60
   );
	
//读通道数据
////CHA
//PXI_RD d_rfifo_Inst0(
//   .dout  (LD[15:0]),
//   .din   (d_rfifo[15:0]),
//   .den  (DMAR[2])   //dmar2
//   );		
////CHB
//PXI_RD d_rfifo_Inst1(
//   .dout  (LD[15:0]),
//   .din   (d_rfifo[31:16]),
//   .den  (DMAR[3])   //dmar3
//   );
////CHC
//PXI_RD d_rfifo_Inst2(
//   .dout  (LD[15:0]),
//   .din   (d_rfifo[47:32]),
//   .den  (DMAR[4])   //dmar4
//   );
////CHD	
//PXI_RD d_rfifo_Inst3(
//   .dout  (LD[15:0]),
//   .din   (d_rfifo[63:48]),
//   .den  (DMAR[5])   //dmar5
//   );

//CHA
PXI_RD d_rfifo_Inst0(
   .dout  (LD[15:0]),
   .din   (d_rfifo[15:0]),
   .den  (AR[80])   //ar80
   );		
//CHB
PXI_RD d_rfifo_Inst1(
   .dout  (LD[15:0]),
   .din   (d_rfifo[31:16]),
   .den  (AR[81])   //ar81
   );
//CHC
PXI_RD d_rfifo_Inst2(
   .dout  (LD[15:0]),
   .din   (d_rfifo[47:32]),
   .den  (AR[82])   //ar82
   );
//CHD	
PXI_RD d_rfifo_Inst3(
   .dout  (LD[15:0]),
   .din   (d_rfifo[63:48]),
   .den  (AR[83])   //ar83
   );
	
DDR3_APP_ctrl(
    .rxclk(adc_clk_out1), 								  //数据同步时钟
    .rst_rx(rst_rx_ddr3),                         //aw45    active low 复位
    .data_to_ram(data_to_ram_dly1[127:0]),        //ADC输出数据打一拍（原始数据）or 通道补偿后数据
    .syn_en_ad(fifo_all_wen_dly1),                //ADC输出写使能打一拍
    .auto_rd_en(auto_rd_en),                      //触发系统输出 
    
	 .clk_ddr3(ui_clk), 									  //ddr_app_clk_in    	
    .phy_init_done(init_calib_complete),          //ar47    读状态 LD[4]
    .rd_fifo_ready(rd_fifo_ready),                //ar47    读状态 LD[5]
    .num_rd_r_o(num_rd_r_o),                      //ar47    读状态 LD[6]            
    .DIMMdepth_ctrl(DIMMdepth_ctrl[3:0]),         //aw49    存储深度控制
    .wen_ddr3(wen_ddr3),                          //aw50    写
    .addr_wr_init(addr_wr_init[7:0]),             //aw51    偏移地址
    .ren_ddr3(ren_ddr3),                          //aw52    读	    
	 .ren_rfifo_ddr3(rden),                        //aw53       后端FIFO读   
    .addr_init_rd(addr_init_rd[28:0]),            //aw54 aw55  读地址的初始地址
    .num_rd_ddr3(num_rd_ddr3[27:0]), 				  //aw56 aw57  读数据的个数
    .wr_state_out(wr_state_out), 					  //ar58       写状态 LD[3:0]
	 //DDR_APP
	 .app_rdy(app_rdy),                            //in       
    .app_wdf_rdy(app_wdf_rdy), 						  //in
    .app_rd_data(app_rd_data[511:0]), 				  //in
    .app_rd_data_valid(app_rd_data_valid),        //in	  
    .app_wdf_wren(app_wdf_wren),                  //out
    .app_wdf_data(app_wdf_data[511:0]),           //out
    .app_wdf_mask(app_wdf_mask[63:0]),            //out
    .app_wdf_end(app_wdf_end),                    //out
    .app_addr(app_addr[28:0]),                    //out
    .app_cmd(app_cmd[2:0]),                       //out
    .app_en(app_en),                              //out
	 
	 .cnt_num_rd(cnt_num_rd[26:0]),                //ar59 ar60	读数据的个数
    .addr_trig_ddr3(addr_trig_ddr3),       		  //           触发地址出来
    .d_rfifo(d_rfifo),                            //dmar2 dmar3 dmar4 dmar5 DMA方式读通道数据
    .DDR3_state_t(DDR3_state[3:0]),               //ar47读状态 LD[3:0]
	 .dout_fifo_adc(dout_fifo_adc),                //前端FIFO出来数据512bit（测试用）
	 .write_stop_ddr3(write_stop_ddr3),            //ar58读状态 LD[5]
	 .begin_wr_ddr3(begin_wr_ddr3),                //开始写ddr，送到触发系统
	 .read_stop_ddr3(read_stop_ddr3)		           //ar58读状态 LD[4]
);


/*****************************************
**name:DDR_ctrl
**propose:例化IP核控制DDR 
**author:wangqi
**time:2017.03.02
*****************************************/

//DDR复位
PXI_WD_1bit dimm_sys_rst_Inst(
   .dataout  (dimm_sys_rst),
   .datain   (LD[0]),
   .data_en  (AW[46])//aw46      
   );	
 

ddr3_ctrl # (

   //***************************************************************************
   // The following parameters refer to width of various ports
   //***************************************************************************
   .BANK_WIDTH                    (3),
                                     // # of memory Bank Address bits.
   .CK_WIDTH                      (1),
                                     // # of CK/CK# outputs to memory.
   .COL_WIDTH                     (10),
                                     // # of memory Column Address bits.
   .CS_WIDTH                      (1),
                                     // # of unique CS outputs to memory.
   .nCS_PER_RANK                  (1),
                                     // # of unique CS outputs per rank for phy
   .CKE_WIDTH                     (1),
                                     // # of CKE outputs to memory.
   .DATA_BUF_ADDR_WIDTH           (5),
   .DQ_CNT_WIDTH                  (6),
                                     // = ceil(log2(DQ_WIDTH))
   .DQ_PER_DM                     (8),
   .DM_WIDTH                      (8),
                                     // # of DM (data mask)
   .DQ_WIDTH                      (64),
                                     // # of DQ (data)
   .DQS_WIDTH                     (8),
   .DQS_CNT_WIDTH                 (3),
                                     // = ceil(log2(DQS_WIDTH))
   .DRAM_WIDTH                    (8),
                                     // # of DQ per DQS
   .ECC                           ("OFF"),
   .DATA_WIDTH                    (64),
   .ECC_TEST                      ("OFF"),
   .PAYLOAD_WIDTH                 (64),
   .ECC_WIDTH                     (8),
   .MC_ERR_ADDR_WIDTH             (31),
   .nBANK_MACHS                   (4),
   .RANKS                         (1),
                                     // # of Ranks.
   .ODT_WIDTH                     (1),
                                     // # of ODT outputs to memory.
   .ROW_WIDTH                     (15),
                                     // # of memory Row Address bits.
   .ADDR_WIDTH                    (29),
                                     // # = RANK_WIDTH + BANK_WIDTH
                                     //     + ROW_WIDTH + COL_WIDTH;
                                     // Chip Select is always tied to low for
                                     // single rank devices
   .USE_CS_PORT                   (1),
                                     // # = 1, When Chip Select (CS#) output is enabled
                                     //   = 0, When Chip Select (CS#) output is disabled
                                     // If CS_N disabled, user must connect
                                     // DRAM CS_N input(s) to ground
   .USE_DM_PORT                   (1),
                                     // # = 1, When Data Mask option is enabled
                                     //   = 0, When Data Mask option is disbaled
                                     // When Data Mask option is disabled in
                                     // MIG Controller Options page, the logic
                                     // related to Data Mask should not get
                                     // synthesized
   .USE_ODT_PORT                  (1),
                                     // # = 1, When ODT output is enabled
                                     //   = 0, When ODT output is disabled
   .PHY_CONTROL_MASTER_BANK       (1),
                                     // The bank index where master PHY_CONTROL resides,
                                     // equal to the PLL residing bank

   //***************************************************************************
   // The following parameters are mode register settings
   //***************************************************************************
   .AL                            ("0"),
                                     // DDR3 SDRAM:
                                     // Additive Latency (Mode Register 1).
                                     // # = "0", "CL-1", "CL-2".
                                     // DDR2 SDRAM:
                                     // Additive Latency (Extended Mode Register).
   .nAL                           (0),
                                     // # Additive Latency in number of clock
                                     // cycles.
   .BURST_MODE                    ("8"),
                                     // DDR3 SDRAM:
                                     // Burst Length (Mode Register 0).
                                     // # = "8", "4", "OTF".
                                     // DDR2 SDRAM:
                                     // Burst Length (Mode Register).
                                     // # = "8", "4".
   .BURST_TYPE                    ("SEQ"),
                                     // DDR3 SDRAM: Burst Type (Mode Register 0).
                                     // DDR2 SDRAM: Burst Type (Mode Register).
                                     // # = "SEQ" - (Sequential),
                                     //   = "INT" - (Interleaved).
   .CL                            (6),
                                     // in number of clock cycles
                                     // DDR3 SDRAM: CAS Latency (Mode Register 0).
                                     // DDR2 SDRAM: CAS Latency (Mode Register).
   .CWL                           (5),
                                     // in number of clock cycles
                                     // DDR3 SDRAM: CAS Write Latency (Mode Register 2).
                                     // DDR2 SDRAM: Can be ignored
   .OUTPUT_DRV                    ("HIGH"),
                                     // Output Driver Impedance Control (Mode Register 1).
                                     // # = "HIGH" - RZQ/7,
                                     //   = "LOW" - RZQ/6.
   .RTT_NOM                       ("60"),
                                     // RTT_NOM (ODT) (Mode Register 1).
                                     // # = "DISABLED" - RTT_NOM disabled,
                                     //   = "120" - RZQ/2,
                                     //   = "60"  - RZQ/4,
                                     //   = "40"  - RZQ/6.
   .RTT_WR                        ("OFF"),
                                     // RTT_WR (ODT) (Mode Register 2).
                                     // # = "OFF" - Dynamic ODT off,
                                     //   = "120" - RZQ/2,
                                     //   = "60"  - RZQ/4,
   .ADDR_CMD_MODE                 ("1T" ),
                                     // # = "1T", "2T".
   .REG_CTRL                      ("OFF"),
                                     // # = "ON" - RDIMMs,
                                     //   = "OFF" - Components, SODIMMs, UDIMMs.
   .CA_MIRROR                     ("OFF"),
                                     // C/A mirror opt for DDR3 dual rank
   
   //***************************************************************************
   // The following parameters are multiplier and divisor factors for PLLE2.
   // Based on the selected design frequency these parameters vary.
   //***************************************************************************
   .CLKIN_PERIOD                  (5000),
                                     // Input Clock Period
   .CLKFBOUT_MULT                 (8),//4
                                     // write PLL VCO multiplier
   .DIVCLK_DIVIDE                 (2),//1
                                     // write PLL VCO divisor
   .CLKOUT0_DIVIDE                (2),
                                     // VCO output divisor for PLL output clock (CLKOUT0)
   .CLKOUT1_DIVIDE                (2),
                                     // VCO output divisor for PLL output clock (CLKOUT1)
   .CLKOUT2_DIVIDE                (32),
                                     // VCO output divisor for PLL output clock (CLKOUT2)
   .CLKOUT3_DIVIDE                (8),
                                     // VCO output divisor for PLL output clock (CLKOUT3)

   //***************************************************************************
   // Memory Timing Parameters. These parameters varies based on the selected
   // memory part.
   //***************************************************************************
   .tCKE                          (5625),
                                     // memory tCKE paramter in pS.
   .tFAW                          (30000),
                                     // memory tRAW paramter in pS.
   .tPRDI                         (1_000_000),
                                     // memory tPRDI paramter in pS.
   .tRAS                          (36000),
                                     // memory tRAS paramter in pS.
   .tRCD                          (13125),
                                     // memory tRCD paramter in pS.
   .tREFI                         (7800000),
                                     // memory tREFI paramter in pS.
   .tRFC                          (160000),
                                     // memory tRFC paramter in pS.
   .tRP                           (13125),
                                     // memory tRP paramter in pS.
   .tRRD                          (6000),
                                     // memory tRRD paramter in pS.
   .tRTP                          (7500),
                                     // memory tRTP paramter in pS.
   .tWTR                          (7500),
                                     // memory tWTR paramter in pS.
   .tZQI                          (128_000_000),
                                     // memory tZQI paramter in nS.
   .tZQCS                         (64),
                                     // memory tZQCS paramter in clock cycles.

   //***************************************************************************
   // Simulation parameters
   //***************************************************************************
   .SIM_BYPASS_INIT_CAL           ("OFF"),
                                     // # = "OFF" -  Complete memory init &
                                     //              calibration sequence
                                     // # = "SKIP" - Not supported
                                     // # = "FAST" - Complete memory init & use
                                     //              abbreviated calib sequence
   .SIMULATION                    ("FALSE"),
                                     // Should be TRUE during design simulations and
                                     // FALSE during implementations

   //***************************************************************************
   // The following parameters varies based on the pin out entered in MIG GUI.
   // Do not change any of these parameters directly by editing the RTL.
   // Any changes required should be done through GUI and the design regenerated.
   //***************************************************************************
   .BYTE_LANES_B0                 (4'b1111),
                                     // Byte lanes used in an IO column.
   .BYTE_LANES_B1                 (4'b1110),
                                     // Byte lanes used in an IO column.
   .BYTE_LANES_B2                 (4'b1111),
                                     // Byte lanes used in an IO column.
   .BYTE_LANES_B3                 (4'b0000),
                                     // Byte lanes used in an IO column.
   .BYTE_LANES_B4                 (4'b0000),
                                     // Byte lanes used in an IO column.
   .DATA_CTL_B0                   (4'b1111),
                                     // Indicates Byte lane is data byte lane
                                     // or control Byte lane. '1' in a bit
                                     // position indicates a data byte lane and
                                     // a '0' indicates a control byte lane
   .DATA_CTL_B1                   (4'b0000),
                                     // Indicates Byte lane is data byte lane
                                     // or control Byte lane. '1' in a bit
                                     // position indicates a data byte lane and
                                     // a '0' indicates a control byte lane
   .DATA_CTL_B2                   (4'b1111),
                                     // Indicates Byte lane is data byte lane
                                     // or control Byte lane. '1' in a bit
                                     // position indicates a data byte lane and
                                     // a '0' indicates a control byte lane
   .DATA_CTL_B3                   (4'b0000),
                                     // Indicates Byte lane is data byte lane
                                     // or control Byte lane. '1' in a bit
                                     // position indicates a data byte lane and
                                     // a '0' indicates a control byte lane
   .DATA_CTL_B4                   (4'b0000),
                                     // Indicates Byte lane is data byte lane
                                     // or control Byte lane. '1' in a bit
                                     // position indicates a data byte lane and
                                     // a '0' indicates a control byte lane

   .PHY_0_BITLANES                (48'h3FE_3FE_3FE_2FF),
   .PHY_1_BITLANES                (48'h3FE_43F_C3F_000),
   .PHY_2_BITLANES                (48'h3FE_3FE_3FE_2FF),
   .CK_BYTE_MAP                   (144'h00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_13),
   .ADDR_MAP                      (192'h000_138_112_133_120_124_12A_135_139_123_132_122_134_136_125_137),
   .BANK_MAP                      (36'h121_114_111),
   .CAS_MAP                       (12'h11B),
   .CKE_ODT_BYTE_MAP              (8'h00),
   .CKE_MAP                       (96'h000_000_000_000_000_000_000_131),
   .ODT_MAP                       (96'h000_000_000_000_000_000_000_11A),
   .CS_MAP                        (120'h000_000_000_000_000_000_000_000_000_113),
   .PARITY_MAP                    (12'h000),
   .RAS_MAP                       (12'h110),
   .WE_MAP                        (12'h115),
   .DQS_BYTE_MAP                  (144'h00_00_00_00_00_00_00_00_00_00_20_21_22_23_00_01_02_03),
   .DATA0_MAP                     (96'h034_037_033_031_036_038_035_032),
   .DATA1_MAP                     (96'h026_022_021_024_027_028_023_025),
   .DATA2_MAP                     (96'h011_014_019_013_012_018_017_016),
   .DATA3_MAP                     (96'h007_006_000_004_002_003_001_005),
   .DATA4_MAP                     (96'h236_235_237_231_232_233_238_234),
   .DATA5_MAP                     (96'h224_226_225_221_227_228_222_223),
   .DATA6_MAP                     (96'h214_211_219_218_213_212_217_216),
   .DATA7_MAP                     (96'h200_201_204_205_202_203_206_207),
   .DATA8_MAP                     (96'h000_000_000_000_000_000_000_000),
   .DATA9_MAP                     (96'h000_000_000_000_000_000_000_000),
   .DATA10_MAP                    (96'h000_000_000_000_000_000_000_000),
   .DATA11_MAP                    (96'h000_000_000_000_000_000_000_000),
   .DATA12_MAP                    (96'h000_000_000_000_000_000_000_000),
   .DATA13_MAP                    (96'h000_000_000_000_000_000_000_000),
   .DATA14_MAP                    (96'h000_000_000_000_000_000_000_000),
   .DATA15_MAP                    (96'h000_000_000_000_000_000_000_000),
   .DATA16_MAP                    (96'h000_000_000_000_000_000_000_000),
   .DATA17_MAP                    (96'h000_000_000_000_000_000_000_000),
   .MASK0_MAP                     (108'h000_209_215_229_239_009_015_029_039),
   .MASK1_MAP                     (108'h000_000_000_000_000_000_000_000_000),

   .SLOT_0_CONFIG                 (8'b0000_0001),
                                     // Mapping of Ranks.
   .SLOT_1_CONFIG                 (8'b0000_0000),
                                     // Mapping of Ranks.
   .MEM_ADDR_ORDER                ("BANK_ROW_COLUMN"),
   //***************************************************************************
   // IODELAY and PHY related parameters
   //***************************************************************************
   .IODELAY_HP_MODE               ("ON"),
                                     // to phy_top
   .IBUF_LPWR_MODE                ("OFF"),
                                     // to phy_top
   .DATA_IO_IDLE_PWRDWN           ("ON"),
                                     // # = "ON", "OFF"
   .DATA_IO_PRIM_TYPE             ("HP_LP"),
                                     // # = "HP_LP", "HR_LP", "DEFAULT"
   .CKE_ODT_AUX                   ("FALSE"),
   .USER_REFRESH                  ("OFF"),
   .WRLVL                         ("ON"),
                                     // # = "ON" - DDR3 SDRAM
                                     //   = "OFF" - DDR2 SDRAM.
   .ORDERING                      ("NORM"),
                                     // # = "NORM", "STRICT", "RELAXED".
   .CALIB_ROW_ADD                 (16'h0000),
                                     // Calibration row address will be used for
                                     // calibration read and write operations
   .CALIB_COL_ADD                 (12'h000),
                                     // Calibration column address will be used for
                                     // calibration read and write operations
   .CALIB_BA_ADD                  (3'h0),
                                     // Calibration bank address will be used for
                                     // calibration read and write operations
   .TCQ                           (100),
   .IODELAY_GRP                   ("IODELAY_MIG"),
                                     // It is associated to a set of IODELAYs with
                                     // an IDELAYCTRL that have same IODELAY CONTROLLER
                                     // clock frequency.
   .SYSCLK_TYPE                   ("NO_BUFFER"),
                                     // System clock type DIFFERENTIAL or SINGLE_ENDED
   .REFCLK_TYPE                   ("USE_SYSTEM_CLOCK"),
                                     // Reference clock type DIFFERENTIAL or SINGLE_ENDED
   .CMD_PIPE_PLUS1                ("ON"),
                                     // add pipeline stage between MC and PHY
   .DRAM_TYPE                       ("DDR3"),
   .CAL_WIDTH                     ("HALF"),
   .STARVE_LIMIT                  (2),
                                     // # = 2,3,4.
   //***************************************************************************
   // Referece clock frequency parameters
   //***************************************************************************
   .REFCLK_FREQ                   (200.0),
                                     // IODELAYCTRL reference clock frequency
   .DIFF_TERM_REFCLK              ("TRUE"),
                                     // Differential Termination for idelay
                                     // reference clock input pins
   //***************************************************************************
   // System clock frequency parameters
   //***************************************************************************
   .tCK                           (2500),
                                     // memory tCK paramter.
                                     // # = Clock Period in pS.
   .nCK_PER_CLK                   (4),
                                     // # of memory CKs per fabric CLK
   .DIFF_TERM_SYSCLK              ("TRUE"),
                                     // Differential Termination for System
                                     // clock input pins

   
   //***************************************************************************
   // Debug parameters
   //***************************************************************************
   .DEBUG_PORT                      ("OFF"),
                                     // # = "ON" Enable debug signals/controls.
                                     //   = "OFF" Disable debug signals/controls.
      
   .RST_ACT_LOW                   (1)
                                     // =1 for active low reset,
                                     // =0 for active high.
   )
  u_ddr3_ctrl (

// Memory interface ports
     .ddr3_dq                        (ddr3_dq),
     .ddr3_dqs_n                     (ddr3_dqs_n),
     .ddr3_dqs_p                     (ddr3_dqs_p),
     .ddr3_addr                      (ddr3_addr),
     .ddr3_ba                        (ddr3_ba),
     .ddr3_ras_n                     (ddr3_ras_n),
     .ddr3_cas_n                     (ddr3_cas_n),
     .ddr3_we_n                      (ddr3_we_n),
     .ddr3_reset_n                   (ddr3_reset_n),
     .ddr3_ck_p                      (ddr3_ck_p),
     .ddr3_ck_n                      (ddr3_ck_n),
     .ddr3_cke                       (ddr3_cke),
     .ddr3_cs_n                      (ddr3_cs_n),
     .ddr3_dm                        (ddr3_dm),
     .ddr3_odt                       (ddr3_odt),
	  .sys_clk_i                      (clk_200M),//add
// Application interface ports
     .app_addr                       (app_addr),
     .app_cmd                        (app_cmd),
     .app_en                         (app_en),
     .app_wdf_data                   (app_wdf_data),
     .app_wdf_end                    (app_wdf_end),
     .app_wdf_mask                   (app_wdf_mask),
     .app_wdf_wren                   (app_wdf_wren),
     .app_rd_data                    (app_rd_data),
     .app_rd_data_end                (app_rd_data_end),
     .app_rd_data_valid              (app_rd_data_valid),
     .app_rdy                        (app_rdy),
     .app_wdf_rdy                    (app_wdf_rdy),
     .app_sr_req                     (),
     .app_sr_active                  (),
     .app_ref_req                    (),
     .app_ref_ack                    (),
     .app_zq_req                     (),
     .app_zq_ack                     (),
     .ui_clk                         (ui_clk),
     .ui_clk_sync_rst                (),
     .init_calib_complete            (init_calib_complete),
     .sys_rst                        (dimm_sys_rst)
    );


/*****************************************
**name:eeprom_ctrl
**propose:I2C读写eeprom 
**author:wangqi
**time:2017.03.13
*****************************************/
I2C_Ctrl I2C_Ctrl_Inst0(
    .aw_port1(AW[92]), //aw92
    .aw_port2(AW[93]), //aw93
	 .aw_port3(AW[94]), //aw94
	 .aw_port4(AW[95]), //aw95
	 .aw_port5(AW[96]), //aw96
	 .aw_port6(AW[97]), //aw97
	 .data(LD),
	 .clkin1M(clk_1M),
	 .clkin100M(clk_100M),
    .ar_port(AR[97]),  //ar97
	 .SDA(eeprom1_SDA),
	 .SCL(eeprom1_SCl)
);

I2C_Ctrl I2C_Ctrl_Inst1(
    .aw_port1(AW[98]), //aw98
    .aw_port2(AW[99]), //aw99
	 .aw_port3(AW[100]), //aw100
	 .aw_port4(AW[101]), //aw101
	 .aw_port5(AW[102]), //aw102
	 .aw_port6(AW[103]), //aw103
	 .data(LD),
	 .clkin1M(clk_1M),
	 .clkin100M(clk_100M),
    .ar_port(AR[103]),  //ar103
	 .SDA(eeprom2_SDA),
	 .SCL(eeprom2_SCl)
);


/*****************************************
**name:Channal Flatness Compensation
**propose:通道平坦度校正及补偿
**author:wangqi
**time:2017.03.13
*****************************************/
//channal_compensate_system channal_compensate_system_inst(
//    .data_in(data_from_ADC)//in
//    .data_out(data_from_compensation) //out
//
//
//
//
//
//
//
//
//
//
//);

endmodule
