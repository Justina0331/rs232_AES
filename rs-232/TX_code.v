module TX_code(data_out, data_in, tx_start, clk, rst);

  output  data_out;
  input   data_in, tx_start, clk, rst; 
    
  wire  data_out;
  wire  [31:0]data_in;
  reg   [31:0]data_r;
  reg   package_start, CHECK_TIME, restart, data;
  reg   start;
  reg   [5:0] check_q, package_q;
  reg   [12:0]div;
  reg   [2:0] ps,ns;

  parameter T0 = 0;
  parameter T1 = 1;
  parameter T2 = 2;
  parameter T3 = 3;
  parameter T4 = 4;
  parameter T5 = 5;
  parameter T6 = 6;
  
  //檢查開始及結束(package)
	always @(posedge clk)
	begin
	 if(rst) package_start <= 0;
	 else
			begin
				if(~package_start & tx_start) 
				begin
				  package_start <= 1;
				  data_r <= data_in;
				end
				if(package_q >= 4)            package_start <= 0;
			end
	end
	
	//檢查開始及結束(byte)
	always @(posedge clk) 
	begin
	 if(rst | restart | package_q == 4)   start <= 0;
	 else 
	   begin
				if(package_start & ~start) start <= 1;
				if(check_q >= 20)          start <= 0;
	   end
			
	end
	
	//紀錄接收bit
	always @(posedge CHECK_TIME, posedge rst, posedge restart)
	begin
		if(rst | restart)
      check_q <= 0;
		else
		  if(package_start) check_q <= check_q + 1;
	end
	
	//紀錄接收byte
	always @(posedge clk)
	begin
	  if(rst || ~package_start & start || package_q == 5)
      package_q <= 0;
		if(package_start & restart) package_q <= package_q + 1;
		if(package_q == 4)          package_q <= package_q + 1;  
	end

  //當package_start則開始傳送
	always @(check_q)
	begin
		case(check_q)
		  0:    data <= 1;
		  1:    data <= 0;
		  2:    data <= 0;
		  3:    data <= data_r[0 + package_q*8];
		  4:    data <= data;
		  5:    data <= data_r[1 + package_q*8];
		  6:    data <= data;
		  7:    data <= data_r[2 + package_q*8];
		  8:    data <= data;
		  9:    data <= data_r[3 + package_q*8];
		  10:   data <= data;
		  11:   data <= data_r[4 + package_q*8];
		  12:   data <= data;
		  13:   data <= data_r[5 + package_q*8];
		  14:   data <= data;
		  15:   data <= data_r[6 + package_q*8];
		  16:   data <= data;
		  17:   data <= data_r[7 + package_q*8];
		  18:   data <= data;
		  19:   data <= 1;
		  20:   data <= 1;
		endcase	
	end
  
  //CHECK_TIME
  always @(posedge clk)
	begin
		if(rst | restart)
			begin
				div <= 0;
				CHECK_TIME <= 1;
			end
		else
			if(div == 10)	//1286
				begin
					CHECK_TIME <= ~CHECK_TIME;
					div <= 0;
				end
			else
			  if(package_start)  div <= div+1;	
	end
	
	//States
  always@(posedge clk)
  begin
    if(rst) ps <= T0;
    else    ps <= ns;
  end
    
  always@(*)
  begin
    restart = 0;
    ns = T0;
    case(ps)
      T0://等待數字進來
      begin
        ns = T0;
        if(check_q >= 2)  ns = T1;
      end
      T1://8bit數字進來
      begin
        ns = T1;
        if(check_q >= 20)ns = T2;
      end
      T2://數字讀完顯示於LED
      begin
        ns = T2;
        if(~start) 
        begin
          restart = 1;
          ns = T0;
        end
      end
    endcase 
  end
    
  assign data_out = data;

endmodule



