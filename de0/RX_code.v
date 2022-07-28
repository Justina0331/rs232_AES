module RX_code(data_out, data_in, load_port_b, tx_start, clk, rst);

	input  data_in, clk, rst;
	output data_out, load_port_b, tx_start;
	
	wire rst;
	reg  CHECK_TIME;
	reg  s, d;			       //正負元檢查
	reg  start, restart, package_start, tx_start;
	reg  load_port_b;
	reg  [63:0]data_out;
	reg  [5:0]check_q, package_q;
	reg  [12:0]div;
  reg  [2:0]ps, ns;
  
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
	 tx_start <= 0;
	 if(package_q == 8)    tx_start <= 1;
	end
  
  //檢查開始及結束(package)
	always @(posedge clk)
	begin
	 if(rst) package_start <= 0;
	 else
			begin
				if(~package_start & start)  package_start <= 1;
				if(package_q >= 8)          package_start <= 0;
			end
	end
  
	//檢查開始及結束(byte)
	always @(posedge clk) 
	begin
	 if(rst | restart)
			begin
				s <= 0;
				d <= 0;
				start <= 0;
			end
	 else
			begin
				{s, d} <= {d, data_in};
				if(~start)        start <= ~d&s;
				if(check_q >= 19) start <= d&~s;
			end
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
			if(div == 1266)	//1266
				begin
					CHECK_TIME <= ~CHECK_TIME;
					div <= 0;
				end
			else
			  if(start)  div <= div+1;	
	end
	
	//紀錄接收bit
	always @(posedge CHECK_TIME, posedge rst, posedge restart)
	begin
		if(rst | restart)
      check_q <= 0;
		else
		  if(start) check_q <= check_q + 1;
	end
	
	//紀錄接收byte
	always @(posedge clk)
	begin
	  if(rst || ~package_start & start || package_q == 9)
      package_q <= 0;
		if(package_start & restart) package_q <= package_q + 1; 
		if(package_q == 8)          package_q <= package_q + 1; 
	end
	
	//將接收的bit存入data
	always @(check_q)
	begin
	  if(package_q==0 && check_q==1) data_out <= 0;
	  if(rst)  data_out <= 0;
		case(check_q)   
			3:   
			begin
			 data_out[0 + package_q*8] <= data_in;
			end
			5:
			begin
			 data_out[1 + package_q*8] <= data_in;
			end
			7:
			begin
			 data_out[2 + package_q*8] <= data_in;
			end
			9:
			begin
			 data_out[3 + package_q*8] <= data_in;
			end
			11:
			begin
			 data_out[4 + package_q*8] <= data_in;
			end
			13:
      begin
			 data_out[5 + package_q*8] <= data_in;
			end
			15:
			begin
			 data_out[6 + package_q*8] <= data_in;
			end
		  17:
		  begin
			 data_out[7 + package_q*8] <= data_in;
			end
		endcase	
	end
	
	//States
  always@(posedge clk)
  begin
    if(rst) ps <= T0;
    else    ps <= ns;
  end
    
  always@(*)
  begin
    load_port_b = 0;
    restart = 0;
    ns = T0;
    case(ps)
      T0://等待數字進來
      begin
        ns = T0;
		    load_port_b = 1;
        if(check_q >= 2)  ns = T1;
      end
      T1://8bit數字進來
      begin
        ns = T1;
        if(check_q >= 18)ns = T2;
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
    
endmodule

