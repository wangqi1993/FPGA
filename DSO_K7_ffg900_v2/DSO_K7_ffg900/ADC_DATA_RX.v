`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:30 01/16/2017 
// Design Name: 
// Module Name:    ADC_DATA_RX 目的完成ADC数据接收，及控制采集模式：普通、扫描、峰值。
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
module ADC_DATA_RX(
		input	count_clr,         //active low
		input peak_mode,         //赋值给peak_mode_temp,用来打开和关闭峰值检测
		input extract_enable,  
		input [31:0] div_n,
		input [31:0] div_n_maxmin,	
		
		input scan_rst,
		input [31:0] div_n_scan,
		input rden_scan,
		output [15:0] scan_dout,
		output scan_over,
		output scan_stop,		

    	input	rx_clk1,//ab   接收时用2路时钟接收来，其余时间用rx_clk1
		input rx_clk2,//cd
		input [7:0]		AHD,
		input [7:0]		AHDN,								
		input [7:0]		ALD,								
		input [7:0]		ALDN,										
		input [7:0]		BHD,		
		input [7:0]		BHDN,		
		input [7:0]		BLD,		
		input [7:0]		BLDN,			
		input [7:0]		CHD,		
		input [7:0]		CHDN,		
		input [7:0]		CLD,		
		input [7:0]		CLDN,		
		input [7:0]		DHD,		
		input [7:0]		DHDN,		
		input [7:0]		DLD,		
		input [7:0]		DLDN,
		input [1:0]		data_format_choose_from_ADC,
		
      input [15:0]   DUC_Factor_WR_Addr,
		input [15:0]   DUC_Factor_WR_Data,
		input          DUC_Factor_WR_Rst,

		output reg  [127:0] rx_CH_DCBA_fix_out/* synthesis syn_keep = 1 */,
		output reg  fifo_all_wen/* synthesis syn_keep = 1 */,  
		
		output Signal_Trig_test//FOR TEST
		);


//打拍-rx_clk1
reg count_clr_dly1,count_clr_dly2;               //清除数据
reg extract_enable_dly1,extract_enable_dly2;
reg peak_mode_dly2,peak_mode_dly1;
reg [31:0] div_n_dly2,div_n_dly1;
reg [31:0] div_n_maxmin_dly2,div_n_maxmin_dly1;

always @ (posedge rx_clk1)
begin
  count_clr_dly1 <= count_clr;                   //复位用来清除数据
  count_clr_dly2 <= count_clr_dly1;
  
  extract_enable_dly1 <= extract_enable;         //抽点、直通
  extract_enable_dly2 <= extract_enable_dly1; 
  
  peak_mode_dly1 <= peak_mode;                   //峰值模式
  peak_mode_dly2 <= peak_mode_dly1;
  
  div_n_dly1 <= div_n;                           //normal-抽点
  div_n_dly2 <= div_n_dly1; 
  
  div_n_maxmin_dly1 <= div_n_maxmin;             //peak
  div_n_maxmin_dly2 <= div_n_maxmin_dly1;  
end


/*****************************************
**name:Diff_To_Single
**propose:引脚上差分信号转单端信号
**author:wangqi
**time:2017.01.16
*****************************************/
wire [31:0] data_rx_A_out;
wire [31:0] data_rx_B_out;
wire [31:0] data_rx_C_out;
wire [31:0] data_rx_D_out;

Diff_To_Single Diff_To_Single_Inst(
	.rx_clk1(rx_clk1),//为什么接收时要2路时钟，FPGA时钟手册MRCC只管包括自己和相邻的3个BANK
	.rx_clk2(rx_clk2),
	.rx_reset(count_clr_dly2),
	.AHD(AHD),   
	.AHDN(AHDN),	
	.ALD(ALD),	  
	.ALDN(ALDN),	
	.BHD(BHD),	  
	.BHDN(BHDN),	
	.BLD(BLD),	  
	.BLDN(BLDN),	
	.CHD(CHD),	  
   .CHDN(CHDN),	
   .CLD(CLD),	  
   .CLDN(CLDN),	
   .DHD(DHD),	  
   .DHDN(DHDN),	
   .DLD(DLD),	  
   .DLDN(DLDN),
	//数据输出
	.data_rx_A_out(data_rx_A_out), //1通道：//A:N+12--N+4--N+8--N     //2通道：//A:N+6--N+2--N+4--N    //4通道：//N+3--N+1--N+2--N  （PXI没有4通道）
	.data_rx_B_out(data_rx_B_out),         //B:N+14--N+6--N+10--N+2          //B:N+7--N+3--N+5--N+1          //M+3--M+1--M+2--M
	.data_rx_C_out(data_rx_C_out),         //C:N+13--N+5--N+9--N+1           //C:M+6--M+2--M+4--M            //U+3--U+1--U+2--U
	.data_rx_D_out(data_rx_D_out)          //D:N+15--N+7--N+11--N+3          //D:M+7--M+3--M+5--M+1          //V+3--V+1--V+2--V
	);


/*****************************************
**name:硬件拼数
**propose:单通道采集ABCD 4核           data_format0
          双通道采集AB CD  2核         data_format1
          4通道采集 A B C D  单核      data_format2
**author:wangqi
**time:2017.04.18
*****************************************/
reg [127:0] data_rx_NEW_out;//{D,C,B,A}排列

parameter data_format0=2'b00,data_format1=2'b01,data_format2=2'b10;

always@(posedge rx_clk1)//-clk1
begin	
case(data_format_choose_from_ADC)//非阻塞赋值
	data_format0 :  data_rx_NEW_out
						  ={data_rx_D_out[31:24],data_rx_D_out[15:8],data_rx_D_out[23:16],data_rx_D_out[7:0],//N+15--N+11--N+7--N+3
						    data_rx_B_out[31:24],data_rx_B_out[15:8],data_rx_B_out[23:16],data_rx_B_out[7:0],//N+14--N+10--N+6--N+2
                      data_rx_C_out[31:24],data_rx_C_out[15:8],data_rx_C_out[23:16],data_rx_C_out[7:0],//N+13--N+9--N+5--N+1	
                      data_rx_A_out[31:24],data_rx_A_out[15:8],data_rx_A_out[23:16],data_rx_A_out[7:0]};//N+12--N+8--N+4--N    
											  
   data_format1 :  data_rx_NEW_out
						  ={data_rx_D_out[31:24],data_rx_D_out[15:8],data_rx_D_out[23:16],data_rx_D_out[7:0],//M+7--M+5--M+3--M+1 
						    data_rx_C_out[31:24],data_rx_C_out[15:8],data_rx_C_out[23:16],data_rx_C_out[7:0],//M+6--M+4--M+2--M   
                      data_rx_B_out[31:24],data_rx_B_out[15:8],data_rx_B_out[23:16],data_rx_B_out[7:0],//N+7--N+5--N+3--N+1	
                      data_rx_A_out[31:24],data_rx_A_out[15:8],data_rx_A_out[23:16],data_rx_A_out[7:0]};//N+6--N+4--N+2--N   
	//data_format2效果同data_format1										  
	data_format2 :  data_rx_NEW_out						  
						  ={data_rx_D_out[31:24],data_rx_D_out[15:8],data_rx_D_out[23:16],data_rx_D_out[7:0],//V+3--V+2--V+1--V  （PXI没有4通道）
						    data_rx_C_out[31:24],data_rx_C_out[15:8],data_rx_C_out[23:16],data_rx_C_out[7:0],//U+3--U+2--U+1--U
                      data_rx_B_out[31:24],data_rx_B_out[15:8],data_rx_B_out[23:16],data_rx_B_out[7:0],//M+3--M+2--M+1--M	
                      data_rx_A_out[31:24],data_rx_A_out[15:8],data_rx_A_out[23:16],data_rx_A_out[7:0]};//N+3--N+2--N+1--N  
											  
	default:        data_rx_NEW_out
						  ={data_rx_D_out[31:0],data_rx_C_out[31:0],data_rx_B_out[31:0],data_rx_A_out[31:0]};//不拼数,软件去拼
endcase
end

/*****************************************
**name:函数发生器-锯齿波
**propose:测试
**author:wangqi
**time:2017.04.8
*****************************************/
wire [127:0] Signal_Data;
//wire Signal_Trig_test;
Signal_Generator Signal_Generator_Inst(
   .clkin(rx_clk1),
   .dataout(Signal_Data),
	.trigout(Signal_Trig_test)
	);
	

/*****************************************
**name:程控多速率处理系统
**propose:1.多倍抽点系统（下变频-采样频率）（NDC）
**        2.多倍插值系统（上变频-采样频率）（NUC）
**        3.只考虑PXI的实时模式2通道
**author:wangqi
**time:2017.04.21
*****************************************/
//wire [127:0] data_NDC_NUC_out;
//
//Multi_Rate_Processing_System Multi_Rate_Processing_System_Inst(
////插值
//	.DUC_Factor_WR_Addr(DUC_Factor_WR_Addr),
//	.DUC_Factor_WR_Data(DUC_Factor_WR_Data),
//   .DUC_Factor_WR_Rst(DUC_Factor_WR_Rst),
////
//	.reset(),
//	.clkin(rx_clk1),
//	.data_format(data_format_choose_from_ADC),
//	.data_in(data_rx_NEW_out),
//	.clkout(),
//	.data_out(data_NDC_NUC_out),	
//	.data_direction_ctrl()
//
//			
//);

/*****************************************
**name:scan
**propose:扫描模式控制-rx_clk1
**author:wangqi
**time:2017.02.24
*****************************************/
wire scan_rst;
wire [31:0] div_n_scan;
wire rden_scan;
wire [15:0] scan_dout;
wire scan_over;
wire scan_stop;

scan scan_inst0(
    .scan_rst(scan_rst), 
    .rxclk(rx_clk1), 
    .rxdata(data_rx_NEW_out[127:0]), 
    .div_n_maxmin(div_n_scan), 
    .rden_scan(rden_scan), 
    .scan_dout(scan_dout), 
    .scan_over(scan_over), 
    .scan_stop(scan_stop)
    );


/*****************************************
**name:normal_path
**propose:普通模式控制-rx_clk1、4倍抽点
**author:wangqi
**time:2017.02.24
*****************************************/  
wire [127:0] dataout_normal;

normal_path normal_path_inst0 (
    .data_clk(rx_clk1), 
    .div_n(div_n_dly2), 
    .cnt_clr(count_clr_dly2), 
    .data1in(data_rx_NEW_out[7:0]), 
    .data2in(data_rx_NEW_out[39:32]), 
    .data3in(data_rx_NEW_out[71:64]), 
    .data4in(data_rx_NEW_out[103:96]), 
    .dataout(dataout_normal[127:0]), 
    .wr_en(wr_en_normal)
    );


/*****************************************
**name:peakdetect_path
**propose:峰值模式控制-rx_clk1
**        始终工作在最高采样率
**author:wangqi
**time:2017.02.24
*****************************************/
wire [127:0] dataout_pk;
	
peakdetect_path peakdetect_path_inst0 (
    .DATA_CLK(rx_clk1), 
	 .CNTCLR(count_clr_dly2),
    .datain(data_rx_NEW_out[127:0]), 
    .div_n_maxmin(div_n_maxmin_dly2), 
    .wr_enable(wr_en_pk), 
    .dataout(dataout_pk[127:0])
    );

/*****************************************
**name:128bit数据送出
**propose:送出数据到DDR-rx_clk1
**author:wangqi
**time:2017.02.24
*****************************************/

//发送
always @ (posedge rx_clk1)
begin
	if (peak_mode_dly2)
			begin
			fifo_all_wen <= wr_en_pk;
			rx_CH_DCBA_fix_out[127:0] <= dataout_pk[127:0];					
			end
	else if(extract_enable_dly2)
			begin
			fifo_all_wen <= wr_en_normal;
			rx_CH_DCBA_fix_out[127:0] <= dataout_normal[127:0];			
			end
	else
			begin			
			fifo_all_wen <= 1'b1;
			rx_CH_DCBA_fix_out[127:0] <= data_rx_NEW_out[127:0];	
			//rx_CH_DCBA_fix_out[127:0] <= Signal_Data[127:0];//测试说明ADC没有配置时有时钟输出，数据为0
			end
end


endmodule



