`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:57:14 02/09/2017 
// Design Name: 
// Module Name:    IOport256 
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
module IOport256(
		ADDR,
		LWR,
	   BLAST,
	   LCLK,
		aw,
	   ar
    );

input [31:2] ADDR;
input LWR;
input BLAST;
input LCLK;
output wire [255:0] aw/* synthesis syn_keep = 1 */;
output wire [255:0] ar/* synthesis syn_keep = 1 */;

wire [255:0] aden/* synthesis syn_keep = 1 */;

wire	chip0_sel;
wire	chip1_sel;
wire	chip2_sel;
wire	chip3_sel;
wire	chip4_sel;
wire	chip5_sel;
wire	chip6_sel;
wire	chip7_sel;

wire  addr_h_sel;//高位地址若不用则译0
assign   addr_h_sel=(ADDR[10] | ADDR[11] | ADDR[12] | ADDR[13] | ADDR[14] | ADDR[15] |
                     ADDR[16] | ADDR[17] | ADDR[18] | ADDR[19] | ADDR[20] | ADDR[21] |
						   ADDR[22] | ADDR[23] | ADDR[24] | ADDR[25] | ADDR[26] | ADDR[27] |
						   ADDR[28] | ADDR[29] | ADDR[30] | ADDR[31] );

assign	chip0_sel =addr_h_sel | ADDR[8]  | ADDR[7]  | ADDR[6];
assign	chip1_sel =addr_h_sel | ADDR[8]  | ADDR[7]  | !ADDR[6];
assign	chip2_sel =addr_h_sel | ADDR[8]  | !ADDR[7] | ADDR[6];
assign	chip3_sel =addr_h_sel | ADDR[8]  | !ADDR[7] | !ADDR[6];
assign	chip4_sel =addr_h_sel | !ADDR[8] | ADDR[7]  | ADDR[6];
assign	chip5_sel =addr_h_sel | !ADDR[8] | ADDR[7]  | !ADDR[6];
assign	chip6_sel =addr_h_sel | !ADDR[8] | !ADDR[7] | ADDR[6];
assign	chip7_sel =addr_h_sel | !ADDR[8] | !ADDR[7] | !ADDR[6];


//lock_blast
wire 	lock_blast_out;
lock_blast lock_blast_inst0(
	.CLK(LCLK),
	.BLAST(BLAST),
	.Q(lock_blast_out)
	);

hc74154 	hc74154_inst0(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip0_sel),
	.G2N(ADDR[9]),
	
	.O0N(aden[0]),	
	.O1N(aden[1]),	
	.O2N(aden[2]),
	.O3N(aden[3]),
	.O4N(aden[4]),
	.O5N(aden[5]),	
	.O6N(aden[6]),	
	.O7N(aden[7]),
	.O8N(aden[8]),
	.O9N(aden[9]),
	.O10N(aden[10]),
	.O11N(aden[11]),
	.O12N(aden[12]),	
	.O13N(aden[13]),
	.O14N(aden[14]),
	.O15N(aden[15])	
	);	

hc74154 	hc74154_inst1(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip1_sel),
	.G2N(ADDR[9]),
	
	.O0N(aden[16]),	
	.O1N(aden[17]),	
	.O2N(aden[18]),
	.O3N(aden[19]),
	.O4N(aden[20]),
	.O5N(aden[21]),	
	.O6N(aden[22]),	
	.O7N(aden[23]),
	.O8N(aden[24]),
	.O9N(aden[25]),
	.O10N(aden[26]),
	.O11N(aden[27]),
	.O12N(aden[28]),	
	.O13N(aden[29]),
	.O14N(aden[30]),
	.O15N(aden[31])	
	);	

hc74154 	hc74154_inst2(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip2_sel),
	.G2N(ADDR[9]),
	
	.O0N(aden[32]),	
	.O1N(aden[33]),	
	.O2N(aden[34]),
	.O3N(aden[35]),
	.O4N(aden[36]),
	.O5N(aden[37]),	
	.O6N(aden[38]),	
	.O7N(aden[39]),
	.O8N(aden[40]),
	.O9N(aden[41]),
	.O10N(aden[42]),
	.O11N(aden[43]),
	.O12N(aden[44]),	
	.O13N(aden[45]),
	.O14N(aden[46]),
	.O15N(aden[47])	
	);	

hc74154 	hc74154_inst3(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip3_sel),
	.G2N(ADDR[9]),
	
	.O0N(aden[48]),	
	.O1N(aden[49]),	
	.O2N(aden[50]),
	.O3N(aden[51]),
	.O4N(aden[52]),
	.O5N(aden[53]),	
	.O6N(aden[54]),	
	.O7N(aden[55]),
	.O8N(aden[56]),
	.O9N(aden[57]),
	.O10N(aden[58]),
	.O11N(aden[59]),
	.O12N(aden[60]),	
	.O13N(aden[61]),
	.O14N(aden[62]),
	.O15N(aden[63])	
	);	

hc74154 	hc74154_inst4(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip4_sel),
	.G2N(ADDR[9]),
	
	.O0N(aden[64]),	
	.O1N(aden[65]),	
	.O2N(aden[66]),
	.O3N(aden[67]),
	.O4N(aden[68]),
	.O5N(aden[69]),	
	.O6N(aden[70]),	
	.O7N(aden[71]),
	.O8N(aden[72]),
	.O9N(aden[73]),
	.O10N(aden[74]),
	.O11N(aden[75]),
	.O12N(aden[76]),	
	.O13N(aden[77]),
	.O14N(aden[78]),
	.O15N(aden[79])	
	);	

hc74154 	hc74154_inst5(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip5_sel),
	.G2N(ADDR[9]),
	
	.O0N(aden[80]),	
	.O1N(aden[81]),	
	.O2N(aden[82]),
	.O3N(aden[83]),
	.O4N(aden[84]),
	.O5N(aden[85]),	
	.O6N(aden[86]),	
	.O7N(aden[87]),
	.O8N(aden[88]),
	.O9N(aden[89]),
	.O10N(aden[90]),
	.O11N(aden[91]),
	.O12N(aden[92]),	
	.O13N(aden[93]),
	.O14N(aden[94]),
	.O15N(aden[95])	
	);
	
hc74154 	hc74154_inst6(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip6_sel),
	.G2N(ADDR[9]),
	
	.O0N(aden[96]),	
	.O1N(aden[97]),	
	.O2N(aden[98]),
	.O3N(aden[99]),
	.O4N(aden[100]),
	.O5N(aden[101]),	
	.O6N(aden[102]),	
	.O7N(aden[103]),
	.O8N(aden[104]),
	.O9N(aden[105]),
	.O10N(aden[106]),
	.O11N(aden[107]),
	.O12N(aden[108]),	
	.O13N(aden[109]),
	.O14N(aden[110]),
	.O15N(aden[111])	
	);	

hc74154 	hc74154_inst7(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip7_sel),
	.G2N(ADDR[9]),
	
	.O0N(aden[112]),	
	.O1N(aden[113]),	
	.O2N(aden[114]),
	.O3N(aden[115]),
	.O4N(aden[116]),
	.O5N(aden[117]),	
	.O6N(aden[118]),	
	.O7N(aden[119]),
	.O8N(aden[120]),
	.O9N(aden[121]),
	.O10N(aden[122]),
	.O11N(aden[123]),
	.O12N(aden[124]),	
	.O13N(aden[125]),
	.O14N(aden[126]),
	.O15N(aden[127])	
	);	
	
hc74154 	hc74154_inst8(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip0_sel),
	.G2N(!ADDR[9]),
	
	.O0N(aden[128]),	
	.O1N(aden[129]),	
	.O2N(aden[130]),
	.O3N(aden[131]),
	.O4N(aden[132]),
	.O5N(aden[133]),	
	.O6N(aden[134]),	
	.O7N(aden[135]),
	.O8N(aden[136]),
	.O9N(aden[137]),
	.O10N(aden[138]),
	.O11N(aden[139]),
	.O12N(aden[140]),	
	.O13N(aden[141]),
	.O14N(aden[142]),
	.O15N(aden[143])	
	);	

hc74154 	hc74154_inst9(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip1_sel),
	.G2N(!ADDR[9]),
	
	.O0N(aden[144]),	
	.O1N(aden[145]),	
	.O2N(aden[146]),
	.O3N(aden[147]),
	.O4N(aden[148]),
	.O5N(aden[149]),	
	.O6N(aden[150]),	
	.O7N(aden[151]),
	.O8N(aden[152]),
	.O9N(aden[153]),
	.O10N(aden[154]),
	.O11N(aden[155]),
	.O12N(aden[156]),	
	.O13N(aden[157]),
	.O14N(aden[158]),
	.O15N(aden[159])	
	);	

hc74154 	hc74154_inst10(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip2_sel),
	.G2N(!ADDR[9]),
	
	.O0N(aden[160]),	
	.O1N(aden[161]),	
	.O2N(aden[162]),
	.O3N(aden[163]),
	.O4N(aden[164]),
	.O5N(aden[165]),	
	.O6N(aden[166]),	
	.O7N(aden[167]),
	.O8N(aden[168]),
	.O9N(aden[169]),
	.O10N(aden[170]),
	.O11N(aden[171]),
	.O12N(aden[172]),	
	.O13N(aden[173]),
	.O14N(aden[174]),
	.O15N(aden[175])	
	);	

hc74154 	hc74154_inst11(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip3_sel),
	.G2N(!ADDR[9]),
	
	.O0N(aden[176]),	
	.O1N(aden[177]),	
	.O2N(aden[178]),
	.O3N(aden[179]),
	.O4N(aden[180]),
	.O5N(aden[181]),	
	.O6N(aden[182]),	
	.O7N(aden[183]),
	.O8N(aden[184]),
	.O9N(aden[185]),
	.O10N(aden[186]),
	.O11N(aden[187]),
	.O12N(aden[188]),	
	.O13N(aden[189]),
	.O14N(aden[190]),
	.O15N(aden[191])	
	);	

hc74154 	hc74154_inst12(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip4_sel),
	.G2N(!ADDR[9]),
	
	.O0N(aden[192]),	
	.O1N(aden[193]),	
	.O2N(aden[194]),
	.O3N(aden[195]),
	.O4N(aden[196]),
	.O5N(aden[197]),	
	.O6N(aden[198]),	
	.O7N(aden[199]),
	.O8N(aden[200]),
	.O9N(aden[201]),
	.O10N(aden[202]),
	.O11N(aden[203]),
	.O12N(aden[204]),	
	.O13N(aden[205]),
	.O14N(aden[206]),
	.O15N(aden[207])	
	);	

hc74154 	hc74154_inst13(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip5_sel),
	.G2N(!ADDR[9]),
	
	.O0N(aden[208]),	
	.O1N(aden[209]),	
	.O2N(aden[210]),
	.O3N(aden[211]),
	.O4N(aden[212]),
	.O5N(aden[213]),	
	.O6N(aden[214]),	
	.O7N(aden[215]),
	.O8N(aden[216]),
	.O9N(aden[217]),
	.O10N(aden[218]),
	.O11N(aden[219]),
	.O12N(aden[220]),	
	.O13N(aden[221]),
	.O14N(aden[222]),
	.O15N(aden[223])	
	);
	
hc74154 	hc74154_inst14(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip6_sel),
	.G2N(!ADDR[9]),
	
	.O0N(aden[224]),	
	.O1N(aden[225]),	
	.O2N(aden[226]),
	.O3N(aden[227]),
	.O4N(aden[228]),
	.O5N(aden[229]),	
	.O6N(aden[230]),	
	.O7N(aden[231]),
	.O8N(aden[232]),
	.O9N(aden[233]),
	.O10N(aden[234]),
	.O11N(aden[235]),
	.O12N(aden[236]),	
	.O13N(aden[237]),
	.O14N(aden[238]),
	.O15N(aden[239])	
	);	

hc74154 	hc74154_inst15(
	.D(ADDR[5]),
	.C(ADDR[4]),
	.B(ADDR[3]),
	.A(ADDR[2]),
	.G1N(chip7_sel),
	.G2N(!ADDR[9]),
	
	.O0N(aden[240]),	
	.O1N(aden[241]),	
	.O2N(aden[242]),
	.O3N(aden[243]),
	.O4N(aden[244]),
	.O5N(aden[245]),	
	.O6N(aden[246]),	
	.O7N(aden[247]),
	.O8N(aden[248]),
	.O9N(aden[249]),
	.O10N(aden[250]),
	.O11N(aden[251]),
	.O12N(aden[252]),	
	.O13N(aden[253]),
	.O14N(aden[254]),
	.O15N(aden[255])	
	);
	

assign	aw[255] = (~aden[255]) & LWR & lock_blast_out;	
assign	aw[254] = (~aden[254]) & LWR & lock_blast_out;	
assign	aw[253] = (~aden[253]) & LWR & lock_blast_out;	
assign	aw[252] = (~aden[252]) & LWR & lock_blast_out;	
assign	aw[251] = (~aden[251]) & LWR & lock_blast_out;	
assign	aw[250] = (~aden[250]) & LWR & lock_blast_out;	
assign	aw[249] = (~aden[249]) & LWR & lock_blast_out;	
assign	aw[248] = (~aden[248]) & LWR & lock_blast_out;	
assign	aw[247] = (~aden[247]) & LWR & lock_blast_out;	
assign	aw[246] = (~aden[246]) & LWR & lock_blast_out;		
assign	aw[245] = (~aden[245]) & LWR & lock_blast_out;	
assign	aw[244] = (~aden[244]) & LWR & lock_blast_out;	
assign	aw[243] = (~aden[243]) & LWR & lock_blast_out;	
assign	aw[242] = (~aden[242]) & LWR & lock_blast_out;	
assign	aw[241] = (~aden[241]) & LWR & lock_blast_out;	
assign	aw[240] = (~aden[240]) & LWR & lock_blast_out;	
assign	aw[239] = (~aden[239]) & LWR & lock_blast_out;	
assign	aw[238] = (~aden[238]) & LWR & lock_blast_out;	
assign	aw[237] = (~aden[237]) & LWR & lock_blast_out;	
assign	aw[236] = (~aden[236]) & LWR & lock_blast_out;
assign	aw[235] = (~aden[235]) & LWR & lock_blast_out;	
assign	aw[234] = (~aden[234]) & LWR & lock_blast_out;	
assign	aw[233] = (~aden[233]) & LWR & lock_blast_out;	
assign	aw[232] = (~aden[232]) & LWR & lock_blast_out;	
assign	aw[231] = (~aden[231]) & LWR & lock_blast_out;	
assign	aw[230] = (~aden[230]) & LWR & lock_blast_out;	
assign	aw[229] = (~aden[229]) & LWR & lock_blast_out;	
assign	aw[228] = (~aden[228]) & LWR & lock_blast_out;	
assign	aw[227] = (~aden[227]) & LWR & lock_blast_out;	
assign	aw[226] = (~aden[226]) & LWR & lock_blast_out;		
assign	aw[225] = (~aden[225]) & LWR & lock_blast_out;	
assign	aw[224] = (~aden[224]) & LWR & lock_blast_out;	
assign	aw[223] = (~aden[223]) & LWR & lock_blast_out;	
assign	aw[222] = (~aden[222]) & LWR & lock_blast_out;	
assign	aw[221] = (~aden[221]) & LWR & lock_blast_out;	
assign	aw[220] = (~aden[220]) & LWR & lock_blast_out;	
assign	aw[219] = (~aden[219]) & LWR & lock_blast_out;	
assign	aw[218] = (~aden[218]) & LWR & lock_blast_out;	
assign	aw[217] = (~aden[217]) & LWR & lock_blast_out;	
assign	aw[216] = (~aden[216]) & LWR & lock_blast_out;
assign	aw[215] = (~aden[215]) & LWR & lock_blast_out;	
assign	aw[214] = (~aden[214]) & LWR & lock_blast_out;	
assign	aw[213] = (~aden[213]) & LWR & lock_blast_out;	
assign	aw[212] = (~aden[212]) & LWR & lock_blast_out;	
assign	aw[211] = (~aden[211]) & LWR & lock_blast_out;	
assign	aw[210] = (~aden[210]) & LWR & lock_blast_out;	
assign	aw[209] = (~aden[209]) & LWR & lock_blast_out;	
assign	aw[208] = (~aden[208]) & LWR & lock_blast_out;	
assign	aw[207] = (~aden[207]) & LWR & lock_blast_out;	
assign	aw[206] = (~aden[206]) & LWR & lock_blast_out;		
assign	aw[205] = (~aden[205]) & LWR & lock_blast_out;	
assign	aw[204] = (~aden[204]) & LWR & lock_blast_out;	
assign	aw[203] = (~aden[203]) & LWR & lock_blast_out;	
assign	aw[202] = (~aden[202]) & LWR & lock_blast_out;	
assign	aw[201] = (~aden[201]) & LWR & lock_blast_out;	
assign	aw[200] = (~aden[200]) & LWR & lock_blast_out;	
assign	aw[199] = (~aden[199]) & LWR & lock_blast_out;	
assign	aw[198] = (~aden[198]) & LWR & lock_blast_out;	
assign	aw[197] = (~aden[197]) & LWR & lock_blast_out;	
assign	aw[196] = (~aden[196]) & LWR & lock_blast_out;
assign	aw[195] = (~aden[195]) & LWR & lock_blast_out;	
assign	aw[194] = (~aden[194]) & LWR & lock_blast_out;	
assign	aw[193] = (~aden[193]) & LWR & lock_blast_out;	
assign	aw[192] = (~aden[192]) & LWR & lock_blast_out;	
assign	aw[191] = (~aden[191]) & LWR & lock_blast_out;	
assign	aw[190] = (~aden[190]) & LWR & lock_blast_out;	
assign	aw[189] = (~aden[189]) & LWR & lock_blast_out;	
assign	aw[188] = (~aden[188]) & LWR & lock_blast_out;	
assign	aw[187] = (~aden[187]) & LWR & lock_blast_out;	
assign	aw[186] = (~aden[186]) & LWR & lock_blast_out;		
assign	aw[185] = (~aden[185]) & LWR & lock_blast_out;	
assign	aw[184] = (~aden[184]) & LWR & lock_blast_out;	
assign	aw[183] = (~aden[183]) & LWR & lock_blast_out;	
assign	aw[182] = (~aden[182]) & LWR & lock_blast_out;	
assign	aw[181] = (~aden[181]) & LWR & lock_blast_out;	
assign	aw[180] = (~aden[180]) & LWR & lock_blast_out;	
assign	aw[179] = (~aden[179]) & LWR & lock_blast_out;	
assign	aw[178] = (~aden[178]) & LWR & lock_blast_out;	
assign	aw[177] = (~aden[177]) & LWR & lock_blast_out;	
assign	aw[176] = (~aden[176]) & LWR & lock_blast_out;
assign	aw[175] = (~aden[175]) & LWR & lock_blast_out;	
assign	aw[174] = (~aden[174]) & LWR & lock_blast_out;	
assign	aw[173] = (~aden[173]) & LWR & lock_blast_out;	
assign	aw[172] = (~aden[172]) & LWR & lock_blast_out;	
assign	aw[171] = (~aden[171]) & LWR & lock_blast_out;	
assign	aw[170] = (~aden[170]) & LWR & lock_blast_out;	
assign	aw[169] = (~aden[169]) & LWR & lock_blast_out;	
assign	aw[168] = (~aden[168]) & LWR & lock_blast_out;	
assign	aw[167] = (~aden[167]) & LWR & lock_blast_out;	
assign	aw[166] = (~aden[166]) & LWR & lock_blast_out;		
assign	aw[165] = (~aden[165]) & LWR & lock_blast_out;	
assign	aw[164] = (~aden[164]) & LWR & lock_blast_out;	
assign	aw[163] = (~aden[163]) & LWR & lock_blast_out;	
assign	aw[162] = (~aden[162]) & LWR & lock_blast_out;	
assign	aw[161] = (~aden[161]) & LWR & lock_blast_out;	
assign	aw[160] = (~aden[160]) & LWR & lock_blast_out;	
assign	aw[159] = (~aden[159]) & LWR & lock_blast_out;	
assign	aw[158] = (~aden[158]) & LWR & lock_blast_out;	
assign	aw[157] = (~aden[157]) & LWR & lock_blast_out;	
assign	aw[156] = (~aden[156]) & LWR & lock_blast_out;
assign	aw[155] = (~aden[155]) & LWR & lock_blast_out;	
assign	aw[154] = (~aden[154]) & LWR & lock_blast_out;	
assign	aw[153] = (~aden[153]) & LWR & lock_blast_out;	
assign	aw[152] = (~aden[152]) & LWR & lock_blast_out;	
assign	aw[151] = (~aden[151]) & LWR & lock_blast_out;	
assign	aw[150] = (~aden[150]) & LWR & lock_blast_out;	
assign	aw[149] = (~aden[149]) & LWR & lock_blast_out;	
assign	aw[148] = (~aden[148]) & LWR & lock_blast_out;	
assign	aw[147] = (~aden[147]) & LWR & lock_blast_out;	
assign	aw[146] = (~aden[146]) & LWR & lock_blast_out;		
assign	aw[145] = (~aden[145]) & LWR & lock_blast_out;	
assign	aw[144] = (~aden[144]) & LWR & lock_blast_out;	
assign	aw[143] = (~aden[143]) & LWR & lock_blast_out;	
assign	aw[142] = (~aden[142]) & LWR & lock_blast_out;	
assign	aw[141] = (~aden[141]) & LWR & lock_blast_out;	
assign	aw[140] = (~aden[140]) & LWR & lock_blast_out;	
assign	aw[139] = (~aden[139]) & LWR & lock_blast_out;	
assign	aw[138] = (~aden[138]) & LWR & lock_blast_out;	
assign	aw[137] = (~aden[137]) & LWR & lock_blast_out;	
assign	aw[136] = (~aden[136]) & LWR & lock_blast_out;
assign	aw[135] = (~aden[135]) & LWR & lock_blast_out;	
assign	aw[134] = (~aden[134]) & LWR & lock_blast_out;	
assign	aw[133] = (~aden[133]) & LWR & lock_blast_out;	
assign	aw[132] = (~aden[132]) & LWR & lock_blast_out;	
assign	aw[131] = (~aden[131]) & LWR & lock_blast_out;	
assign	aw[130] = (~aden[130]) & LWR & lock_blast_out;	
assign	aw[129] = (~aden[129]) & LWR & lock_blast_out;	
assign	aw[128] = (~aden[128]) & LWR & lock_blast_out;	
assign	aw[127] = (~aden[127]) & LWR & lock_blast_out;	
assign	aw[126] = (~aden[126]) & LWR & lock_blast_out;		
assign	aw[125] = (~aden[125]) & LWR & lock_blast_out;	
assign	aw[124] = (~aden[124]) & LWR & lock_blast_out;	
assign	aw[123] = (~aden[123]) & LWR & lock_blast_out;	
assign	aw[122] = (~aden[122]) & LWR & lock_blast_out;	
assign	aw[121] = (~aden[121]) & LWR & lock_blast_out;	
assign	aw[120] = (~aden[120]) & LWR & lock_blast_out;	
assign	aw[119] = (~aden[119]) & LWR & lock_blast_out;	
assign	aw[118] = (~aden[118]) & LWR & lock_blast_out;	
assign	aw[117] = (~aden[117]) & LWR & lock_blast_out;	
assign	aw[116] = (~aden[116]) & LWR & lock_blast_out;
assign	aw[115] = (~aden[115]) & LWR & lock_blast_out;	
assign	aw[114] = (~aden[114]) & LWR & lock_blast_out;	
assign	aw[113] = (~aden[113]) & LWR & lock_blast_out;	
assign	aw[112] = (~aden[112]) & LWR & lock_blast_out;	
assign	aw[111] = (~aden[111]) & LWR & lock_blast_out;	
assign	aw[110] = (~aden[110]) & LWR & lock_blast_out;	
assign	aw[109] = (~aden[109]) & LWR & lock_blast_out;	
assign	aw[108] = (~aden[108]) & LWR & lock_blast_out;	
assign	aw[107] = (~aden[107]) & LWR & lock_blast_out;	
assign	aw[106] = (~aden[106]) & LWR & lock_blast_out;		
assign	aw[105] = (~aden[105]) & LWR & lock_blast_out;	
assign	aw[104] = (~aden[104]) & LWR & lock_blast_out;	
assign	aw[103] = (~aden[103]) & LWR & lock_blast_out;	
assign	aw[102] = (~aden[102]) & LWR & lock_blast_out;	
assign	aw[101] = (~aden[101]) & LWR & lock_blast_out;	
assign	aw[100] = (~aden[100]) & LWR & lock_blast_out;	
assign	aw[99] = (~aden[99]) & LWR & lock_blast_out;	
assign	aw[98] = (~aden[98]) & LWR & lock_blast_out;	
assign	aw[97] = (~aden[97]) & LWR & lock_blast_out;	
assign	aw[96] = (~aden[96]) & LWR & lock_blast_out;
assign	aw[95] = (~aden[95]) & LWR & lock_blast_out;	
assign	aw[94] = (~aden[94]) & LWR & lock_blast_out;	
assign	aw[93] = (~aden[93]) & LWR & lock_blast_out;	
assign	aw[92] = (~aden[92]) & LWR & lock_blast_out;	
assign	aw[91] = (~aden[91]) & LWR & lock_blast_out;	
assign	aw[90] = (~aden[90]) & LWR & lock_blast_out;	
assign	aw[89] = (~aden[89]) & LWR & lock_blast_out;	
assign	aw[88] = (~aden[88]) & LWR & lock_blast_out;	
assign	aw[87] = (~aden[87]) & LWR & lock_blast_out;	
assign	aw[86] = (~aden[86]) & LWR & lock_blast_out;		
assign	aw[85] = (~aden[85]) & LWR & lock_blast_out;	
assign	aw[84] = (~aden[84]) & LWR & lock_blast_out;	
assign	aw[83] = (~aden[83]) & LWR & lock_blast_out;	
assign	aw[82] = (~aden[82]) & LWR & lock_blast_out;	
assign	aw[81] = (~aden[81]) & LWR & lock_blast_out;	
assign	aw[80] = (~aden[80]) & LWR & lock_blast_out;	
assign	aw[79] = (~aden[79]) & LWR & lock_blast_out;	
assign	aw[78] = (~aden[78]) & LWR & lock_blast_out;	
assign	aw[77] = (~aden[77]) & LWR & lock_blast_out;	
assign	aw[76] = (~aden[76]) & LWR & lock_blast_out;
assign	aw[75] = (~aden[75]) & LWR & lock_blast_out;	
assign	aw[74] = (~aden[74]) & LWR & lock_blast_out;	
assign	aw[73] = (~aden[73]) & LWR & lock_blast_out;	
assign	aw[72] = (~aden[72]) & LWR & lock_blast_out;	
assign	aw[71] = (~aden[71]) & LWR & lock_blast_out;	
assign	aw[70] = (~aden[70]) & LWR & lock_blast_out;	
assign	aw[69] = (~aden[69]) & LWR & lock_blast_out;	
assign	aw[68] = (~aden[68]) & LWR & lock_blast_out;	
assign	aw[67] = (~aden[67]) & LWR & lock_blast_out;	
assign	aw[66] = (~aden[66]) & LWR & lock_blast_out;		
assign	aw[65] = (~aden[65]) & LWR & lock_blast_out;	
assign	aw[64] = (~aden[64]) & LWR & lock_blast_out;	
assign	aw[63] = (~aden[63]) & LWR & lock_blast_out;	
assign	aw[62] = (~aden[62]) & LWR & lock_blast_out;	
assign	aw[61] = (~aden[61]) & LWR & lock_blast_out;	
assign	aw[60] = (~aden[60]) & LWR & lock_blast_out;	
assign	aw[59] = (~aden[59]) & LWR & lock_blast_out;	
assign	aw[58] = (~aden[58]) & LWR & lock_blast_out;	
assign	aw[57] = (~aden[57]) & LWR & lock_blast_out;	
assign	aw[56] = (~aden[56]) & LWR & lock_blast_out;
assign	aw[55] = (~aden[55]) & LWR & lock_blast_out;	
assign	aw[54] = (~aden[54]) & LWR & lock_blast_out;	
assign	aw[53] = (~aden[53]) & LWR & lock_blast_out;	
assign	aw[52] = (~aden[52]) & LWR & lock_blast_out;	
assign	aw[51] = (~aden[51]) & LWR & lock_blast_out;	
assign	aw[50] = (~aden[50]) & LWR & lock_blast_out;	
assign	aw[49] = (~aden[49]) & LWR & lock_blast_out;	
assign	aw[48] = (~aden[48]) & LWR & lock_blast_out;	
assign	aw[47] = (~aden[47]) & LWR & lock_blast_out;	
assign	aw[46] = (~aden[46]) & LWR & lock_blast_out;		
assign	aw[45] = (~aden[45]) & LWR & lock_blast_out;	
assign	aw[44] = (~aden[44]) & LWR & lock_blast_out;	
assign	aw[43] = (~aden[43]) & LWR & lock_blast_out;	
assign	aw[42] = (~aden[42]) & LWR & lock_blast_out;	
assign	aw[41] = (~aden[41]) & LWR & lock_blast_out;	
assign	aw[40] = (~aden[40]) & LWR & lock_blast_out;	
assign	aw[39] = (~aden[39]) & LWR & lock_blast_out;	
assign	aw[38] = (~aden[38]) & LWR & lock_blast_out;	
assign	aw[37] = (~aden[37]) & LWR & lock_blast_out;	
assign	aw[36] = (~aden[36]) & LWR & lock_blast_out;
assign	aw[35] = (~aden[35]) & LWR & lock_blast_out;	
assign	aw[34] = (~aden[34]) & LWR & lock_blast_out;	
assign	aw[33] = (~aden[33]) & LWR & lock_blast_out;	
assign	aw[32] = (~aden[32]) & LWR & lock_blast_out;	
assign	aw[31] = (~aden[31]) & LWR & lock_blast_out;	
assign	aw[30] = (~aden[20]) & LWR & lock_blast_out;	
assign	aw[29] = (~aden[29]) & LWR & lock_blast_out;	
assign	aw[28] = (~aden[28]) & LWR & lock_blast_out;	
assign	aw[27] = (~aden[27]) & LWR & lock_blast_out;	
assign	aw[26] = (~aden[26]) & LWR & lock_blast_out;
assign	aw[25] = (~aden[25]) & LWR & lock_blast_out;	
assign	aw[24] = (~aden[24]) & LWR & lock_blast_out;	
assign	aw[23] = (~aden[23]) & LWR & lock_blast_out;	
assign	aw[22] = (~aden[22]) & LWR & lock_blast_out;	
assign	aw[21] = (~aden[21]) & LWR & lock_blast_out;	
assign	aw[20] = (~aden[20]) & LWR & lock_blast_out;	
assign	aw[19] = (~aden[19]) & LWR & lock_blast_out;	
assign	aw[18] = (~aden[18]) & LWR & lock_blast_out;	
assign	aw[17] = (~aden[17]) & LWR & lock_blast_out;	
assign	aw[16] = (~aden[16]) & LWR & lock_blast_out;		
assign	aw[15] = (~aden[15]) & LWR & lock_blast_out;	
assign	aw[14] = (~aden[14]) & LWR & lock_blast_out;	
assign	aw[13] = (~aden[13]) & LWR & lock_blast_out;	
assign	aw[12] = (~aden[12]) & LWR & lock_blast_out;	
assign	aw[11] = (~aden[11]) & LWR & lock_blast_out;	
assign	aw[10] = (~aden[10]) & LWR & lock_blast_out;	
assign	aw[9] = (~aden[9]) & LWR & lock_blast_out;	
assign	aw[8] = (~aden[8]) & LWR & lock_blast_out;	
assign	aw[7] = (~aden[7]) & LWR & lock_blast_out;	
assign	aw[6] = (~aden[6]) & LWR & lock_blast_out;
assign	aw[5] = (~aden[5]) & LWR & lock_blast_out;	
assign	aw[4] = (~aden[4]) & LWR & lock_blast_out;	
assign	aw[3] = (~aden[3]) & LWR & lock_blast_out;	
assign	aw[2] = (~aden[2]) & LWR & lock_blast_out;
assign	aw[1] = (~aden[1]) & LWR & lock_blast_out;	
assign	aw[0] = (~aden[0]) & LWR & lock_blast_out;	


assign	ar[255] = aden[255] | LWR | BLAST;	
assign	ar[254] = aden[254] | LWR | BLAST;	
assign	ar[253] = aden[253] | LWR | BLAST;	
assign	ar[252] = aden[252] | LWR | BLAST;	
assign	ar[251] = aden[251] | LWR | BLAST;	
assign	ar[250] = aden[250] | LWR | BLAST;	
assign	ar[249] = aden[249] | LWR | BLAST;	
assign	ar[248] = aden[248] | LWR | BLAST;	
assign	ar[247] = aden[247] | LWR | BLAST;	
assign	ar[246] = aden[246] | LWR | BLAST;		
assign	ar[245] = aden[245] | LWR | BLAST;	
assign	ar[244] = aden[244] | LWR | BLAST;	
assign	ar[243] = aden[243] | LWR | BLAST;	
assign	ar[242] = aden[242] | LWR | BLAST;	
assign	ar[241] = aden[241] | LWR | BLAST;	
assign	ar[240] = aden[240] | LWR | BLAST;	
assign	ar[239] = aden[239] | LWR | BLAST;	
assign	ar[238] = aden[238] | LWR | BLAST;	
assign	ar[237] = aden[237] | LWR | BLAST;	
assign	ar[236] = aden[236] | LWR | BLAST;
assign	ar[235] = aden[235] | LWR | BLAST;	
assign	ar[234] = aden[234] | LWR | BLAST;	
assign	ar[233] = aden[233] | LWR | BLAST;	
assign	ar[232] = aden[232] | LWR | BLAST;	
assign	ar[231] = aden[231] | LWR | BLAST;	
assign	ar[230] = aden[230] | LWR | BLAST;	
assign	ar[229] = aden[229] | LWR | BLAST;	
assign	ar[228] = aden[228] | LWR | BLAST;	
assign	ar[227] = aden[227] | LWR | BLAST;	
assign	ar[226] = aden[226] | LWR | BLAST;		
assign	ar[225] = aden[225] | LWR | BLAST;	
assign	ar[224] = aden[224] | LWR | BLAST;	
assign	ar[223] = aden[223] | LWR | BLAST;	
assign	ar[222] = aden[222] | LWR | BLAST;	
assign	ar[221] = aden[221] | LWR | BLAST;	
assign	ar[220] = aden[220] | LWR | BLAST;	
assign	ar[219] = aden[219] | LWR | BLAST;	
assign	ar[218] = aden[218] | LWR | BLAST;	
assign	ar[217] = aden[217] | LWR | BLAST;	
assign	ar[216] = aden[216] | LWR | BLAST;
assign	ar[215] = aden[215] | LWR | BLAST;	
assign	ar[214] = aden[214] | LWR | BLAST;	
assign	ar[213] = aden[213] | LWR | BLAST;	
assign	ar[212] = aden[212] | LWR | BLAST;	
assign	ar[211] = aden[211] | LWR | BLAST;	
assign	ar[210] = aden[210] | LWR | BLAST;	
assign	ar[209] = aden[209] | LWR | BLAST;	
assign	ar[208] = aden[208] | LWR | BLAST;	
assign	ar[207] = aden[207] | LWR | BLAST;	
assign	ar[206] = aden[206] | LWR | BLAST;		
assign	ar[205] = aden[205] | LWR | BLAST;	
assign	ar[204] = aden[204] | LWR | BLAST;	
assign	ar[203] = aden[203] | LWR | BLAST;	
assign	ar[202] = aden[202] | LWR | BLAST;	
assign	ar[201] = aden[201] | LWR | BLAST;	
assign	ar[200] = aden[200] | LWR | BLAST;	
assign	ar[199] = aden[199] | LWR | BLAST;	
assign	ar[198] = aden[198] | LWR | BLAST;	
assign	ar[197] = aden[197] | LWR | BLAST;	
assign	ar[196] = aden[196] | LWR | BLAST;
assign	ar[195] = aden[195] | LWR | BLAST;	
assign	ar[194] = aden[194] | LWR | BLAST;	
assign	ar[193] = aden[193] | LWR | BLAST;	
assign	ar[192] = aden[192] | LWR | BLAST;	
assign	ar[191] = aden[191] | LWR | BLAST;	
assign	ar[190] = aden[190] | LWR | BLAST;	
assign	ar[189] = aden[189] | LWR | BLAST;	
assign	ar[188] = aden[188] | LWR | BLAST;	
assign	ar[187] = aden[187] | LWR | BLAST;	
assign	ar[186] = aden[186] | LWR | BLAST;		
assign	ar[185] = aden[185] | LWR | BLAST;	
assign	ar[184] = aden[184] | LWR | BLAST;	
assign	ar[183] = aden[183] | LWR | BLAST;	
assign	ar[182] = aden[182] | LWR | BLAST;	
assign	ar[181] = aden[181] | LWR | BLAST;	
assign	ar[180] = aden[180] | LWR | BLAST;	
assign	ar[179] = aden[179] | LWR | BLAST;	
assign	ar[178] = aden[178] | LWR | BLAST;	
assign	ar[177] = aden[177] | LWR | BLAST;	
assign	ar[176] = aden[176] | LWR | BLAST;
assign	ar[175] = aden[175] | LWR | BLAST;	
assign	ar[174] = aden[174] | LWR | BLAST;	
assign	ar[173] = aden[173] | LWR | BLAST;	
assign	ar[172] = aden[172] | LWR | BLAST;	
assign	ar[171] = aden[171] | LWR | BLAST;	
assign	ar[170] = aden[170] | LWR | BLAST;	
assign	ar[169] = aden[169] | LWR | BLAST;	
assign	ar[168] = aden[168] | LWR | BLAST;	
assign	ar[167] = aden[167] | LWR | BLAST;	
assign	ar[166] = aden[166] | LWR | BLAST;		
assign	ar[165] = aden[165] | LWR | BLAST;	
assign	ar[164] = aden[164] | LWR | BLAST;	
assign	ar[163] = aden[163] | LWR | BLAST;	
assign	ar[162] = aden[162] | LWR | BLAST;	
assign	ar[161] = aden[161] | LWR | BLAST;	
assign	ar[160] = aden[160] | LWR | BLAST;	
assign	ar[159] = aden[159] | LWR | BLAST;	
assign	ar[158] = aden[158] | LWR | BLAST;	
assign	ar[157] = aden[157] | LWR | BLAST;	
assign	ar[156] = aden[156] | LWR | BLAST;
assign	ar[155] = aden[155] | LWR | BLAST;	
assign	ar[154] = aden[154] | LWR | BLAST;	
assign	ar[153] = aden[153] | LWR | BLAST;	
assign	ar[152] = aden[152] | LWR | BLAST;	
assign	ar[151] = aden[151] | LWR | BLAST;	
assign	ar[150] = aden[150] | LWR | BLAST;	
assign	ar[149] = aden[149] | LWR | BLAST;	
assign	ar[148] = aden[148] | LWR | BLAST;	
assign	ar[147] = aden[147] | LWR | BLAST;	
assign	ar[146] = aden[146] | LWR | BLAST;		
assign	ar[145] = aden[145] | LWR | BLAST;	
assign	ar[144] = aden[144] | LWR | BLAST;	
assign	ar[143] = aden[143] | LWR | BLAST;	
assign	ar[142] = aden[142] | LWR | BLAST;	
assign	ar[141] = aden[141] | LWR | BLAST;	
assign	ar[140] = aden[140] | LWR | BLAST;	
assign	ar[139] = aden[139] | LWR | BLAST;	
assign	ar[138] = aden[138] | LWR | BLAST;	
assign	ar[137] = aden[137] | LWR | BLAST;	
assign	ar[136] = aden[136] | LWR | BLAST;
assign	ar[135] = aden[135] | LWR | BLAST;	
assign	ar[134] = aden[134] | LWR | BLAST;	
assign	ar[133] = aden[133] | LWR | BLAST;	
assign	ar[132] = aden[132] | LWR | BLAST;	
assign	ar[131] = aden[131] | LWR | BLAST;	
assign	ar[130] = aden[130] | LWR | BLAST;	
assign	ar[129] = aden[129] | LWR | BLAST;	
assign	ar[128] = aden[128] | LWR | BLAST;	
assign	ar[127] = aden[127] | LWR | BLAST;	
assign	ar[126] = aden[126] | LWR | BLAST;		
assign	ar[125] = aden[125] | LWR | BLAST;	
assign	ar[124] = aden[124] | LWR | BLAST;	
assign	ar[123] = aden[123] | LWR | BLAST;	
assign	ar[122] = aden[122] | LWR | BLAST;	
assign	ar[121] = aden[121] | LWR | BLAST;	
assign	ar[120] = aden[120] | LWR | BLAST;	
assign	ar[119] = aden[119] | LWR | BLAST;	
assign	ar[118] = aden[118] | LWR | BLAST;	
assign	ar[117] = aden[117] | LWR | BLAST;	
assign	ar[116] = aden[116] | LWR | BLAST;
assign	ar[115] = aden[115] | LWR | BLAST;	
assign	ar[114] = aden[114] | LWR | BLAST;	
assign	ar[113] = aden[113] | LWR | BLAST;	
assign	ar[112] = aden[112] | LWR | BLAST;	
assign	ar[111] = aden[111] | LWR | BLAST;	
assign	ar[110] = aden[110] | LWR | BLAST;	
assign	ar[109] = aden[109] | LWR | BLAST;	
assign	ar[108] = aden[108] | LWR | BLAST;	
assign	ar[107] = aden[107] | LWR | BLAST;	
assign	ar[106] = aden[106] | LWR | BLAST;		
assign	ar[105] = aden[105] | LWR | BLAST;	
assign	ar[104] = aden[104] | LWR | BLAST;	
assign	ar[103] = aden[103] | LWR | BLAST;	
assign	ar[102] = aden[102] | LWR | BLAST;	
assign	ar[101] = aden[101] | LWR | BLAST;	
assign	ar[100] = aden[100] | LWR | BLAST;	
assign	ar[99] = aden[99] | LWR | BLAST;	
assign	ar[98] = aden[98] | LWR | BLAST;	
assign	ar[97] = aden[97] | LWR | BLAST;	
assign	ar[96] = aden[96] | LWR | BLAST;
assign	ar[95] = aden[95] | LWR | BLAST;	
assign	ar[94] = aden[94] | LWR | BLAST;	
assign	ar[93] = aden[93] | LWR | BLAST;	
assign	ar[92] = aden[92] | LWR | BLAST;	
assign	ar[91] = aden[91] | LWR | BLAST;	
assign	ar[90] = aden[90] | LWR | BLAST;	
assign	ar[89] = aden[89] | LWR | BLAST;	
assign	ar[88] = aden[88] | LWR | BLAST;	
assign	ar[87] = aden[87] | LWR | BLAST;	
assign	ar[86] = aden[86] | LWR | BLAST;		
assign	ar[85] = aden[85] | LWR | BLAST;	
assign	ar[84] = aden[84] | LWR | BLAST;	
assign	ar[83] = aden[83] | LWR | BLAST;	
assign	ar[82] = aden[82] | LWR | BLAST;	
assign	ar[81] = aden[81] | LWR | BLAST;	
assign	ar[80] = aden[80] | LWR | BLAST;	
assign	ar[79] = aden[79] | LWR | BLAST;	
assign	ar[78] = aden[78] | LWR | BLAST;	
assign	ar[77] = aden[77] | LWR | BLAST;	
assign	ar[76] = aden[76] | LWR | BLAST;
assign	ar[75] = aden[75] | LWR | BLAST;	
assign	ar[74] = aden[74] | LWR | BLAST;	
assign	ar[73] = aden[73] | LWR | BLAST;	
assign	ar[72] = aden[72] | LWR | BLAST;	
assign	ar[71] = aden[71] | LWR | BLAST;	
assign	ar[70] = aden[70] | LWR | BLAST;	
assign	ar[69] = aden[69] | LWR | BLAST;	
assign	ar[68] = aden[68] | LWR | BLAST;	
assign	ar[67] = aden[67] | LWR | BLAST;	
assign	ar[66] = aden[66] | LWR | BLAST;	
assign	ar[64] = aden[64] | LWR | BLAST;	
assign	ar[63] = aden[63] | LWR | BLAST;	
assign	ar[62] = aden[62] | LWR | BLAST;	
assign	ar[61] = aden[61] | LWR | BLAST;	
assign	ar[60] = aden[60] | LWR | BLAST;	
assign	ar[59] = aden[59] | LWR | BLAST;	
assign	ar[58] = aden[58] | LWR | BLAST;	
assign	ar[57] = aden[57] | LWR | BLAST;	
assign	ar[56] = aden[56] | LWR | BLAST;
assign	ar[55] = aden[55] | LWR | BLAST;	
assign	ar[54] = aden[54] | LWR | BLAST;	
assign	ar[53] = aden[53] | LWR | BLAST;	
assign	ar[52] = aden[52] | LWR | BLAST;	
assign	ar[51] = aden[51] | LWR | BLAST;	
assign	ar[50] = aden[50] | LWR | BLAST;	
assign	ar[49] = aden[49] | LWR | BLAST;	
assign	ar[48] = aden[48] | LWR | BLAST;	
assign	ar[47] = aden[47] | LWR | BLAST;	
assign	ar[46] = aden[46] | LWR | BLAST;		
assign	ar[45] = aden[45] | LWR | BLAST;	
assign	ar[44] = aden[44] | LWR | BLAST;	
assign	ar[43] = aden[43] | LWR | BLAST;	
assign	ar[42] = aden[42] | LWR | BLAST;	
assign	ar[41] = aden[41] | LWR | BLAST;	
assign	ar[40] = aden[40] | LWR | BLAST;	
assign	ar[39] = aden[39] | LWR | BLAST;	
assign	ar[38] = aden[38] | LWR | BLAST;	
assign	ar[37] = aden[37] | LWR | BLAST;	
assign	ar[36] = aden[36] | LWR | BLAST;
assign	ar[35] = aden[35] | LWR | BLAST;	
assign	ar[34] = aden[34] | LWR | BLAST;	
assign	ar[33] = aden[33] | LWR | BLAST;	
assign	ar[32] = aden[32] | LWR | BLAST;	
assign	ar[31] = aden[31] | LWR | BLAST;	
assign	ar[30] = aden[20] | LWR | BLAST;	
assign	ar[29] = aden[29] | LWR | BLAST;	
assign	ar[28] = aden[28] | LWR | BLAST;	
assign	ar[27] = aden[27] | LWR | BLAST;	
assign	ar[26] = aden[26] | LWR | BLAST;
assign	ar[25] = aden[25] | LWR | BLAST;	
assign	ar[24] = aden[24] | LWR | BLAST;	
assign	ar[23] = aden[23] | LWR | BLAST;	
assign	ar[22] = aden[22] | LWR | BLAST;	
assign	ar[21] = aden[21] | LWR | BLAST;	
assign	ar[20] = aden[20] | LWR | BLAST;	
assign	ar[19] = aden[19] | LWR | BLAST;	
assign	ar[18] = aden[18] | LWR | BLAST;	
assign	ar[17] = aden[17] | LWR | BLAST;	
assign	ar[16] = aden[16] | LWR | BLAST;		
assign	ar[15] = aden[15] | LWR | BLAST;	
assign	ar[14] = aden[14] | LWR | BLAST;	
assign	ar[13] = aden[13] | LWR | BLAST;	
assign	ar[12] = aden[12] | LWR | BLAST;	
assign	ar[11] = aden[11] | LWR | BLAST;	
assign	ar[10] = aden[10] | LWR | BLAST;	
assign	ar[9] = aden[9] | LWR | BLAST;	
assign	ar[8] = aden[8] | LWR | BLAST;	
assign	ar[7] = aden[7] | LWR | BLAST;	
assign	ar[6] = aden[6] | LWR | BLAST;
assign	ar[5] = aden[5] | LWR | BLAST;	
assign	ar[4] = aden[4] | LWR | BLAST;	
assign	ar[3] = aden[3] | LWR | BLAST;	
assign	ar[2] = aden[2] | LWR | BLAST;
assign	ar[1] = aden[1] | LWR | BLAST;	
assign	ar[0] = aden[0] | LWR | BLAST;







endmodule

