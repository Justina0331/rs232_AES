module RX_code(data_out, data_in, load_port_b, tx_start, clk, rst, ram_out);

	input  data_in, clk, rst;
	output data_out, load_port_b, tx_start, ram_out;
	
	reg  s, d;			       //正負元檢查
	reg  start, restart, rst_counter, package_start, tx_start, finish;
	reg  load_port_b, load_package, load_finish, packet_loss, idle;
	reg  [63:0]data_out;
	wire  [31:0]ram_out;
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
	parameter T11 = 11;
  
	//檢查結束(package)
	always @(posedge clk)
	begin
		if(rst | idle)			finish <= 0;
		else if(load_finish)    finish <= 1;
	end
  
	//檢查開始(package)
	always @(posedge clk)
	begin
		if(rst | packet_loss | idle)	package_start <= 0;
		else if(load_package)  			package_start <= 1;
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
	
	//counter
	always @(posedge clk)
	begin
		if(rst | restart | rst_counter | idle)	counter <= 0;
		else if(counter==20)          	counter <= 0;
		else if(start)					counter <= counter+1;	
		
	end
	
	//watch dog
	always @(posedge clk)
	begin
		if(rst | idle) 
		begin
			packet_loss <= 0;
			watch_dog <= 0;
		end
		else if(watch_dog & watch_dog>150000)	packet_loss <= 1;
		else if(package_start) 			watch_dog <= watch_dog + 1; 
	end
	
	//紀錄接收bit
	always @(posedge clk)
	begin
		if(rst | restart | packet_loss | idle)	check_q <= 0;
		else if(counter==20) 					check_q <= check_q + 1;
	end
	
	//紀錄接收byte
	always @(posedge clk)
	begin
		if(rst | idle | package_q == 8 |  packet_loss)	package_q <= 0;
		if(package_start & restart)  package_q <= package_q + 1; 
	end
	
	//RAM
	assign addr = data_out[14:8];
	ram_128x32 RAM(data_out[47:16], addr, en, data_out[15], clk, ram_out);
	
	//TX_start
	always @(posedge clk)
	begin
	  tx_start <= 0;
	  if(finish & ~data_out[15]) tx_start <= 1;
	end

	//將接收的bit存入data
	always @(posedge clk)
	begin
	  if(package_q==0 && check_q==1) data_out <= 0;
	  if(rst)  data_out <= 0;
	  if(check_q)
		begin
			case(check_q)   
				3:	data_out[0 + package_q*8] <= data_in;
				5:	data_out[1 + package_q*8] <= data_in;
				7:	data_out[2 + package_q*8] <= data_in;
				9:	data_out[3 + package_q*8] <= data_in;
				11:	data_out[4 + package_q*8] <= data_in;
				13:	data_out[5 + package_q*8] <= data_in;
				15:	data_out[6 + package_q*8] <= data_in;
				17:	data_out[7 + package_q*8] <= data_in;
			endcase
		end		
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
		load_package = 0;
		idle = 0;
		restart = 0;
		en = 0;
		rst_counter = 0;
		case(ps)
			T0://等待第1組byte開始
			begin
				ns = T0;
				load_port_b = 1;
				idle = 1;
				if(start)  ns = T1;
				if(packet_loss)   ns = T0;
			end
			T1://reset counter
			begin
				ns = T2;
				load_package = 1;
				rst_counter = 1;
			end
			T2://正在傳送第1組byte
			begin
				ns = T2;
				if(check_q >= 18) ns = T3;
				if(packet_loss) ns = T0;
			end
			T3://檢查第1組byte是否為02
			begin
				ns = T3;
				if(~start) 
				begin
				//判斷使否為02
				////YES////
				if(data_out[7:0] == 8'h02)
				begin
					restart = 1;
					ns = T4;
				end
				////NO////
				else						ns = T0;
			end
			if(packet_loss) ns = T0;
			end
			T4://reset counter
			begin
				ns = T5;
				rst_counter = 1;
			end
			T5://等待2~8組bytes開始
			begin
				ns = T5;
				if(start)  ns = T6;
				if(packet_loss) ns = T0;
			end
			T6://reset counter
			begin
				ns = T7;
				rst_counter = 1;
			end
			T7://正在傳送byte
			begin
				ns = T7;
				if(check_q >= 18) ns = T8;
				if(packet_loss) ns = T0;
			end
			T8://檢查是否傳送完8組bytes
			begin
				ns = T8;
				if(~start) //判斷package_q是傳送完畢
				begin
					////YES////
					if(package_q >= 7 & data_out[63:56] == 8'h03)
					begin
						restart = 1;
						en = 1;
						ns = T9;
					end
					if(package_q >= 7)
					begin
						restart = 1;
						ns = T9;
					end
					////NO////
					else
					begin
						restart = 1;
						ns = T4;
					end
				end
				if(packet_loss) ns = T0;
			end
			T9:
			begin
				load_finish = 1;
				ns = T0;
			end
		endcase 
  end
    
endmodule

