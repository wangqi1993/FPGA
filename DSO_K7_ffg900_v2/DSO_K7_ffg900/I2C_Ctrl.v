`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:37:14 03/13/2017 
// Design Name: 
// Module Name:    I2C_Ctrl 
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
module I2C_Ctrl(
      input aw_port1,
		input aw_port2,
		input aw_port3,
		input aw_port4,
		input aw_port5,
		input	aw_port6,
		inout [15:0] data,
		input clkin1M,
		input clkin100M,
		input ar_port,
		inout SDA,
	   output SCL	 
	 );

//写
wire start;
wire dir;
PXI_WD_1bit start_Inst(
   .dataout  (start),
   .datain   (data[0]),
   .data_en  (aw_port1)//aw_port1      
   );
PXI_WD_1bit dir_Inst(
   .dataout  (dir),
   .datain   (data[0]),
   .data_en  (aw_port2)//aw_port2      
   );

//控制数据、地址加载
wire [31:0] M24M02_data;
w_r_mod32 w_r_mod32_Inst0(
		.aw_r_in_L(aw_port3),//aw_port3
		.aw_r_in_H(aw_port4),//aw_port4
		.clkin(clkin100M),
		.busdata(data),
		.rstout(M24M02_data)
		);
wire [31:0] M24M02_addr;
w_r_mod32 w_r_mod32_Inst1(
		.aw_r_in_L(aw_port5),//aw_port5
		.aw_r_in_H(aw_port6),//aw_port6
		.clkin(clkin100M),
		.busdata(data),
		.rstout(M24M02_addr)
		);
//i2cwr
wire sdadir;
wire sdain,sdaout;
wire eeprom_over;
wire [7:0] eeprom_rd_data;

assign sdain = sdadir ? 1'bz : SDA;
assign SDA = sdadir ? sdaout : 1'bz; 

i2cwr i2cwr_inst(
    .start(start),
	 .clk(clkin1M),
	 .dir(dir),
	 .sdain(sdain),
	 .data(M24M02_data[7:0]),
	 .addr(M24M02_addr[15:0]),
	 .sda(sdaout),
	 .scl(SCL),
	 .sdadir(sdadir),
	 .over(eeprom_over),
    .outdata(eeprom_rd_data)
);

//读
PXI_RD eeprom_Inst(
   .dout  (data[15:0]),
   .din   ({7'b0000000,eeprom_over,eeprom_rd_data[7:0]}),
   .den  (ar_port)     //ar_port
   );





endmodule
