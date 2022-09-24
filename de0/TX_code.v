module TX_code(data_out, data_in, tx_start, clk, rst);

	output  data_out;
	input   data_in, tx_start, clk, rst; 
   
	wire  data_out;
	wire  [31:0]data_in;
	reg   [31:0]data_r;
	reg   package_start, restart, rst_counter, data;
	reg   start, idle, load_finish, load_package;
	reg   [5:0] check_q, package_q;
	reg   [12:0]counter;
	reg   [3:0] ps,ns;

	parameter T0 = 0;
	parameter T1 = 1;
	parameter T2 = 2;
	parameter T3 = 3;
	parameter T4 = 4;
	parameter T5 = 5;
	parameter T6 = 6;
	parameter T7 = 7;
	parameter T8 = 8;
	parameter T9 = 9;
  
	//檢查開始及結束(package)
	reg shift_reg;
	always @(posedge clk)
	begin
		if(rst)					data_r <= 32'b0;
		else if(load_package)	data_r <= data_in;
		else if(shift_reg)	data_r <= {data_r[0], data_r[31:1]};
	end
	
	//檢查開始及結束(byte)
	/*always @(posedge clk) 
	begin
	 if(rst | restart | load_finish)   start <= 0;
	 else 
	   begin
			if(package_start & ~start) start <= 1;
			if(check_q >= 20)          start <= 0;
	   end
	end*/
	
	//counter
	/*always @(posedge clk)
	begin
		if(rst | restart | rst_counter | idle)  counter <= 0;
		else if(counter==20)          	 		counter <= 0;
		else if(package_start)                  counter <= counter+1;	
		
	end*/
	
	//delta_time_1_flag
	reg [12:0]  cnt_1;
	reg rst_cnt_1;
	reg delta_time_1_flag;
	always @(posedge clk)
	begin
		if(rst | rst_cnt_1)	
		begin 
			cnt_1 <= 0;
			delta_time_1_flag <= 0;
		end
		else 
		begin 
			cnt_1 <= cnt_1 + 1;
			if(cnt_1 >= 2600)  delta_time_1_flag <= 1;
		end
		
	end
	
	//紀錄接收bit
	/*always @(posedge clk)
	begin
		if(rst | restart | idle)		check_q <= 0;
		else if(counter==20)	check_q <= check_q + 1;
	end*/
	
	//紀錄傳送bit
	reg [4:0] cnt_tx_bits;
	reg inc_cnt_tx_bits;
	reg rst_cnt_tx_bits;
	always @(posedge clk)
	begin
		if(rst | rst_cnt_tx_bits)	cnt_tx_bits <= 0;
		else if (inc_cnt_tx_bits)	cnt_tx_bits <= cnt_tx_bits + 1;
	end
	
	//紀錄接收byte
	/*always @(posedge clk)
	begin
		if(rst | idle | package_q == 4)	package_q <= 0;
		if(package_start & restart) package_q <= package_q + 1;
	end*/
	
	//紀錄傳送byte
	reg [4:0] cnt_tx_bytes;
	reg inc_cnt_tx_bytes;
	reg rst_cnt_tx_bytes;
	always @(posedge clk)
	begin
		if(rst | rst_cnt_tx_bytes)	cnt_tx_bytes <= 0;
		else if (inc_cnt_tx_bytes)	cnt_tx_bytes <= cnt_tx_bytes + 1;
	end

	//當package_start則開始傳送
	/*always @(posedge clk)
	begin
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
	end*/
	
	//將data傳出
	reg start_data;
	reg tx_bit;
	reg rst_data;
	always @(posedge clk)
	begin
		if(rst | rst_data)	data <= 1;
		if(start_data)		data <= 0;
		else if(tx_bit)	data <= data_r[0];
	end
	
	//States
	always@(posedge clk)
	begin
		if(rst) ps <= T0;
		else    ps <= ns;
	end
    
	always@(*)
	begin
	
		rst_cnt_1 = 0;
		
		load_package = 0;
		shift_reg = 0;
		tx_bit = 0;
		
		rst_cnt_tx_bits = 0;
		inc_cnt_tx_bits = 0;
		
		inc_cnt_tx_bytes = 0;
		rst_cnt_tx_bytes = 0;
		
		start_data = 0;
		rst_data = 0;
		ns = T0;
		
		case(ps)
			T0:
			begin
				ns = T1;
			end
			T1://等待數字進來
			begin
				//package start
				if (tx_start)
				begin
					rst_cnt_tx_bytes = 1;
					rst_cnt_tx_bits  = 1;
					rst_cnt_1 = 1;
					load_package = 1;
					start_data = 1;
					ns = T3;
				end
				else  
				begin
					//idle = 1;
					ns = T1;
				end			
			end
			T2://byte_start
			begin
			  start_data = 1;
				rst_cnt_tx_bits = 1;
				rst_cnt_1 = 1;
				ns = T3;
			end
			T3://delay 1 delta_time
			begin
				if (delta_time_1_flag)	ns = T4;
				else 					ns = T3;
			end
			T4://receive 1 bit
			begin
				tx_bit = 1;
				inc_cnt_tx_bits = 1;
				ns = T5;
			end
			T5://count 8bits
			begin
				rst_cnt_1 = 1;
				shift_reg = 1;
				if (cnt_tx_bits > 7) 	ns = T6;
				else 					ns = T3;
			end
			T6://delay 1 delta_time
			begin
				if (delta_time_1_flag)	ns = T7;
				else 					ns = T6;
			end
			T7://receive 1 byte
			begin
			  rst_data = 1;
				rst_cnt_1 = 1;
				inc_cnt_tx_bytes = 1;
				ns = T8;
			end
			T8://delay 1 delta_time
			begin
				if (delta_time_1_flag)	ns = T9;
				else 					ns = T8;
			end
			T9://count 4bytes 
			begin				
				//check package finish?
				if (cnt_tx_bytes > 3)	ns = T1;
				else 					ns = T2;
			end
		endcase 
	end
    
	assign data_out = data;

endmodule



