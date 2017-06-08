`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:29 04/21/2017 
// Design Name: 
// Module Name:    Multi_Rate_Processing_System 
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
module Multi_Rate_Processing_System(
//插值系数
    input [15:0]   DUC_Factor_WR_Addr,
    input [15:0]   DUC_Factor_WR_Data,
	 input          DUC_Factor_WR_Rst,


    input 		 	reset,
	 input [1:0] 	data_format,
	 input 		 	clkin,
	 input [127:0] data_in,
	 output        clkout,
	 output reg [127:0] data_out,	
 	 input [15:0]   data_direction_ctrl//高8位控制插值系统，低八位控制抽点系统
	 );


//N+15--N+11--N+7--N+3
//N+14--N+10--N+6--N+2
//N+13--N+9--N+5--N+1
//N+12--N+8--N+4--N

//M+7--M+5--M+3--M+1 
//M+6--M+4--M+2--M 
//N+7--N+5--N+3--N+1
//N+6--N+4--N+2--N

//V+3--V+2--V+1--V
//U+3--U+2--U+1--U
//M+3--M+2--M+1--M
//N+3--N+2--N+1--N
	
wire clk_DUC_out;
wire [127:0] data_DUC_out;	 
//插值系统-工作在最高采样率-20倍插值
DUC_System DUC_System_Inst(
	.DUC_Factor_WR_Addr(DUC_Factor_WR_Addr),
	.DUC_Factor_WR_Data(DUC_Factor_WR_Data),
   .DUC_Factor_WR_Rst(DUC_Factor_WR_Rst),

   .cikin(clkin),//312.5M/16
   .reset(),
	.data_in(data_in),
	.clkout(clk_DUC_out),//
	.data_out(data_DDC_out)
);


wire clk_DDC_out;
wire [127:0] data_DDC_out;


//抽点系统-可调参数抽点-硬件分频抽点
DDC_System DDC_System_Inst(
	.cikin(clk_DUC_out),
	.reset(),
	.data_in(data_DUC_out),
	.clkout(clk_DDC_out),
	.data_out(data_DDC_out)
);




endmodule
