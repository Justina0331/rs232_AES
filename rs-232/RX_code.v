module RX_code(data_in, load_port_b, tx_start, clk, rst, ram_out);

	input  data_in, clk, rst;
	output load_port_b, tx_start, ram_out;
	
	reg  s, d;			       //正負元檢查
	reg  start, rst_start, rst_data, rst_counter, package_start, tx_start, finish;
	reg  load_port_b, load_package, load_finish, packet_loss, idle;
	wire [31:0]ram_out;
	reg  [5:0]check_q, package_q;
	reg  [12:0]counter;
    reg  [3:0]ps, ns;
    reg  [20:0]watch_dog;
    reg  en;          //控制讀出/寫入
    wire [6:0]addr;   //讀出/寫入位置
  
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
	parameter T10 = 10;
  
	//檢查開始及結束(byte)
	always @(posedge clk) 
	begin
		if(rst | rst_start)
		begin
			s <= 0;
			d <= 0;
			start <= 0;
		end
		else
		begin
			{s, d} <= {d, data_in};
			if(~start) start <= ~d&s;
		end
	end

	//delta_time_1_5_flag
	reg [12:0]  cnt_1_5;
	reg rst_cnt_1_5;
	reg delta_time_1_5_flag;
	always @(posedge clk)
	begin
		if(rst | rst_cnt_1_5)
		begin 
			cnt_1_5 <= 0;
			delta_time_1_5_flag <= 0;
		end
		else 
		begin 
			cnt_1_5 <= cnt_1_5 + 1;
			if(cnt_1_5 >= 69)  delta_time_1_5_flag <= 1;
		end
		
	end
	
	
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
			if(cnt_1 >= 46)  delta_time_1_flag <= 1;
		end
		
	end
	
	//watch dog
	always @(posedge clk)
	begin
		if(rst | idle) 
		begin
			packet_loss <= 0;
			watch_dog <= 0;
		end
		else if(watch_dog > 500000)	packet_loss <= 1;
		else 						 			watch_dog <= watch_dog + 1; 
	end

	//紀錄接收bit
	reg [4:0] cnt_rx_bits;
	reg inc_cnt_rx_bits;
	reg rst_cnt_rx_bits;
	always @(posedge clk)
	begin
		if(rst | rst_cnt_rx_bits)	cnt_rx_bits <= 0;
		else if (inc_cnt_rx_bits)	cnt_rx_bits <= cnt_rx_bits + 1;
	end
	
	//紀錄接收byte
	reg [4:0] cnt_rx_bytes;
	reg inc_cnt_rx_bytes;
	reg rst_cnt_rx_bytes;
	always @(posedge clk)
	begin
		if(rst | rst_cnt_rx_bytes)	cnt_rx_bytes <= 0;
		else if (inc_cnt_rx_bytes)	cnt_rx_bytes <= cnt_rx_bytes + 1;
	end
	
	//RAM
	reg write_en;
	reg read_en;
	reg [63:0] data_out;
	assign addr = data_out[14:8];
	ram_128x32 RAM(data_out[47:16], addr, write_en, read_en, clk, ram_out);
	
	//TX_start
	//data_out[15]=0 -> tx傳輸資料
	always @(posedge clk)
	begin
		if(read_en)	tx_start <= 1;
		else		tx_start <= 0;
	end
	
	//將接收的bit存入data
	reg shift_reg;
	always @(posedge clk)
	begin
		if(rst | rst_data)	data_out <= 0;
		else if(shift_reg)	data_out <= {data_in, data_out[63:1]};
	end
	
	//States
	always@(posedge clk)
	begin
		if(rst) ps <= T0;
		else    ps <= ns;
	end

	always@(*)
	begin
		ns = T0;
		load_port_b = 0;
		load_finish = 0;
		idle = 0;
		
		rst_cnt_1_5 = 0;
		rst_cnt_1 = 0;
		
		shift_reg = 0;
		
		rst_cnt_rx_bits = 0;
		inc_cnt_rx_bits = 0;
		
		inc_cnt_rx_bytes = 0;
		rst_cnt_rx_bytes = 0;
		
		rst_start = 0;
		rst_data = 0;
		en = 0;
		write_en = 0;
		read_en = 0;

		case(ps)
			T0:
			begin
				ns = T1;
			end
			T1://idle
			begin
				//package start
				if (start)
				begin
					rst_cnt_rx_bytes = 1;
					rst_cnt_rx_bits  = 1;
					rst_cnt_1_5 = 1;
					rst_data = 1;
					ns = T3;
				end
				else  
				begin
					idle = 1;
					load_port_b = 1;
					ns = T1;
				end
			end
			T2://wait_byte_start
			begin
				// bit start
				if (start)
				begin
					rst_cnt_rx_bits = 1;
					rst_cnt_1_5 = 1;
					ns = T3;
				end
				else  
				begin
					//idle = 1;
					ns = T2;
				end		
				
				if(packet_loss) ns = T1;
			end
			T3://delay 1.5 delta_time
			begin
				if (delta_time_1_5_flag)	ns = T4;
				else 						ns = T3;
				
				if(packet_loss) ns = T1;
			end
			T4://receive 1 bit
			begin
				shift_reg = 1;
				inc_cnt_rx_bits = 1;
				ns = T5;
				
				if(packet_loss) ns = T1;
			end
			T5://count 8bits
			begin
				if (cnt_rx_bits > 7) ns = T7;
				else 
				begin
					rst_cnt_1 = 1;
					ns = T6;
				end
				
				if(packet_loss) ns = T1;
			end
			T6://delay 1 delta_time
			begin
				if(delta_time_1_flag)	ns = T4;
				else 					ns = T6;
				
				if(packet_loss) ns = T0;
			end
			T7://receive 1 byte
			begin
				inc_cnt_rx_bytes = 1;
				ns = T8;
				
				if(packet_loss) ns = T1;
			end
			T8://count 8bytes 
			begin
				rst_start = 1;
				//if this is first byte, check 02?
				if (cnt_rx_bytes == 1 & data_out[63:56] != 8'h02)	ns = T1;

				//check package finish?
				else if (cnt_rx_bytes > 7)	ns = T9;
				else 							ns = T2;
				
				if(packet_loss) ns = T1;
			end
			T9://CHECK DATA
			begin
				//check last byte 03?
				if(data_out[63:56] == 8'h03)
				begin
					if(data_out[15])  write_en = 1;
					else					read_en = 1;
				end
				ns = T1;
				
				if(packet_loss) ns = T1;
			end
			

		endcase 
  end
    
endmodule

