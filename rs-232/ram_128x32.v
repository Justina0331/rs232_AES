module ram_128x32(data_in, addr, write_en, read_en, clk, data_out);
  
	input [6:0] addr;
	input [31:0] data_in;
	input clk, write_en, read_en;
	output [31:0] data_out;
	reg   [31:0]data_out;
	
	//reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [31:0] ram[127:0];
	
	always @ (posedge clk)
	begin
		if(write_en)	
		begin
			ram[addr] <= data_in;
		end
		
	end
	
	always@(posedge clk)
	begin
		if(read_en)	data_out <= ram[addr];
	end
  
endmodule

//0 0000010 讀出ram[2]
//0 0000011 讀出ram[3]
