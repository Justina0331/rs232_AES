
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module mcu(

	//////////// CLOCK //////////
	input CLK,

	//////////// 7-segment decoder //////////
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	
	//////////// LED /////////////
	output [9:0] LED,
	
	//////////// SWITCH //////////
	input [9:0] SW,
	
	//////////// BUTTON //////////
	input [2:0] BTN,
	
	//////////// RS232 ///////////
	input RX,
	output TX
	
);
//*******************************//

rs232 f_rs232(.TX(TX), .RX(RX), .sw2(SW[2]), .sw1(SW[1]), .sw0(SW[0]), .clk(CLK), .rst(!BTN[0]), .port_b_out(LED[7:0]));

//*******************************//

endmodule
