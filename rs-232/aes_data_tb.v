module aes_data_tb;
  
	wire TX;
	reg  RX, clk, rst, sw2, sw1 ,sw0;
	wire [7:0]port_b_out;
  
	rs232 f_rs232(TX, RX, sw2, sw1 ,sw0, clk, rst, port_b_out);
	initial begin
		rst = 1; clk = 0; RX = 1; sw2 = 0; sw1 = 0; sw0 = 0; //按下reset並將clk清0
	#20 rst = 0;  		   //放開reset
	
	
	///////////////////////////////////////////////
  ///////////////////測試非02開始/////////////////
  ///////////////////////////////////////////////
  
	#1000 RX = 0;	      //開始0101_0101
	#1000 RX = 1;		  //55
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束(非02因此未開始)
	
	///////////////////////////////////////////////
  ///////////////測試8bytes但非03結束/////////////
  ///////////////////////////////////////////////
  
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始0000_0010
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 1111_1111
	#1000 RX = 1;       //ff
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 1111_0000
	#1000 RX = 0;       //f0
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0101_0101
	#1000 RX = 1;       //55
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 1010_1010
	#1000 RX = 0;       //aa
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 0011_1100
	#1000 RX = 0;       //3c
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0011
	#1000 RX = 1;       //c3
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0000
	#1000 RX = 0;       //c0
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	#5000 RX = 1;
	
	
	
	//////////////
	//第一組測資//
	/////////////
	
	
  //11223344/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 81(寫入ram[1])
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0001_0001
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0010_0010
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0011_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 0100_0100
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	
	//22334455/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 82(寫入ram[2])
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0010_0010
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0011_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0100_0100
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 0101_0101
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	//33445566/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 83(寫入ram[3])
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0011_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0100_0100
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0101_0101
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 0110_0110
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	//44556677/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 84(寫入ram[4])
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0100_0100
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0101_0101
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0110_0110
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 0111_0111
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	//55667788/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 85(寫入ram[5])
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0101_0101
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0110_0110
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0111_0111
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 1000_1000
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	
	//////////////
	//第二組測資//
	/////////////
	
	
	//11111111/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 E5(寫入ram[101])1110 0101
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0001_0001
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0001_0001
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0001_0001
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 0001_0001
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 0001_0001
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	
	//22222222/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 E6(寫入ram[102])1110 0110
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0010_0010
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0010_0010
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0010_0010
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 0010_0010
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 0010_0010
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	//33333333/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 E7(寫入ram[103])1110 0111
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0011_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0011_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0011_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 0011_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 0011_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	//44444444/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 E8(寫入ram[104])1110 1000
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0100_0100
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0100_0100
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0100_0100
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 0100_0100
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 0100_0100
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	//55667788/////////////////////////////////////
  //////////////測試正確8bytes(寫入)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 E9(寫入ram[105])1110 1001
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0101_0101
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0110_0110
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0111_0111
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 1000_1000
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	///////////////////////////////////////////
  //////////////測試正確8bytes(讀出)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 69(讀出ram[106])0110 1010
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0101_0101
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0110_0110
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0111_0111
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 1000_1000
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	
	///////////////////////////////////////////
  //////////////測試正確8bytes(讀出)//////////////
  ///////////////////////////////////////////////
	
	///////////////////1_byte//////////////////////
	#1000 RX = 0;	      //開始02
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////2_byte//////////////////////
	#1000 RX = 0;       //開始 6D(讀出ram[109])0110 1101
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////3_byte//////////////////////
	#1000 RX = 0;       //開始 0101_0101
	#1000 RX = 1;       
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////4_byte//////////////////////
	#1000 RX = 0;       //開始 0110_0110
	#1000 RX = 0;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////5_byte//////////////////////
	#1000 RX = 0;       //開始 0111_0111
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	///////////////////6_byte//////////////////////
	#1000 RX = 0;       //開始 1000_1000
	#1000 RX = 0;       
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////7_byte//////////////////////
	#1000 RX = 0;       //開始 1100_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;
	#1000 RX = 1;
	#1000 RX = 1;       //結束
	///////////////////8_byte//////////////////////
	#1000 RX = 0;       //開始 0000_0011
	#1000 RX = 1;       
	#1000 RX = 1;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 0;
	#1000 RX = 1;       //結束
	#3000 RX = 1;
	
	////////////////////////////////////////////////
	#250000 $stop;      //執行到指定時間後停止
	end
  
	always #10 clk = ~clk;
  
endmodule



