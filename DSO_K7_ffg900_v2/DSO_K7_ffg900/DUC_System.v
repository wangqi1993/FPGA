`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:26 04/26/2017 
// Design Name: 
// Module Name:    DUC_System �̶�4����ֵ
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
module DUC_System(
    input [15:0]   DUC_Factor_WR_Addr,
    input [15:0]   DUC_Factor_WR_Data,
	 input          DUC_Factor_WR_Rst,
	 
	 input  reset, 
	 input  clkin
	 
	 
	 
    );

//�䱶��



	 	 
//��ֵϵ��-40��
LUT LUT_Inst(
	.ADDRA(),
	.ENA(1),
	.CLKA(),
	.DOUTA(),
	);
	
//����ֽ��ӽṹ
DSP48 DSP48_Inst(
	.A(),
	.ACOUT(),
	.B(),
	.CLK(),
	.CE(),
	.PCIN(),
	.P(),
	.PCOUT()

	);






endmodule
