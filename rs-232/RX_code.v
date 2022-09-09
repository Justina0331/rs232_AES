module RX_code(data_out, data_in, load_port_b, tx_start, clk, rst, ram_out);

	input  data_in, clk, rst;
	output data_out, load_port_b, tx_start, ram_out;
	
	wire rst;
	reg  CHECK_TIME;
	reg  s, d;			       //正負元檢查
	reg  start, restart, package_start, tx_start, finish, watch_dog;
	reg  load_port_b, packet_loss;
	reg  [63:0]data_out;
	wire  [31:0]ram_out;
	reg  [5:0]check_q, package_q;
	reg  [12:0]div;
  reg  [2:0]ps, ns,aes_q;
  reg  [20:0]t;
  reg  en;          //控制讀出/寫入
  wire [6:0]addr;   //讀出/寫入位置
  wire d128;   //判斷aes_in加密再解密後是否一樣
  wire [127:0]aes_in,aes_out;
  reg [31:0] aes_data[15:0]; //1-4:data_in/5:encrypt_start/6-9:data_out/10:encrypt_finish
  
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
	 finish <= 0;
	 if(package_q == 8 & ~packet_loss)    finish <= 1;
	end
  
  //檢查開始及結束(package)
	always @(posedge clk)
	begin
	 if(rst | packet_loss) package_start <= 0;
	 else
			begin
				if(ps == T1)  package_start <= 1;
				if(ps == T0)  package_start <= 0;
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
		else if(div == 10)	//1256
		  begin
				CHECK_TIME <= ~CHECK_TIME;
				div <= 0;
			end
		else if(start)  div <= div+1;	
	end
	
	//watch dog
	always @(posedge clk)
	begin
	  packet_loss <= 0;
		if(ps == T2) watch_dog <= 1; 
		else if(ps == T0 || rst)
		  begin
		    t <= 0;
		    watch_dog <= 0;
		  end
		else if(watch_dog & t>5000)
		  begin
		    t <= 0;
		    watch_dog <= 0;
		    packet_loss <= 1;
		  end
    else if(watch_dog)  t <= t+1;
      
	end
	
	//紀錄接收bit
	always @(posedge CHECK_TIME, posedge rst, posedge restart, posedge packet_loss)
	begin
		if(rst | restart | packet_loss)
      check_q <= 0;
		else
		  if(start) check_q <= check_q + 1;
	end
	
	//紀錄接收byte
	always @(posedge clk)
	begin
	  if(rst | ps == T0 | package_q == 9 |  packet_loss)
       package_q <= 0;
		if(package_start & restart)  package_q <= package_q + 1; 
		if(package_q == 8)           package_q <= package_q + 1; 
	end
	
	//RAM
	assign addr = data_out[14:8];
	ram_128x32 RAM(data_out[47:16], addr, en, data_out[15], clk, ram_out);
	
	//TX_start
	always @(posedge clk)
	begin
	  tx_start <= 0;
	  if(finish & ~data_out[15] & data_out[63:56] == 8'h03) tx_start <= 1;
	end
	/*
	//紀錄加密資料(寫入1-9)
	assign aes_start = (aes_data[5] == 32'hffffffff)?1:0;
	always @(posedge clk)
	begin
	  if(rst) aes_q <= 1;
	  if(aes_q == 5) 
	  begin
	  aes_q <=1;
	  end
	  else
	    if(en) 
	    begin
	    if(aes_q == 4) aes_data[5] <= 32'hffffffff;
	    if(aes_q == 1) aes_data[5] <= 32'h00000000;
	    aes_data[aes_q] <= data_out[15] ? data_out[47:16] : ram_out;
	    aes_q <= aes_q + 1;
	 end
  end	

	//紀錄加密資料(寫出10)
	always @(posedge clk && aes_out, posedge aes_q)
	begin
	  if(rst || aes_q==2) aes_data[10] <= 32'h00000000;
	  else
	     if(aes_start)aes_data[10] <= 32'hffffffff; 
	end
	
	//加密
	assign aes_in = {aes_data[1],aes_data[2],aes_data[3],aes_data[4]};
	always @(posedge clk) 
	begin
	 {aes_data[6],aes_data[7],aes_data[8],aes_data[9]} <= aes_out;
	end
	AES aes(aes_start, aes_in, aes_out,d128);
	*/
	
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
    en = 0;
    case(ps)
      T0://等待第1組byte開始
      begin
        ns = T0;
		    load_port_b = 1;
        if(check_q >= 2)  ns = T1;
        if(packet_loss)   ns = T0;
      end
      T1://正在傳送第1組byte
      begin
        ns = T1;
        if(check_q >= 18) ns = T2;
        if(packet_loss) ns = T0;
      end
      T2://檢查第1組byte是否為02
      begin
        ns = T2;
        if(~start) 
        begin
          //判斷使否為02
          ////YES////
          if(data_out[7:0] == 8'h02)
            begin
              restart = 1;
              ns = T3;
            end
          ////NO////
          else
            begin
              restart = 1;
              ns = T0;
            end
        end
        if(packet_loss) ns = T0;
      end
      T3://等待2~8組bytes開始
      begin
        ns = T3;
        if(check_q >= 2)  ns = T4;
        if(packet_loss) ns = T0;
      end
      T4://正在傳送byte
      begin
        ns = T4;
        if(check_q >= 18) ns = T5;
        if(packet_loss) ns = T0;
      end
      T5://檢查是否傳送完8組bytes
      begin
        ns = T5;
        if(~start) 
        begin
          //判斷package_q是傳送完畢
          ////YES////
          if(package_q >= 7 & data_out[63:56] == 8'h03)
            begin
              restart = 1;
              en = 1;
              ns = T0;
            end
          if(package_q >= 7)
            begin
              restart = 1;
              ns = T0;
            end
          ////NO////
          else
            begin
              restart = 1;
              ns = T3;
            end
        end
        if(packet_loss) ns = T0;
      end
    endcase 
  end
    
endmodule

