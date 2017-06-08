`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:56 01/16/2017 
// Design Name: 
// Module Name:    Diff_To_Single 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 数据链路：“差分信号(128)”-“单端信号(64)”-“IDDR原语(128)”-"SWAP P N(128)"-"位扩展（128）"-“打拍输出（128）”
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Diff_To_Single(
    	input	rx_clk1,
		input rx_clk2,
		input	rx_reset,
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
	   output reg [31:0] data_rx_A_out/* synthesis syn_keep = 1 */, 
	   output reg [31:0] data_rx_B_out/* synthesis syn_keep = 1 */,    
	   output reg [31:0] data_rx_C_out/* synthesis syn_keep = 1 */, 
	   output reg [31:0] data_rx_D_out/* synthesis syn_keep = 1 */		  	 
	 );

//控制逻辑          
assign	low  = 1'b0 ; 
assign	high = 1'b1 ; 



//差分转单端
wire	[7:0]	RX_AHD,//DATA FROM IBUFDS
				RX_ALD,	
				RX_BHD,	
				RX_BLD,	
				RX_CHD,	
				RX_CLD,	
				RX_DHD,	
				RX_DLD;
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))   //IBUFDS:CHANAL A
	ibuf_d_AHD0 (.I(AHD[0]), .IB(AHDN[0]), .O(RX_AHD[0]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_AHD1 (.I(AHD[1]), .IB(AHDN[1]), .O(RX_AHD[1]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_AHD2 (.I(AHD[2]), .IB(AHDN[2]), .O(RX_AHD[2]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_AHD3 (.I(AHD[3]), .IB(AHDN[3]), .O(RX_AHD[3]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_AHD4 (.I(AHD[4]), .IB(AHDN[4]), .O(RX_AHD[4]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_AHD5 (.I(AHD[5]), .IB(AHDN[5]), .O(RX_AHD[5]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_AHD6 (.I(AHD[6]), .IB(AHDN[6]), .O(RX_AHD[6]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_AHD7 (.I(AHD[7]), .IB(AHDN[7]), .O(RX_AHD[7]));
	
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_ALD0 (.I(ALD[0]), .IB(ALDN[0]), .O(RX_ALD[0]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_ALD1 (.I(ALD[1]), .IB(ALDN[1]), .O(RX_ALD[1]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_ALD2 (.I(ALD[2]), .IB(ALDN[2]), .O(RX_ALD[2]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_ALD3 (.I(ALD[3]), .IB(ALDN[3]), .O(RX_ALD[3]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_ALD4 (.I(ALD[4]), .IB(ALDN[4]), .O(RX_ALD[4]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_ALD5 (.I(ALD[5]), .IB(ALDN[5]), .O(RX_ALD[5]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_ALD6 (.I(ALD[6]), .IB(ALDN[6]), .O(RX_ALD[6]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_ALD7 (.I(ALD[7]), .IB(ALDN[7]), .O(RX_ALD[7]));

IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))	//IBUFDS:CHANAL B
	ibuf_d_BHD0 (.I(BHD[0]), .IB(BHDN[0]), .O(RX_BHD[0]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BHD1 (.I(BHD[1]), .IB(BHDN[1]), .O(RX_BHD[1]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BHD2 (.I(BHD[2]), .IB(BHDN[2]), .O(RX_BHD[2]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BHD3 (.I(BHD[3]), .IB(BHDN[3]), .O(RX_BHD[3]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BHD4 (.I(BHD[4]), .IB(BHDN[4]), .O(RX_BHD[4]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BHD5 (.I(BHD[5]), .IB(BHDN[5]), .O(RX_BHD[5]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BHD6 (.I(BHD[6]), .IB(BHDN[6]), .O(RX_BHD[6]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BHD7 (.I(BHD[7]), .IB(BHDN[7]), .O(RX_BHD[7]));
	
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BLD0 (.I(BLD[0]), .IB(BLDN[0]), .O(RX_BLD[0]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BLD1 (.I(BLD[1]), .IB(BLDN[1]), .O(RX_BLD[1]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BLD2 (.I(BLD[2]), .IB(BLDN[2]), .O(RX_BLD[2]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BLD3 (.I(BLD[3]), .IB(BLDN[3]), .O(RX_BLD[3]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BLD4 (.I(BLD[4]), .IB(BLDN[4]), .O(RX_BLD[4]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BLD5 (.I(BLD[5]), .IB(BLDN[5]), .O(RX_BLD[5]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BLD6 (.I(BLD[6]), .IB(BLDN[6]), .O(RX_BLD[6]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_BLD7 (.I(BLD[7]), .IB(BLDN[7]), .O(RX_BLD[7]));

IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))	//IBUFDS:CHANAL C
	ibuf_d_CHD0 (.I(CHD[0]), .IB(CHDN[0]), .O(RX_CHD[0]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CHD1 (.I(CHD[1]), .IB(CHDN[1]), .O(RX_CHD[1]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CHD2 (.I(CHD[2]), .IB(CHDN[2]), .O(RX_CHD[2]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CHD3 (.I(CHD[3]), .IB(CHDN[3]), .O(RX_CHD[3]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CHD4 (.I(CHD[4]), .IB(CHDN[4]), .O(RX_CHD[4]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CHD5 (.I(CHD[5]), .IB(CHDN[5]), .O(RX_CHD[5]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CHD6 (.I(CHD[6]), .IB(CHDN[6]), .O(RX_CHD[6]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CHD7 (.I(CHD[7]), .IB(CHDN[7]), .O(RX_CHD[7]));
	
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CLD0 (.I(CLD[0]), .IB(CLDN[0]), .O(RX_CLD[0]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CLD1 (.I(CLD[1]), .IB(CLDN[1]), .O(RX_CLD[1]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CLD2 (.I(CLD[2]), .IB(CLDN[2]), .O(RX_CLD[2]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CLD3 (.I(CLD[3]), .IB(CLDN[3]), .O(RX_CLD[3]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CLD4 (.I(CLD[4]), .IB(CLDN[4]), .O(RX_CLD[4]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CLD5 (.I(CLD[5]), .IB(CLDN[5]), .O(RX_CLD[5]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CLD6 (.I(CLD[6]), .IB(CLDN[6]), .O(RX_CLD[6]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_CLD7 (.I(CLD[7]), .IB(CLDN[7]), .O(RX_CLD[7]));

IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))	//IBUFDS:CHANAL D
	ibuf_d_DHD0 (.I(DHD[0]), .IB(DHDN[0]), .O(RX_DHD[0]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DHD1 (.I(DHD[1]), .IB(DHDN[1]), .O(RX_DHD[1]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DHD2 (.I(DHD[2]), .IB(DHDN[2]), .O(RX_DHD[2]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DHD3 (.I(DHD[3]), .IB(DHDN[3]), .O(RX_DHD[3]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DHD4 (.I(DHD[4]), .IB(DHDN[4]), .O(RX_DHD[4]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DHD5 (.I(DHD[5]), .IB(DHDN[5]), .O(RX_DHD[5]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DHD6 (.I(DHD[6]), .IB(DHDN[6]), .O(RX_DHD[6]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DHD7 (.I(DHD[7]), .IB(DHDN[7]), .O(RX_DHD[7]));	
	
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DLD0 (.I(DLD[0]), .IB(DLDN[0]), .O(RX_DLD[0]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DLD1 (.I(DLD[1]), .IB(DLDN[1]), .O(RX_DLD[1]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DLD2 (.I(DLD[2]), .IB(DLDN[2]), .O(RX_DLD[2]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DLD3 (.I(DLD[3]), .IB(DLDN[3]), .O(RX_DLD[3]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DLD4 (.I(DLD[4]), .IB(DLDN[4]), .O(RX_DLD[4]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DLD5 (.I(DLD[5]), .IB(DLDN[5]), .O(RX_DLD[5]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DLD6 (.I(DLD[6]), .IB(DLDN[6]), .O(RX_DLD[6]));
IBUFDS	#(.IOSTANDARD("LVDS_25"), .DIFF_TERM("TRUE"))
	ibuf_d_DLD7 (.I(DLD[7]), .IB(DLDN[7]), .O(RX_DLD[7]));

//16bit-32bit
//调用原语IDDR的降速,以及交换P N
wire	[7:0]	rx_chAHD_h,rx_chAHD_l,//DATA FROM IDDR
				rx_chALD_h,rx_chALD_l,
				rx_chBHD_h,rx_chBHD_l,
				rx_chBLD_h,rx_chBLD_l,
				rx_chCHD_h,rx_chCHD_l,
				rx_chCLD_h,rx_chCLD_l,
				rx_chDHD_h,rx_chDHD_l,
				rx_chDLD_h,rx_chDLD_l;
				
parameter [7:0] SWAP_MASK_AH = 8'b00000000;	//CHANAL AH
parameter [7:0] SWAP_MASK_AL = 8'b00000000;	//CHANAL AL	
parameter [7:0] SWAP_MASK_BH = 8'b00000000;	//CHANAL BH
parameter [7:0] SWAP_MASK_BL = 8'b00000000;	//CHANAL BL	
parameter [7:0] SWAP_MASK_CH = 8'b00000000;	//CHANAL CH
parameter [7:0] SWAP_MASK_CL = 8'b00000000;	//CHANAL CL		
parameter [7:0] SWAP_MASK_DH = 8'b00000000;	//CHANAL DH
parameter [7:0] SWAP_MASK_DL = 8'b00000000; 	//CHANAL DL	

reg	[7:0]		rx_chAHD_h_reg,rx_chAHD_l_reg,//DATA FROM SWAP
					rx_chALD_h_reg,rx_chALD_l_reg,
					rx_chBHD_h_reg,rx_chBHD_l_reg,
					rx_chBLD_h_reg,rx_chBLD_l_reg,
					rx_chCHD_h_reg,rx_chCHD_l_reg,
					rx_chCLD_h_reg,rx_chCLD_l_reg,
					rx_chDHD_h_reg,rx_chDHD_l_reg,
					rx_chDLD_h_reg,rx_chDLD_l_reg;	

genvar i;
generate
for (i = 0; i <= 7; i = i + 1)
	begin: loop0
//AH
IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED"         数据为ADC双边沿进来，上升沿同时送2个数据到logic
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_chAHD (
      .Q1(rx_chAHD_l[i]), // 1-bit output for positive edge of clock 
      .Q2(rx_chAHD_h[i]), // 1-bit output for negative edge of clock
      .C(rx_clk1),   // 1-bit clock input
      .CE(high), // 1-bit clock enable input
      .D(RX_AHD[i]),   // 1-bit DDR data input
      //发的是低电平，这里反向了，就是高复位了
      .R(~rx_reset),   // 1-bit reset
      .S(low)    // 1-bit set
   );
//AL
IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_chALD (
      .Q1(rx_chALD_l[i]), // 1-bit output for positive edge of clock 
      .Q2(rx_chALD_h[i]), // 1-bit output for negative edge of clock
      .C(rx_clk1),   // 1-bit clock input
      .CE(high), // 1-bit clock enable input
      .D(RX_ALD[i]),   // 1-bit DDR data input
      .R(~rx_reset),   // 1-bit reset
      .S(low)    // 1-bit set
   );
//BH
IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_chBHD (
      .Q1(rx_chBHD_l[i]), // 1-bit output for positive edge of clock 
      .Q2(rx_chBHD_h[i]), // 1-bit output for negative edge of clock
      .C(rx_clk1),   // 1-bit clock input
      .CE(high), // 1-bit clock enable input
      .D(RX_BHD[i]),   // 1-bit DDR data input
      .R(~rx_reset),   // 1-bit reset
      .S(low)    // 1-bit set
   );
//BL	
IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_chBLD (
      .Q1(rx_chBLD_l[i]), // 1-bit output for positive edge of clock 
      .Q2(rx_chBLD_h[i]), // 1-bit output for negative edge of clock
      .C(rx_clk1),   // 1-bit clock input
      .CE(high), // 1-bit clock enable input
      .D(RX_BLD[i]),   // 1-bit DDR data input
      .R(~rx_reset),   // 1-bit reset
      .S(low)    // 1-bit set
   );
//CH
IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_chCHD (
      .Q1(rx_chCHD_l[i]), // 1-bit output for positive edge of clock 
      .Q2(rx_chCHD_h[i]), // 1-bit output for negative edge of clock
      .C(rx_clk2),   // 1-bit clock input
      .CE(high), // 1-bit clock enable input
      .D(RX_CHD[i]),   // 1-bit DDR data input
      .R(~rx_reset),   // 1-bit reset
      .S(low)    // 1-bit set
   );
//CL	
IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_chCLD (
      .Q1(rx_chCLD_l[i]), // 1-bit output for positive edge of clock 
      .Q2(rx_chCLD_h[i]), // 1-bit output for negative edge of clock
      .C(rx_clk2),   // 1-bit clock input
      .CE(high), // 1-bit clock enable input
      .D(RX_CLD[i]),   // 1-bit DDR data input
      .R(~rx_reset),   // 1-bit reset
      .S(low)    // 1-bit set
   );
//DH			
IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_chDHD (
      .Q1(rx_chDHD_l[i]), // 1-bit output for positive edge of clock 
      .Q2(rx_chDHD_h[i]), // 1-bit output for negative edge of clock
      .C(rx_clk2),   // 1-bit clock input
      .CE(high), // 1-bit clock enable input
      .D(RX_DHD[i]),   // 1-bit DDR data input
      .R(~rx_reset),   // 1-bit reset
      .S(low)    // 1-bit set
   );
//DL
IDDR #(
      .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_chDLD (
      .Q1(rx_chDLD_l[i]), // 1-bit output for positive edge of clock 
      .Q2(rx_chDLD_h[i]), // 1-bit output for negative edge of clock
      .C(rx_clk2),   // 1-bit clock input
      .CE(high), // 1-bit clock enable input
      .D(RX_DLD[i]),   // 1-bit DDR data input
      .R(~rx_reset),   // 1-bit reset
      .S(low)    // 1-bit set
   );

//SWAP N P			
	always @ (posedge rx_clk1)			
		begin	
			rx_chAHD_h_reg[i] <= rx_chAHD_h[i] ^ SWAP_MASK_AH[i];	
			rx_chAHD_l_reg[i] <= rx_chAHD_l[i] ^ SWAP_MASK_AH[i];

			rx_chALD_h_reg[i] <= rx_chALD_h[i] ^ SWAP_MASK_AL[i];	
			rx_chALD_l_reg[i] <= rx_chALD_l[i] ^ SWAP_MASK_AL[i];
			
			rx_chBHD_h_reg[i] <= rx_chBHD_h[i] ^ SWAP_MASK_BH[i];	
			rx_chBHD_l_reg[i] <= rx_chBHD_l[i] ^ SWAP_MASK_BH[i];

			rx_chBLD_h_reg[i] <= rx_chBLD_h[i] ^ SWAP_MASK_BL[i];	
			rx_chBLD_l_reg[i] <= rx_chBLD_l[i] ^ SWAP_MASK_BL[i];		
		end	
	always @ (posedge rx_clk2)			
		begin	
			rx_chCHD_h_reg[i] <= rx_chCHD_h[i] ^ SWAP_MASK_CH[i];	
			rx_chCHD_l_reg[i] <= rx_chCHD_l[i] ^ SWAP_MASK_CH[i];

			rx_chCLD_h_reg[i] <= rx_chCLD_h[i] ^ SWAP_MASK_CL[i];	
			rx_chCLD_l_reg[i] <= rx_chCLD_l[i] ^ SWAP_MASK_CL[i];

			rx_chDHD_h_reg[i] <= rx_chDHD_h[i] ^ SWAP_MASK_DH[i];	
			rx_chDHD_l_reg[i] <= rx_chDHD_l[i] ^ SWAP_MASK_DH[i];

			rx_chDLD_h_reg[i] <= rx_chDLD_h[i] ^ SWAP_MASK_DL[i];	
			rx_chDLD_l_reg[i] <= rx_chDLD_l[i] ^ SWAP_MASK_DL[i];		
		end
		
	end
	
endgenerate


//位扩展16bit
reg	[15:0]	aft_rx_chAHD_fix_reg1,			
					aft_rx_chALD_fix_reg1,	
					aft_rx_chBHD_fix_reg1,	
					aft_rx_chBLD_fix_reg1, 
					aft_rx_chCHD_fix_reg1,		
					aft_rx_chCLD_fix_reg1,	
					aft_rx_chDHD_fix_reg1,	
					aft_rx_chDLD_fix_reg1;	
					
always @ (posedge rx_clk1)
	begin
		aft_rx_chAHD_fix_reg1[15:8] <= rx_chAHD_h_reg;
		aft_rx_chAHD_fix_reg1[7:0]  <= rx_chAHD_l_reg;	
		aft_rx_chALD_fix_reg1[15:8] <= rx_chALD_h_reg;
		aft_rx_chALD_fix_reg1[7:0]  <= rx_chALD_l_reg;
		
		aft_rx_chBHD_fix_reg1[15:8] <= rx_chBHD_h_reg;
		aft_rx_chBHD_fix_reg1[7:0]  <= rx_chBHD_l_reg;	
		aft_rx_chBLD_fix_reg1[15:8] <= rx_chBLD_h_reg;
		aft_rx_chBLD_fix_reg1[7:0]  <= rx_chBLD_l_reg;			
	end
always @ (posedge rx_clk2)
	begin
		aft_rx_chCHD_fix_reg1[15:8] <= rx_chCHD_h_reg;
		aft_rx_chCHD_fix_reg1[7:0]  <= rx_chCHD_l_reg;	
		aft_rx_chCLD_fix_reg1[15:8] <= rx_chCLD_h_reg;
		aft_rx_chCLD_fix_reg1[7:0]  <= rx_chCLD_l_reg;
		
		aft_rx_chDHD_fix_reg1[15:8] <= rx_chDHD_h_reg;
		aft_rx_chDHD_fix_reg1[7:0]  <= rx_chDHD_l_reg;	
		aft_rx_chDLD_fix_reg1[15:8] <= rx_chDLD_h_reg;
		aft_rx_chDLD_fix_reg1[7:0]  <= rx_chDLD_l_reg;		
	end


//32bit DATA output
reg	[15:0]		aft_rx_chAHD_fix_reg2,	//REG FOR OUTPUT		
						aft_rx_chALD_fix_reg2,	
						aft_rx_chBHD_fix_reg2,	
						aft_rx_chBLD_fix_reg2, 
						aft_rx_chCHD_fix_reg2,		
						aft_rx_chCLD_fix_reg2,	
						aft_rx_chDHD_fix_reg2,	
						aft_rx_chDLD_fix_reg2;	
						
always @ (posedge rx_clk1)
	begin
		aft_rx_chAHD_fix_reg2 <= aft_rx_chAHD_fix_reg1;
		aft_rx_chALD_fix_reg2 <= aft_rx_chALD_fix_reg1;
                                                  
		aft_rx_chBHD_fix_reg2 <= aft_rx_chBHD_fix_reg1;
		aft_rx_chBLD_fix_reg2 <= aft_rx_chBLD_fix_reg1;
	end	
always @ (posedge rx_clk2)
	begin
		aft_rx_chCHD_fix_reg2 <= aft_rx_chCHD_fix_reg1;
		aft_rx_chCLD_fix_reg2 <= aft_rx_chCLD_fix_reg1;
                                                  
		aft_rx_chDHD_fix_reg2 <= aft_rx_chDHD_fix_reg1;
		aft_rx_chDLD_fix_reg2 <= aft_rx_chDLD_fix_reg1;
	end
	
	
//组成4路32位bit的输出
always @ (posedge rx_clk1)
	begin 
	  data_rx_A_out <= {aft_rx_chAHD_fix_reg2,aft_rx_chALD_fix_reg2};
	  data_rx_B_out <= {aft_rx_chBHD_fix_reg2,aft_rx_chBLD_fix_reg2}; 
	end
always @ (posedge rx_clk2)
	begin 
	  data_rx_C_out <= {aft_rx_chCHD_fix_reg2,aft_rx_chCLD_fix_reg2}; 
	  data_rx_D_out <= {aft_rx_chDHD_fix_reg2,aft_rx_chDLD_fix_reg2}; 
	end


endmodule
