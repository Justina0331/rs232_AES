module rs232_test;
  
  wire TX;
  wire [6:0]high_segment_q;
	wire [6:0]low_segment_q;
  reg  RX, clk, rst;
  wire [7:0]port_b_out;
  
  rs232 f_rs232(TX, RX, clk, rst, port_b_out);
  initial begin
      rst = 1; clk = 0; RX = 1; //按下reset並將clk清0
  #20 rst = 0;  		   //放開reset
	#890 RX = 0;	      //開始1001_1000
	#890 RX = 1;
	#890 RX = 0;
	#890 RX = 0;
	#890 RX = 1;
	#890 RX = 1;
	#890 RX = 0;
	#890 RX = 0;
	#890 RX = 0;
	#890 RX = 1;       //結束
	#890 RX = 1;       //待機
	#890 RX = 0;       //開始 0000_1000
	#890 RX = 0;       
	#890 RX = 0;
	#890 RX = 0;
	#890 RX = 0;
	#890 RX = 1;
	#890 RX = 0;
	#890 RX = 0;
	#890 RX = 0;
	#890 RX = 1;       //結束
	#890 RX = 1;       //待機
  #10000 $stop;      //執行到指定時間後停止
  end
  
  always #10 clk = ~clk;
  
endmodule