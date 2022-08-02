module single_port_ram_128x8(data_in, addr, en, action, clk, data_out);
  
	input [6:0] addr;
	input [31:0] data_in;
	input en, clk, action;
	output [31:0] data_out;
	reg   [31:0]data_out;
	
	//reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [31:0] ram[127:0];
	
	always @ (posedge clk)
	begin
		if(en)
		  begin
		    //Write
		    if(action)  ram[addr] <= data_in;
		    //Read
		    else        data_out <= ram[addr];
		  end
	end

endmodule

