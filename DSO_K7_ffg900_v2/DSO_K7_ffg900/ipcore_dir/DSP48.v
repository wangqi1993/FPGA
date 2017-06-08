////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.68d
//  \   \         Application: netgen
//  /   /         Filename: DSP48.v
// /___/   /\     Timestamp: Wed May 10 17:52:02 2017
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog E:/ISE_Project/PXI/DSO_K7_ffg900_v2/DSO_K7_ffg900/ipcore_dir/tmp/_cg/DSP48.ngc E:/ISE_Project/PXI/DSO_K7_ffg900_v2/DSO_K7_ffg900/ipcore_dir/tmp/_cg/DSP48.v 
// Device	: 7k325tffg900-2
// Input file	: E:/ISE_Project/PXI/DSO_K7_ffg900_v2/DSO_K7_ffg900/ipcore_dir/tmp/_cg/DSP48.ngc
// Output file	: E:/ISE_Project/PXI/DSO_K7_ffg900_v2/DSO_K7_ffg900/ipcore_dir/tmp/_cg/DSP48.v
// # of Modules	: 1
// Design Name	: DSP48
// Xilinx        : d:\Xilinx\14.6\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module DSP48 (
  clk, ce, pcin, a, b, acout, pcout, p
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input ce;
  input [47 : 0] pcin;
  input [7 : 0] a;
  input [7 : 0] b;
  output [29 : 0] acout;
  output [47 : 0] pcout;
  output [7 : 0] p;
  
  // synthesis translate_off
  
  wire \blk00000001/sig000000c5 ;
  wire \blk00000001/sig000000c4 ;
  wire \blk00000001/sig000000c3 ;
  wire \blk00000001/sig000000c2 ;
  wire \blk00000001/sig000000c1 ;
  wire \blk00000001/sig000000c0 ;
  wire \blk00000001/sig000000bf ;
  wire \blk00000001/sig000000be ;
  wire \blk00000001/sig000000bd ;
  wire \blk00000001/sig000000bc ;
  wire \blk00000001/sig000000bb ;
  wire \blk00000001/sig000000ba ;
  wire \blk00000001/sig000000b9 ;
  wire \blk00000001/sig000000b8 ;
  wire \blk00000001/sig000000b7 ;
  wire \blk00000001/sig000000b6 ;
  wire \blk00000001/sig000000b5 ;
  wire \blk00000001/sig000000b4 ;
  wire \blk00000001/sig000000b3 ;
  wire \blk00000001/sig000000b2 ;
  wire \blk00000001/sig000000b1 ;
  wire \blk00000001/sig000000b0 ;
  wire \blk00000001/sig000000af ;
  wire \blk00000001/sig000000ae ;
  wire \blk00000001/sig000000ad ;
  wire \blk00000001/sig000000ac ;
  wire \blk00000001/sig000000ab ;
  wire \blk00000001/sig00000072 ;
  wire \blk00000001/sig00000071 ;
  wire \blk00000001/sig00000070 ;
  wire \blk00000001/sig0000006f ;
  wire \blk00000001/sig0000006e ;
  wire \blk00000001/sig0000006d ;
  wire \blk00000001/sig0000006c ;
  wire \blk00000001/sig0000006b ;
  wire \blk00000001/sig0000006a ;
  wire \blk00000001/sig00000069 ;
  wire \blk00000001/sig00000068 ;
  wire \blk00000001/sig00000067 ;
  wire \blk00000001/sig00000066 ;
  wire \blk00000001/sig00000065 ;
  wire \blk00000001/sig00000064 ;
  wire \blk00000001/sig00000063 ;
  wire \blk00000001/sig00000062 ;
  wire \blk00000001/sig00000061 ;
  wire \NLW_blk00000001/blk00000004_PATTERNBDETECT_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_MULTSIGNOUT_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_UNDERFLOW_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_PATTERNDETECT_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_OVERFLOW_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_CARRYOUT<2>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_CARRYOUT<1>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_CARRYOUT<0>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<39>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<38>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<37>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<36>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<35>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<34>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<33>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<32>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<31>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<30>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<29>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<28>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<27>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<26>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<25>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<24>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<23>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<22>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<21>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<20>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<19>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<18>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<17>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<16>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<15>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<14>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<13>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<12>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<11>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<10>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<9>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<8>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<7>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<6>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<5>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<4>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<3>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<2>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<1>_UNCONNECTED ;
  wire \NLW_blk00000001/blk00000004_P<0>_UNCONNECTED ;
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001b  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000ae )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000001a  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000ad ),
    .Q(\blk00000001/sig000000bb )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000019  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000ad ),
    .Q(\blk00000001/sig000000bc )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000018  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000ad ),
    .Q(\blk00000001/sig000000bd )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000017  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000be )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000016  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000bf )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000015  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000c0 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000014  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000c1 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000013  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000c2 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000012  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000c3 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000011  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000c4 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000010  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000bb ),
    .Q(\blk00000001/sig000000b3 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000f  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000b4 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000e  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000bc ),
    .Q(\blk00000001/sig000000b5 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000d  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000b6 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000c  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000bd ),
    .Q(\blk00000001/sig000000b7 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000b  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000b8 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk0000000a  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000b9 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000009  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000ba )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000008  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000c5 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000007  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000b0 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000006  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000b1 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \blk00000001/blk00000005  (
    .C(clk),
    .CE(ce),
    .D(\blk00000001/sig000000af ),
    .Q(\blk00000001/sig000000b2 )
  );
  DSP48E1 #(
    .ACASCREG ( 2 ),
    .ADREG ( 0 ),
    .ALUMODEREG ( 1 ),
    .AREG ( 2 ),
    .AUTORESET_PATDET ( "NO_RESET" ),
    .A_INPUT ( "DIRECT" ),
    .BCASCREG ( 2 ),
    .BREG ( 2 ),
    .B_INPUT ( "DIRECT" ),
    .CARRYINREG ( 1 ),
    .CARRYINSELREG ( 1 ),
    .CREG ( 1 ),
    .DREG ( 0 ),
    .INMODEREG ( 1 ),
    .MASK ( 48'h3FFFFFFFFFFF ),
    .MREG ( 1 ),
    .OPMODEREG ( 1 ),
    .PATTERN ( 48'h000000000000 ),
    .PREG ( 1 ),
    .SEL_MASK ( "MASK" ),
    .SEL_PATTERN ( "PATTERN" ),
    .USE_DPORT ( "FALSE" ),
    .USE_MULT ( "MULTIPLY" ),
    .USE_PATTERN_DETECT ( "NO_PATDET" ),
    .USE_SIMD ( "ONE48" ))
  \blk00000001/blk00000004  (
    .PATTERNBDETECT(\NLW_blk00000001/blk00000004_PATTERNBDETECT_UNCONNECTED ),
    .RSTC(\blk00000001/sig000000af ),
    .CEB1(ce),
    .CEAD(\blk00000001/sig000000af ),
    .MULTSIGNOUT(\NLW_blk00000001/blk00000004_MULTSIGNOUT_UNCONNECTED ),
    .CEC(ce),
    .RSTM(\blk00000001/sig000000af ),
    .MULTSIGNIN(\blk00000001/sig000000af ),
    .CEB2(ce),
    .RSTCTRL(\blk00000001/sig000000af ),
    .CEP(ce),
    .CARRYCASCOUT(\blk00000001/sig000000ac ),
    .RSTA(\blk00000001/sig000000af ),
    .CECARRYIN(ce),
    .UNDERFLOW(\NLW_blk00000001/blk00000004_UNDERFLOW_UNCONNECTED ),
    .PATTERNDETECT(\NLW_blk00000001/blk00000004_PATTERNDETECT_UNCONNECTED ),
    .RSTALUMODE(\blk00000001/sig000000af ),
    .RSTALLCARRYIN(\blk00000001/sig000000af ),
    .CED(\blk00000001/sig000000af ),
    .RSTD(\blk00000001/sig000000af ),
    .CEALUMODE(ce),
    .CEA2(ce),
    .CLK(clk),
    .CEA1(ce),
    .RSTB(\blk00000001/sig000000af ),
    .OVERFLOW(\NLW_blk00000001/blk00000004_OVERFLOW_UNCONNECTED ),
    .CECTRL(ce),
    .CEM(ce),
    .CARRYIN(\blk00000001/sig000000ae ),
    .CARRYCASCIN(\blk00000001/sig000000af ),
    .RSTINMODE(\blk00000001/sig000000af ),
    .CEINMODE(ce),
    .RSTP(\blk00000001/sig000000af ),
    .ACOUT({acout[29], acout[28], acout[27], acout[26], acout[25], acout[24], acout[23], acout[22], acout[21], acout[20], acout[19], acout[18], 
acout[17], acout[16], acout[15], acout[14], acout[13], acout[12], acout[11], acout[10], acout[9], acout[8], acout[7], acout[6], acout[5], acout[4], 
acout[3], acout[2], acout[1], acout[0]}),
    .OPMODE({\blk00000001/sig000000b9 , \blk00000001/sig000000b8 , \blk00000001/sig000000b7 , \blk00000001/sig000000b6 , \blk00000001/sig000000b5 , 
\blk00000001/sig000000b4 , \blk00000001/sig000000b3 }),
    .PCIN({pcin[47], pcin[46], pcin[45], pcin[44], pcin[43], pcin[42], pcin[41], pcin[40], pcin[39], pcin[38], pcin[37], pcin[36], pcin[35], pcin[34]
, pcin[33], pcin[32], pcin[31], pcin[30], pcin[29], pcin[28], pcin[27], pcin[26], pcin[25], pcin[24], pcin[23], pcin[22], pcin[21], pcin[20], pcin[19]
, pcin[18], pcin[17], pcin[16], pcin[15], pcin[14], pcin[13], pcin[12], pcin[11], pcin[10], pcin[9], pcin[8], pcin[7], pcin[6], pcin[5], pcin[4], 
pcin[3], pcin[2], pcin[1], pcin[0]}),
    .ALUMODE({\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000ba , \blk00000001/sig000000ba }),
    .C({\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad }),
    .CARRYOUT({\blk00000001/sig000000ab , \NLW_blk00000001/blk00000004_CARRYOUT<2>_UNCONNECTED , \NLW_blk00000001/blk00000004_CARRYOUT<1>_UNCONNECTED 
, \NLW_blk00000001/blk00000004_CARRYOUT<0>_UNCONNECTED }),
    .INMODE({\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af }),
    .BCIN({\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , 
\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , 
\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , 
\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af }),
    .B({b[7], b[7], b[7], b[7], b[7], b[7], b[7], b[7], b[7], b[7], b[7], b[6], b[5], b[4], b[3], b[2], b[1], b[0]}),
    .BCOUT({\blk00000001/sig00000061 , \blk00000001/sig00000062 , \blk00000001/sig00000063 , \blk00000001/sig00000064 , \blk00000001/sig00000065 , 
\blk00000001/sig00000066 , \blk00000001/sig00000067 , \blk00000001/sig00000068 , \blk00000001/sig00000069 , \blk00000001/sig0000006a , 
\blk00000001/sig0000006b , \blk00000001/sig0000006c , \blk00000001/sig0000006d , \blk00000001/sig0000006e , \blk00000001/sig0000006f , 
\blk00000001/sig00000070 , \blk00000001/sig00000071 , \blk00000001/sig00000072 }),
    .D({\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , 
\blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad , \blk00000001/sig000000ad }),
    .P({p[7], p[6], p[5], p[4], p[3], p[2], p[1], p[0], \NLW_blk00000001/blk00000004_P<39>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<38>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<37>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<36>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<35>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<34>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<33>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<32>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<31>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<30>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<29>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<28>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<27>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<26>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<25>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<24>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<23>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<22>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<21>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<20>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<19>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<18>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<17>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<16>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<15>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<14>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<13>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<12>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<11>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<10>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<9>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<8>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<7>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<6>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<5>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<4>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<3>_UNCONNECTED , 
\NLW_blk00000001/blk00000004_P<2>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<1>_UNCONNECTED , \NLW_blk00000001/blk00000004_P<0>_UNCONNECTED }),
    .A({a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[7], a[6]
, a[5], a[4], a[3], a[2], a[1], a[0]}),
    .PCOUT({pcout[47], pcout[46], pcout[45], pcout[44], pcout[43], pcout[42], pcout[41], pcout[40], pcout[39], pcout[38], pcout[37], pcout[36], 
pcout[35], pcout[34], pcout[33], pcout[32], pcout[31], pcout[30], pcout[29], pcout[28], pcout[27], pcout[26], pcout[25], pcout[24], pcout[23], 
pcout[22], pcout[21], pcout[20], pcout[19], pcout[18], pcout[17], pcout[16], pcout[15], pcout[14], pcout[13], pcout[12], pcout[11], pcout[10], 
pcout[9], pcout[8], pcout[7], pcout[6], pcout[5], pcout[4], pcout[3], pcout[2], pcout[1], pcout[0]}),
    .ACIN({\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , 
\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , 
\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , 
\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , 
\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , 
\blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af , \blk00000001/sig000000af }),
    .CARRYINSEL({\blk00000001/sig000000b2 , \blk00000001/sig000000b1 , \blk00000001/sig000000b0 })
  );
  GND   \blk00000001/blk00000003  (
    .G(\blk00000001/sig000000af )
  );
  VCC   \blk00000001/blk00000002  (
    .P(\blk00000001/sig000000ad )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
