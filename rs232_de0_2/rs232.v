module rs232(TX, RX, clk, rst);

	input  clk, rst, RX;
	output TX;
	
	wire rst;
	wire TX;
	wire load_port_b;
	wire [31:0]ram_out;
	wire  tx_start;
  
	RX_code rx(.data_in(RX), .tx_start(tx_start), .clk(clk), .rst(rst), .ram_data_out(ram_out));
	
	TX_code tx(.data_out(TX), .data_in(ram_out), .tx_start(tx_start), .rst(rst), .clk(clk));	
	
    
endmodule