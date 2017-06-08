`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:01 03/03/2017 
// Design Name: 
// Module Name:    DDR3_APP_ctrl 
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
module DDR3_APP_ctrl(
    
	input rxclk,										 	 //from  data sync clk 
	input rst_rx/* synthesis syn_keep = 1 */,	 	 //复位ddr3的UI中的写入数据fifo以及地址fifo和状态机
	input [127:0] data_to_ram,							 //128bit*312.5M=5GByte/s数据流输入
	input syn_en_ad,										 //ADC输出写使能打一拍    
	input auto_rd_en ,                        	 //边读边写的时候的读使能(触发系统)  
                                  
	input clk_ddr3,                               //from DDR3 MIG，在4:1模式下为100M，在2:1模式下为200M，参见参数 nCK_PER_CLK 值，详见UG586  
	input phy_init_done,                          //ddr3硬件初始化完成标志，高有效   
	output rd_fifo_ready,								 //读后端fifo满标志
	output num_rd_r_o/* synthesis syn_keep = 1 */,//读数据个数的‘0’位

	input [3:0] DIMMdepth_ctrl,									//长存储的深度控制
	input wen_ddr3,													//UI写命令
	input [7:0] addr_wr_init /* synthesis syn_keep = 1 */,//送往ddr的偏移地址
	input ren_ddr3,													//UI读信号		
	input ren_rfifo_ddr3,											//小抽取fifo的读信号，上升沿有效
	input [28:0] addr_init_rd,										//读地址的初始地址
	input [27:0] num_rd_ddr3/* synthesis syn_keep = 1 */,	//读数据的个数
   output [26:0] cnt_num_rd/* synthesis syn_keep = 1 */,	//读数据的个数	
	output [3:0] wr_state_out,                            //写地址状态
	
	input app_rdy,														//MIG 命令准备信号，高有效，详见UG586	
	input app_wdf_rdy,												//MIG 数据准备信号，高有效，详见UG586           
	input [511:0] app_rd_data,										//MIG 读出数据，详见UG586
	input app_rd_data_valid,										//MIG读出数据有效信号	
	output app_wdf_wren,												//写入MIG的数据使能信号
	output  [511:0] app_wdf_data,									//写入MIG的数据
	output [63:0] app_wdf_mask,									//写入MIG的mask信号，为0
	output app_wdf_end,												//写入MIG的数据结束信号
	output [28:0] app_addr,											//写入MIG的地址信号
	output [2:0] app_cmd,											//写入MIG的命令信号	
	
	output app_en,														//写入MIG的命令使能信号
	output [26:0] addr_trig_ddr3,									//输出的触发地址信号
	output [63:0] d_rfifo,											//小抽取fifo的读出数据
	output reg [3:0] DDR3_state_t,    							//ddr控制器的状态
	output [511:0] dout_fifo_adc,
	output write_stop_ddr3,
	output begin_wr_ddr3,
	output read_stop_ddr3/* synthesis syn_keep = 1 */
 
 );
 
 
//写入MIG的mask信号，为0
assign app_wdf_mask = 64'b0;


/*****************************************
**name:
**propose:数据跨时钟域对接
**author:wangqi
**time:2017.03.03
*****************************************/
reg wen_ddr3_r1,wen_ddr3_r2;
reg ren_ddr3_r1,ren_ddr3_r2;
reg syn_en_ad_r,wen_fifo_adc;
reg [127:0] data_to_ram_dly1,din_fifo_adc;

always @(posedge rxclk)
begin
 wen_ddr3_r1 <= wen_ddr3;
 wen_ddr3_r2 <= wen_ddr3_r1;//写ddr打拍
 
 ren_ddr3_r1 <= ren_ddr3;
 ren_ddr3_r2 <= ren_ddr3_r1;//读ddr打拍
 
 syn_en_ad_r <= syn_en_ad & wen_ddr3_r1;
 wen_fifo_adc <= syn_en_ad_r;//FIFO读ADC
 
 data_to_ram_dly1[127:0] <= data_to_ram[127:0];//上面将数据有效信号打了一拍，这里实现数据和使能对齐
 din_fifo_adc[127:0] <= data_to_ram_dly1[127:0];
 
end


/*****************************************
**name:FIFO_adc_data_in
**propose:128bit to 512bit,数据跨时钟域对接模块
**author:wangqi
**time:2017.03.03
*****************************************/
wire [511:0] dout_fifo_adc;
assign app_wdf_data= dout_fifo_adc;

assign ren_fifo_adc = (wen_ddr3)?ren_addr_fifo:0;
assign app_wdf_end = ren_fifo_adc;
assign app_wdf_wren= ren_fifo_adc;
assign app_en = ren_addr_fifo;


FIFO_adc_data_in FIFO_adc_data_in_Inst (
  .rst(~rst_rx),   							// input rst
  .wr_clk(rxclk), 							// input wr_clk--312.5M/128bit
  .rd_clk(clk_ddr3), 						// input rd_clk--100M/512bit
  .din(din_fifo_adc), 						// input [127 : 0] din
  .wr_en(wen_fifo_adc), 					// input wr_en
  .rd_en(ren_fifo_adc), 					// input rd_en
  .prog_empty_thresh(9'h10), 				// input [8 : 0] prog_empty_thresh
  .prog_full_thresh(11'h7a0), 			// input [10 : 0] prog_full_thresh
  .dout(dout_fifo_adc), 					// output [511 : 0] dout
  .full(), 										// output full
  .empty(), 									// output empty
  .valid(), 									// output valid valid_fifo_adc
  .prog_full(), 								// output prog_full--写到数据大于等于门限时有效
  .prog_empty(pempty_fifo_adc) 			// output prog_empty--读到数据小于等于门限时有效
);


/*****************************************
**name:FIFO_addr_in
**propose:32bit to 32bit,地址跨时钟域对接模块
**author:wangqi
**time:2017.03.03
*****************************************/
wire [31:0] din_addr_fifo;
wire [31:0] dout_addr_fifo;

assign din_addr_fifo = {app_cmd_r,app_addr_r};

assign ren_addr_fifo = (wen_ddr3)?((~pempty_addr_fifo) && app_rdy&&(~pempty_fifo_adc) && app_wdf_rdy):((~pempty_addr_fifo) && app_rdy);
reg app_en_r;


FIFO_addr_in FIFO_addr_in_Inst (
  .rst(~rst_rx), 								// input rst
  .wr_clk(rxclk), 							// input wr_clk312.5M
  .rd_clk(clk_ddr3), 						// input rd_clk100M
  .din(din_addr_fifo), 						// input [31 : 0] din
  .wr_en(app_en_r), 							// input wr_en
  .rd_en(ren_addr_fifo), 					// input rd_en
  .prog_empty_thresh(9'h10), 				// input [8 : 0] prog_empty_thresh
  .prog_full_thresh(9'h1c0), 				// input [8 : 0] prog_full_thresh
  .dout(dout_addr_fifo), 					// output [31 : 0] dout
  .full(), 										// output full 
  .empty(), 									// output empty
  .valid(), 									// output valid
  .prog_full(), 								// output prog_full
  .prog_empty(pempty_addr_fifo) 			// output prog_empty
);

assign app_addr = dout_addr_fifo[28:0];
assign app_cmd = dout_addr_fifo[31:29];

/*****************************************
**name:wr_addr_gen
**propose:写地址产生
**author:wangqi
**time:2017.03.03
*****************************************/
wire [27:0] addr_wr_out;
reg begin_wr_ddr3/* synthesis syn_keep = 1 */;

wr_addr_gen wr_addr_gen_inst(
	.clk(rxclk),
	.rst(rst_rx),///0 active reset
	.DIMMdepth_ctrl(DIMMdepth_ctrl),
	.wr_en(begin_wr_ddr3),
	.sync_en(wen_fifo_adc),
	.auto_rd_en(auto_rd_en),
	.addr_wr_out(addr_wr_out),
	.syn_en_addr_wr(syn_en_addr_wr),
	.wr_state_out(wr_state_out),
	.write_stop(write_stop_ddr3),
	.addr_trig(addr_trig_ddr3)
);


/*****************************************
**name:rd_addr_gen
**propose:读地址产生
**author:wangqi
**time:2017.03.03
*****************************************/	
wire syn_en_addr_rd/* synthesis syn_keep = 1 */;
wire [28:0] addr_rd_out/* synthesis syn_keep = 1 */;
reg begin_rd_ddr3/* synthesis syn_keep = 1 */;

rd_addr_gen rd_addr_gen_inst(
    .clk(rxclk),
    .rst(rst_rx), ///0 active reset
	 .DIMMdepth_ctrl(DIMMdepth_ctrl),
    .rd_en(begin_rd_ddr3),
    .addr_init_rd(addr_init_rd),
    .num_rd(num_rd_ddr3),
    .addr_rd_out(addr_rd_out),
    .syn_en_addr(syn_en_addr_rd),
    .cnt_num_rd(cnt_num_rd),
    .num_rd_r_o(num_rd_r_o),
    .read_stop(read_stop_ddr3)
);


/*****************************************
**name:
**propose:DDR三段式状态机
**author:wangqi
**time:2017.03.03
*****************************************/
//状态机参数
localparam DDR3_IDLE       = 4'b0001;
localparam DDR3_WAIT       = 4'b0010;
localparam DDR3_WRITE      = 4'b0100;
localparam DDR3_READ       = 4'b1000;
(* FSM_ENCODING="ONE-HOT", SAFE_IMPLEMENTATION="YES" *)
reg [3:0] DDR3_state;
(* equivalent_reg_removal = "no" *)
reg phy_init_done_r;
reg [28:0] app_addr_r;
reg [2:0] app_cmd_r;
reg [7:0] addr_wr_init_r;
reg [3:0] DDR3_next_state;



//复位
always @ (posedge rxclk)
begin
	if(!rst_rx)
		DDR3_state <= DDR3_IDLE;
	else
		DDR3_state <= DDR3_next_state;
end
//状态转移
always @ (phy_init_done_r or wen_ddr3_r1 or ren_ddr3_r1 or ren_ddr3_r2 or wen_ddr3_r2 or  write_stop_ddr3 or read_stop_ddr3)
begin
	case(DDR3_state)
	DDR3_IDLE:
		begin
			if(phy_init_done_r == 1'b1)
				DDR3_next_state = DDR3_WAIT;
			else
				DDR3_next_state = DDR3_IDLE;
		end
	DDR3_WAIT:
		begin
			if(wen_ddr3_r1 == 1'b1 && wen_ddr3_r2 == 1'b0)//写使能
				DDR3_next_state = DDR3_WRITE;
			else if(ren_ddr3_r1 == 1'b1 && ren_ddr3_r2 == 1'b0)//读使能
				DDR3_next_state = DDR3_READ;
			else 
				DDR3_next_state = DDR3_WAIT;
		end
	DDR3_WRITE:
		begin
			if(write_stop_ddr3 == 1'b0)
				DDR3_next_state = DDR3_WRITE;
			else
				DDR3_next_state = DDR3_WAIT;
	   end
	DDR3_READ:
		begin
			if(read_stop_ddr3 == 1'b0)
				DDR3_next_state = DDR3_READ;
			else
				DDR3_next_state = DDR3_WAIT;
	   end
	default:
				DDR3_next_state = DDR3_IDLE;
		endcase
end
//状态输出,偏移地址打拍
always @(posedge rxclk) 
begin
 DDR3_state_t <= DDR3_state;
 addr_wr_init_r<=addr_wr_init;
end
//对应状态操作
always @(posedge rxclk) ///base on ADC synchronization clk 
begin
	if(!rst_rx)
		begin
			phy_init_done_r <= 1'b0;
			app_cmd_r <= 3'b000;
			app_addr_r <= 29'h0;
			app_en_r <= 1'b0;
			begin_wr_ddr3 <= 1'b0;
			begin_rd_ddr3 <= 1'b0;
		end
	else
		begin
			phy_init_done_r<= phy_init_done;
			case(DDR3_next_state)//对应状态操作
			DDR3_IDLE:
				begin
					app_cmd_r <= 3'b000;
					app_addr_r <= 29'h0;
					app_en_r <= 1'b0;
					begin_wr_ddr3 <= 1'b0;
					begin_rd_ddr3 <= 1'b0;
				end
			DDR3_WAIT:
				begin
					app_addr_r <= 29'h0;
					app_en_r <= 1'b0;
					app_cmd_r <= 3'b000;
					begin_wr_ddr3 <= 1'b0;
					begin_rd_ddr3 <= 1'b0;
				end
			DDR3_WRITE:
				begin
					app_cmd_r <= 3'b000;//写
					begin_wr_ddr3 <= 1'b1;
					app_addr_r <= {1'b0,addr_wr_out} + {1'b0,addr_wr_init_r[7:0],20'h0};//对应写数据突发长度为4*128bit
					app_en_r <= syn_en_addr_wr;//地址跨时钟域对接FIFO写使能-来自写地址产生
					begin_rd_ddr3 <= 1'b0;
					if(write_stop_ddr3 == 1'b0)
						begin_wr_ddr3 <= 1'b1;
					else 
						begin_wr_ddr3 <= 1'b0;
				end
			DDR3_READ:
				begin
					app_cmd_r <= 3'b001;//读
					app_addr_r <= {1'b0,addr_rd_out} + {1'b0,addr_wr_init_r[7:0],20'h0};//对应读数据突发长度为4*128bit
					app_en_r <= syn_en_addr_rd;//
					if(read_stop_ddr3 == 1'b0 && (~prog_full_512bto128b_dly2))
					   begin
						begin_rd_ddr3 <= 1'b1;
					   begin_wr_ddr3 <= 1'b0;						
						end
					else
					   begin
						begin_rd_ddr3 <= 1'b0;
					   begin_wr_ddr3 <= 1'b0;	
						end
				end
			default:
				begin
					app_cmd_r <= 3'b000;
					app_addr_r <= 29'h0;
					app_en_r <= 1'b0;
					begin_wr_ddr3 <= 1'b0;
					begin_rd_ddr3 <= 1'b0;
				end
			endcase
		end
end


/*****************************************
**name:FIFO_rd_DDR
**propose:512bit to 128bit,读DDR数据到FIFO
**author:wangqi
**time:2017.03.03
*****************************************/
wire [127:0] dout_512bto128b;
reg rd_en_rfifo;//

FIFO_rd_DDR FIFO_rd_DDR_Inst(
  .rst(~rst_rx), 						// input rst
  .wr_clk(clk_ddr3), 				// input wr_clk
  .rd_clk(rxclk), 					// input rd_clk
  .din(app_rd_data), 				// input [511 : 0] din
  .wr_en(app_rd_data_valid), 		// input wr_en
  .rd_en(rd_en_rfifo), 				// input rd_en
  .prog_empty_thresh(11'h040), 	// input [11 : 0] prog_empty_thresh
  .prog_full_thresh(10'h3a0), 	// input [9 : 0] prog_full_thresh
  .dout(dout_512bto128b), 			// output [127 : 0] dout
  .full(), 								// output full
  .empty(), 							// output empty
  .prog_full(prog_full_512bto128b), 	// output prog_full
  .prog_empty(prog_empty_512bto128b) 	// output prog_empty
  
);
//output prog 打拍
reg prog_full_512bto128b_dly1,prog_full_512bto128b_dly2;

always @(posedge rxclk or negedge rst_rx)
begin 
 if(rst_rx == 1'b0)
  begin
   prog_full_512bto128b_dly1 <= 1'b0;
   prog_full_512bto128b_dly2 <= 1'b0; 
  end
 else
  begin
   prog_full_512bto128b_dly1 <= prog_full_512bto128b;
   prog_full_512bto128b_dly2 <= prog_full_512bto128b_dly1;
  end
end 


/*****************************************
**name:
**propose:读后端FIFO
**author:wangqi
**time:2017.03.03
*****************************************/
//读打拍-本质来源DMAR
reg ren1_rfifo_ddr3,ren2_rfifo_ddr3;
always @(posedge rxclk or negedge rst_rx)
begin
 if(rst_rx == 1'b0)
  begin
   ren1_rfifo_ddr3 <= 1'b0;
   ren2_rfifo_ddr3 <= 1'b0; 
  end
 else
  begin
   ren1_rfifo_ddr3 <= ren_rfifo_ddr3;
   ren2_rfifo_ddr3 <= ren1_rfifo_ddr3;
  end
end
//打拍
reg first;//first == 1 : first rising edge of rdclk

always @(posedge rxclk or negedge rst_rx)
begin
 if(rst_rx == 1'b0)
  begin
  first <= 1'b1; 
  rd_en_rfifo <= 1'b0;
  end
 else
  begin
  if (ren2_rfifo_ddr3 == 1'b0 && ren1_rfifo_ddr3 == 1'b1)//上位机给读fifo沿
   begin
	    first <= ~first;//确保每读2次，只更新一次数据
	    if(first == 1'b1)
	    rd_en_rfifo <= 1'b1;//硬件读FIFO--更新一次读取的128bit数--但每次软件连续读端口只读32bit--读完4个端口后去拼数
	    else
		 rd_en_rfifo <= 1'b0;
	end
  else
   begin
	first <= first;
   rd_en_rfifo <= 1'b0;
	end
  end
end
//out-上位机读之前更新
//软件是连续读一个端口的数形成block，在连续读下个端口。
assign d_rfifo[15:0] =  first ? dout_512bto128b[15:0]       : dout_512bto128b[31:16];
assign d_rfifo[31:16] = first ? dout_512bto128b[47:32]      : dout_512bto128b[63:48];
assign d_rfifo[47:32] = first ? dout_512bto128b[79:64]      : dout_512bto128b[95:80];
assign d_rfifo[63:48] = first ? dout_512bto128b[111:96]     : dout_512bto128b[127:112];

assign rd_fifo_ready = prog_full_512bto128b;//上位机去读


endmodule
