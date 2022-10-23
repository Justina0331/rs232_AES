module RX_code(data_in, tx_start, clk, rst, ram_data_out);

	input  data_in, clk, rst;
	output tx_start;
	output [31:0] ram_data_out;
    
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
	parameter T11 = 11;
	parameter T12 = 12;
	parameter T13 = 13;
	
	parameter ENCRYPT = 1;
	parameter DECRYPT = 0;
	parameter KEY_TYPE_128 = 0;
	parameter KEY_TYPE_256 = 1;
  
	//檢查開始及結束(byte)
	reg  s, d;			       //正負元檢查
	reg  start, rst_start;
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
	reg idle;
	reg [11:0]  cnt_1_5;
	reg rst_cnt_1_5;
	reg delta_time_1_5_flag;
	always @(posedge clk)
	begin
		if(rst | rst_cnt_1_5 | idle)
		begin 
			cnt_1_5 <= 0;
			delta_time_1_5_flag <= 0;
		end
		else 
		begin 
			cnt_1_5 <= cnt_1_5 + 1;
		//	if(cnt_1_5 >= 3900)  delta_time_1_5_flag <= 1;	//Quartus
			if(cnt_1_5 >= 69)  delta_time_1_5_flag <= 1;	//Simulation
		end
		
	end
	
	//delta_time_1_flag
	reg [11:0]  cnt_1;
	reg rst_cnt_1;
	reg delta_time_1_flag;
	always @(posedge clk)
	begin
		if(rst | rst_cnt_1 | idle)	
		begin 
			cnt_1 <= 0;
			delta_time_1_flag <= 0;
		end
		else 
		begin 
			cnt_1 <= cnt_1 + 1;
		//	if(cnt_1 >= 2600)  delta_time_1_flag <= 1;	//Quartus
			if(cnt_1 >= 46)  delta_time_1_flag <= 1;	//Simulation
		end
		
	end
	
	//watch dog
	reg [20:0]watch_dog;
	reg packet_loss;
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
		if(rst | rst_cnt_rx_bits | idle)	cnt_rx_bits <= 0;
		else if (inc_cnt_rx_bits)			cnt_rx_bits <= cnt_rx_bits + 1;
	end
	
	//紀錄接收byte
	reg [4:0] cnt_rx_bytes;
	reg inc_cnt_rx_bytes;
	reg rst_cnt_rx_bytes;
	always @(posedge clk)
	begin
		if(rst | rst_cnt_rx_bytes | idle)	cnt_rx_bytes <= 0;
		else if (inc_cnt_rx_bytes)			cnt_rx_bytes <= cnt_rx_bytes + 1;
	end
	
	//將接收的bit存入data
	reg rst_data;
	reg [63:0] data_out;
	reg shift_reg;
	always @(posedge clk)
	begin
		if(rst | rst_data | idle)	data_out <= 0;
		else if(shift_reg)			data_out <= {data_in, data_out[63:1]};
	end

	//system key
	reg  [255:0] system_key;
	reg load_key_128;
	reg load_key_256;
	always @(posedge clk)
	begin
		system_key <= {8'h00, 8'h00, 8'h00, 8'h00,
					   8'h60, 8'h3d, 8'heb, 8'h10,
					   8'h15, 8'hca, 8'h71, 8'hbe,
				       8'h2b, 8'h73, 8'hae, 8'hf0,
				       8'h00, 8'h00, 8'h00, 8'h00,
				       8'h00, 8'h00, 8'h00, 8'h00,
				       8'h00, 8'h00, 8'h00, 8'h00,
				       8'h00, 8'h00, 8'h00, 8'h01};
	end
	/* 0000_0000, 0000_0000, 0000_0000, 0000_0000
	   0110_0000, 0011_1101, 1110_1011, 0001_0000
	   0001_0101, 1100_1010, 0111_0001, 1011_1110
	   0010_1011, 0111_0011, 1010_1110, 1111_0000
	   
	   0000_0000, 0000_0000, 0000_0000, 0000_0000
	   0000_0000, 0000_0000, 0000_0000, 0000_0000
	   0000_0000, 0000_0000, 0000_0000, 0000_0000
	   0000_0000, 0000_0000, 0000_0000, 0000_0001
	   
	   [33] 1000_0000,1000_0000,1000_0000,1000_0000
	   [32] 1000_0000,1000_0000,1000_0000,1000_0000
	   [31] 1011_0000,1000_1111,1011_1101,1011_0001
	   [30] 1000_0000,1101_0111,1001_0100,1111_0001
	   [29] 1101_1111,1000_1010,1110_1110,1011_1010
	   
	   [28] 1111_0111,1100_0000,1000_0000,1000_0000
	   [27] 1000_0000,1000_0000,1000_0000,1000_0000
	   [26] 1000_0000,1000_0000,1000_0000,1000_0000
	   [25] 1000_0000,1000_0000,1000_0000,1000_0000
	   [24] 1000_0000,1000_0000,1000_0000,1000_0001
	*/
	
	//AES
	reg  [127:0] aes_in;
	wire [127:0] aes_out;
	reg	 aes_flag;
	wire result_valid;
	wire ready;
	reg  init;
	reg	 next;
	reg  AES_ACTION, KEY_TYPE;
	reg [255:0] user_key;
	aes_core aes(clk, rst, AES_ACTION, init, next, ready, system_key, KEY_TYPE, aes_in, aes_out, result_valid);
	
	//////////////////////////////////////////////
	/////*RAM                              *//////
	/////*[0]-[3] RESERVE                  *//////
	//////////////////////////////////////////////
	///////////WRITE AND READ/////////////////////
	/////*[4]-[8] 	INPUT DATA(5)          *//////
	/////*[9]	  	DO 128 ENCRYPT         *//////
	/////*[10]	  	DO 128 DECRYPT         *//////
	/////*[11]	  	DO 256 ENCRYPT         *//////
	/////*[12]	  	DO 256 DECRYPT         *//////
	/////*[13]-[16] INPUT DATA(4)          *//////
	/////*                                 *////// 
	/////*[24-33]	KEY                    *//////
	//////////////////////////////////////////////
	//////////////READ ONLY///////////////////////
	/////*[60] 	   *AES OUTPUT TYPE        *//////none
	/////*[64]-[68] AES OUTPUT(5)          *//////
	/////*[73]-[76] AES OUTPUT(4)          *//////
	//////////////////////////////////////////////
	////////AES TYPE///////none
	//* 0:IDLE			*//
	//* 1:128 ENCRYPT	*//
	//* 2:128 DECRYPT	*//
	//* 3:256 ENCRYPT	*//
	//* 4:256 DECRYPT	*//
	///////////////////////
	
	//RAM
	reg write_data_en;
	reg read_data_en;
	wire [6:0]  addr;
	wire [31:0] ram_data_in;
	reg  [31:0] ram_data_out;
	reg  load_addr;
	reg  load_ram;
	
	assign addr = load_addr ? data_out[14:8] : addr;
	assign ram_data_in = load_ram ? data_out[47:16] : ram_data_in;
	
	//ram_in
	reg [31:0] ram[127:0];
	//reg [31:0] aes_out_ram[63:0];
	reg load_aes_out;
	reg load_input_4;
	always @ (posedge clk)
	begin
		if(write_data_en)	
		begin
			ram[addr] <= ram_data_in;
		end
		
		if(load_input_4)
		begin
			ram[13] <= {ram[5][3:0]  , ram[4][30:24], ram[4][22:16], ram[4][14:8] , ram[4][6:0]                 };
			ram[14] <= {ram[6][8]    , ram[6][6:0]  , ram[5][30:24], ram[5][22:16], ram[5][14:8] , ram[5][6:4]  };
			ram[15] <= {ram[7][12:8] , ram[7][6:0]  , ram[6][30:24], ram[6][22:16], ram[6][14:9]                };
			ram[16] <= {ram[8][17:16], ram[8][14:8] , ram[8][6:0]  , ram[7][30:24], ram[7][22:16], ram[7][14:13]};
			
			ram[60]   <= 32'h00000000;
		end
		
		if(load_aes_out)
		begin
			ram[64] <= {1'b1,aes_out[27:21],  1'b1,aes_out[20:14],1'b1  ,aes_out[13:7]   ,1'b1,aes_out[6:0]};
			ram[65] <= {1'b1,aes_out[55:49],  1'b1,aes_out[48:42],1'b1  ,aes_out[41:35]  ,1'b1,aes_out[34:28]};
			ram[66] <= {1'b1,aes_out[83:77],  1'b1,aes_out[76:70],1'b1  ,aes_out[69:63]  ,1'b1,aes_out[62:56]};
			ram[67] <= {1'b1,aes_out[111:105],1'b1,aes_out[104:98],1'b1 ,aes_out[97:91]  ,1'b1,aes_out[90:84]};
			ram[68] <= {14'b11111111111111,        aes_out[127:126],1'b1,aes_out[125:119],1'b1,aes_out[118:112]};
			
			ram[73] <= aes_out[31:0];
			ram[74] <= aes_out[63:32];
			ram[75] <= aes_out[95:64];
			ram[76] <= aes_out[127:96];

			ram[60]   <= 32'hffffffff;
		end
		
	end
	
	
	always@(posedge clk)
	begin
		if(read_data_en) 	ram_data_out <= ram[addr];
		//else 			ram_data_out <= aes_out_ram[addr-64];
	end
	
	//check if the same key
	wire same_key_flag;
	
	always @(posedge clk)
	begin
		if(load_key_128)
		user_key <= {	ram[28][17:16],ram[28][14:8],ram[28][6:0],
						ram[27][30:24],ram[27][22:16],ram[27][14:8],ram[27][6:0],
						ram[26][30:24],ram[26][22:16],ram[26][14:8],ram[26][6:0],
						ram[25][30:24],ram[25][22:16],ram[25][14:8],ram[25][6:0],
						ram[24][30:24],ram[24][22:16],ram[24][14:8],ram[24][6:0],
						128'h00000000};
		if(load_key_256)
		user_key <= {	ram[28][17:16],ram[28][14:8],ram[28][6:0],
						ram[27][30:24],ram[27][22:16],ram[27][14:8],ram[27][6:0],
						ram[26][30:24],ram[26][22:16],ram[26][14:8],ram[26][6:0],
						ram[25][30:24],ram[25][22:16],ram[25][14:8],ram[25][6:0],
						ram[24][30:24],ram[24][22:16],ram[24][14:8],ram[24][6:0],
						
						ram[33][17:16],ram[33][14:8] ,ram[33][6:0],
						ram[32][30:24],ram[32][22:16],ram[32][14:8],ram[32][6:0],
						ram[31][30:24],ram[31][22:16],ram[31][14:8],ram[31][6:0],
						ram[30][30:24],ram[30][22:16],ram[30][14:8],ram[30][6:0],
						ram[29][30:24],ram[29][22:16],ram[29][14:8],ram[29][6:0]};
	end
	assign same_key_flag = load_key_128 ? (system_key[255:128] === user_key[255:128]) ? 1 : load_key_256 ? (system_key === user_key) ? 1 : 0 : 0 : same_key_flag;
	
	/*always @ (posedge clk)
	begin
		if(rst)											same_key_flag = 0;
		if(load_key_128)
		begin
			if(system_key[127:0] == user_key[127:0])	same_key_flag = 1;
		end
		else if(load_key_256)
		begin
			if(system_key == user_key)					same_key_flag = 1;
		end
	end*/
	
	
	// AES data in
	reg load_aes_in;
	always @ (posedge clk)
	begin
		if(load_aes_in)
		begin
		aes_in <= {	ram[8][17:16], ram[8][14: 8], ram[8][6:0], 
					ram[7][30:24], ram[7][22:16], ram[7][14:8], ram[7][6:0], 
					ram[6][30:24], ram[6][22:16], ram[6][14:8], ram[6][6:0], 
					ram[5][30:24], ram[5][22:16], ram[5][14:8], ram[5][6:0], 
					ram[4][30:24], ram[4][22:16], ram[4][14:8], ram[4][6:0]};
		end
	end

	
	//AES data out in ram
	/*reg load_aes_out;
	always @ (posedge clk)
	begin
		if(load_aes_out)
		begin
			aes_out_ram[64] <= {1'b1,aes_out[27:21],  1'b1,aes_out[20:14],1'b1  ,aes_out[13:7]   ,1'b1,aes_out[6:0]};
			aes_out_ram[65] <= {1'b1,aes_out[55:49],  1'b1,aes_out[48:42],1'b1  ,aes_out[41:35]  ,1'b1,aes_out[34:28]};
			aes_out_ram[66] <= {1'b1,aes_out[83:77],  1'b1,aes_out[76:70],1'b1  ,aes_out[69:63]  ,1'b1,aes_out[62:56]};
			aes_out_ram[67] <= {1'b1,aes_out[111:105],1'b1,aes_out[104:98],1'b1 ,aes_out[97:91]  ,1'b1,aes_out[90:84]};
			aes_out_ram[68] <= {14'b00000000000000,        aes_out[127:126],1'b1,aes_out[125:119],1'b1,aes_out[118:112]};
			aes_out_ram[60]   <= 32'hffffffff;
		end
	end*/

	
	//TX_start
	//data_out[15]=0 -> tx傳輸資料
	reg tx_start;
	always @(posedge clk)
	begin
		if(read_data_en)	tx_start <= 1;
		else				tx_start <= 0;
	end
	
	//States
	reg [4:0]ps, ns;
	reg [4:0]aes_ps, aes_ns;
	always@(posedge clk)
	begin
		if(rst) 
		begin
			ps <= T0;
			aes_ps <= T0;
		end
		else    
		begin
			ps <= ns;
			aes_ps <= aes_ns;
		end
	end
	
	
	//aes fsm
	always@(*)
	begin
		aes_ns = T0;
		
		load_input_4 = 0;
		load_aes_in = 0;
		load_aes_out = 0;
		
		init = 0;
		next = 0;
		
		case(aes_ps)
			T0:
			begin
				aes_ns = T1;
			end
			T1://wait_aes_flag
			begin
				if (aes_flag)	aes_ns = T2;
				else 			aes_ns = T1;
			end
			T2://CHECK KEY
			begin
				if (same_key_flag)
				begin
					load_input_4 = 1;
					load_aes_in = 1;
					aes_ns = T3;
				end
				else aes_ns = T1;
			end
			T3://init aes
			begin
				case(addr)
					9:
					begin
						AES_ACTION = ENCRYPT;
						KEY_TYPE = KEY_TYPE_128;
					end
					10:
					begin
						AES_ACTION = DECRYPT;
						KEY_TYPE = KEY_TYPE_128;
					end
					11:
					begin
						AES_ACTION = ENCRYPT;
						KEY_TYPE = KEY_TYPE_256;
					end
					12:
					begin
						AES_ACTION = DECRYPT;
						KEY_TYPE = KEY_TYPE_256;
					end
					default:aes_ns = T1;	
				endcase
				init = 1;
				aes_ns = T4;
			end
			T4://delay
			begin
				aes_ns = T5;
			end
			T5://delay
			begin
				aes_ns = T6;
			end
			T6://wait for ready
			begin
				if(ready)	aes_ns = T7;
				else		aes_ns = T6;
			end
			T7://next aes
			begin
				case(addr)
					9:
					begin
						AES_ACTION = ENCRYPT;
						KEY_TYPE = KEY_TYPE_128;
					end
					10:
					begin
						AES_ACTION = DECRYPT;
						KEY_TYPE = KEY_TYPE_128;
					end
					11:
					begin
						AES_ACTION = ENCRYPT;
						KEY_TYPE = KEY_TYPE_256;
					end
					12:
					begin
						AES_ACTION = DECRYPT;
						KEY_TYPE = KEY_TYPE_256;
					end
					default:aes_ns = T1;	
				endcase
				next = 1;
				aes_ns = T8;
			end
			T8://delay
			begin
				aes_ns = T9;
			end
			T9://delay
			begin
				aes_ns = T10;
			end
			T10://wait aes FINISH
			begin
				if(result_valid)	aes_ns = T11;
				else				aes_ns = T10;
			end
			T11://write aes out in ram
			begin
				load_aes_out = 1;
				aes_ns = T1;
			end
			
		endcase 
	end

	//rx fsm
	always@(*)
	begin
		ns = T0;
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
		write_data_en = 0;
		read_data_en = 0;
		
		load_addr = 0;
		load_ram = 0;

		load_key_128 = 0;
		load_key_256 = 0;
		aes_flag = 0;
		
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
					load_addr = 1;
					load_ram = 1;
					ns = T10;
				end
				else 							ns = T1;
				
				if(packet_loss) ns = T1;
			end
			T10://WR
			begin
				//write
				if(data_out[15])  
				begin	
					if(addr < 60)
					begin
						write_data_en = 1;
						ns = T11;
					end
					else	ns = T1;				
				end
				//read
				else	
				begin
					read_data_en = 1;
					ns = T1;
				end
			end
			T11://ACTION CHECK
			begin
				if(addr >= 9 && addr <= 12)
				begin
					if(addr==9 || addr==10)	load_key_128 = 1;
					else					load_key_256 = 1;
					aes_flag = 1;
					ns = T1;
				end
				ns = T1;
			end
			

		endcase 
  end
  
  
    
endmodule
