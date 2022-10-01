module ram_128x32(data_in, addr, en, action, clk, rst, data_out);
  
	input [6:0] addr;
	input [31:0] data_in;
	input en, clk, rst, action;
	output [31:0] data_out;
	reg   [31:0]data_out;
	
	parameter T0 = 0;
	parameter T1 = 1;
	parameter T2 = 2;
	parameter T3 = 3;
	parameter T4 = 4;
	parameter T5 = 5;
	
	//reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [31:0] ram[127:0];
	
	//e128_in
	reg aes_en;
	reg [127:0] e128_in;
	wire [127:0] e128_out;
	always @ (posedge clk)
	begin
		if(aes_en)	e128_in <= {ram[addr-1][17:16],ram[addr-1][14:8],ram[addr-1][6:0],
		                       ram[addr-2][30:24],ram[addr-2][22:16],ram[addr-2][14:8],ram[addr-2][6:0],
		                       ram[addr-3][30:24],ram[addr-3][22:16],ram[addr-3][14:8],ram[addr-3][6:0],
		                       ram[addr-4][30:24],ram[addr-4][22:16],ram[addr-4][14:8],ram[addr-4][6:0],
		                       ram[addr-5][30:24],ram[addr-5][22:16],ram[addr-5][14:8],ram[addr-5][6:0]};
	end
	
	//read write ram
	reg load_ram;
	reg load_aes;
	always @ (posedge clk)
	begin
		if(load_ram)
			begin
				//Write
				if(action)  ram[addr] <= data_in;
				//Read
				else        data_out <= ram[addr];
			end
		/*if(load_aes)
		begin
			ram[addr+1] <= {1'b1,e128_out[27:21],1'b1,e128_out[20:14],1'b1,e128_out[13:7],1'b1,e128_out[6:0]};
			ram[addr+2] <= {1'b1,e128_out[55:49],1'b1,e128_out[48:42],1'b1,e128_out[41:35],1'b1,e128_out[34:28]};
			ram[addr+3] <= {1'b1,e128_out[83:77],1'b1,e128_out[76:70],1'b1,e128_out[69:63],1'b1,e128_out[62:56]};
			ram[addr+4] <= {1'b1,e128_out[111:105],1'b1,e128_out[104:98],1'b1,e128_out[97:91],1'b1,e128_out[90:84]};
			ram[addr+5] <= {1'b1,7'b0,1'b1,5'b0,e128_out[127:126],1'b1,e128_out[125:119],1'b1,e128_out[118:112]};
			ram[addr+6] <= 32'hffffffff;
	    end*/
	end
	
	
	//AES
	wire d128;
	AES aes(aes_en, e128_in, e128_out, d128);
	
	//States
	reg [4:0]ps, ns;
	always@(posedge clk)
	begin
		if(rst) ps <= T0;
		else    ps <= ns;
	end
	
	always@(*)
	begin
		ns = T0;
		
		load_ram = 0;
		load_aes = 0;
		aes_en = 0;
		
		case(ps)
			T0:
			begin
				ns = T1;
			end
			T1://wait en
			begin
				if(en)	ns = T2;
				else		ns = T1;
			end
			T2://action
			begin
				load_ram = 1;
				ns = T3;
			end
			T3://end or AES?
			begin
				if(addr%6 == 0 && addr%12 != 0) 	ns = T4;
				else 					  					ns = T1;
			end
			T4://AES start
			begin
				aes_en = 1;
				ns = T5;
			end
			T5://wait for AES end
			begin
				if(d128)
				begin
					load_aes = 1;
					ns = T1;
				end
				else ns = T5;
			end
		endcase 
  end
  
endmodule

//0 0000010 讀出ram[2]
//0 0000011 讀出ram[3]