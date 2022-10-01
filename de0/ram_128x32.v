module ram_128x32(data_in, addr, en, action, clk, data_out);
  
	input [6:0] addr;
	input [31:0] data_in;
	input en, clk, action;
	output [31:0] data_out;
	reg   [31:0]data_out;
	
	reg  aes_en;
	wire  d128;
	wire [127:0] e128_out;
  reg [127:0] e128_in;
	
	//reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [31:0] ram[127:0];
	
	AES aes(aes_en, e128_in, e128_out, d128);
	
	always @ (posedge clk)
	begin
	  aes_en = 0;
	  if(en)
		  begin
		    //AES start
		    if(addr%6 == 0 && addr%12 != 0)  aes_en = 1;
		    //Write
		    if(action)  ram[addr] <= data_in;
		    //Read
		    else        data_out <= ram[addr];
		  end
		if(d128)
	    begin
	       ram[addr+1] <= {1'b1,e128_out[27:21],1'b1,e128_out[20:14],1'b1,e128_out[13:7],1'b1,e128_out[6:0]};
	       ram[addr+2] <= {1'b1,e128_out[55:49],1'b1,e128_out[48:42],1'b1,e128_out[41:35],1'b1,e128_out[34:28]};
	       ram[addr+3] <= {1'b1,e128_out[83:77],1'b1,e128_out[76:70],1'b1,e128_out[69:63],1'b1,e128_out[62:56]};
	       ram[addr+4] <= {1'b1,e128_out[111:105],1'b1,e128_out[104:98],1'b1,e128_out[97:91],1'b1,e128_out[90:84]};
	       ram[addr+5] <= {1'b1,7'b0,1'b1,5'b0,e128_out[127:126],1'b1,e128_out[125:119],1'b1,e128_out[118:112]};
		   ram[addr+6] <= 32'hffffffff;
	     end
	end
	
	always @ (posedge clk)
	begin
		if(aes_en)	e128_in <= {ram[addr-1][17:16],ram[addr-1][14:8],ram[addr-1][6:0],
		                       ram[addr-2][30:24],ram[addr-2][22:16],ram[addr-2][14:8],ram[addr-2][6:0],
		                       ram[addr-3][30:24],ram[addr-3][22:16],ram[addr-3][14:8],ram[addr-3][6:0],
		                       ram[addr-4][30:24],ram[addr-4][22:16],ram[addr-4][14:8],ram[addr-4][6:0],
		                       ram[addr-5][30:24],ram[addr-5][22:16],ram[addr-5][14:8],ram[addr-5][6:0]};
	end
	
	//1package輸出32bit
	/* always @ (posedge clk)
	begin
	  if(d128)
	    begin
	       ram[addr+1] <= e128_out[31:0];
	       ram[addr+2] <= e128_out[63:32];
	       ram[addr+3] <= e128_out[95:64];
	       ram[addr+4] <= e128_out[127:96];
	       ram[addr+5] <= 32'hffffffff;
	     end
	end */
  
endmodule

//0 0000010 讀出ram[2]
//0 0000011 讀出ram[3]
