module rs232(TX, RX, sw2, sw1 ,sw0, clk, rst, port_b_out);

	input  clk, rst, RX, sw2, sw1 ,sw0;
	output TX, port_b_out;
	
	wire rst;
	wire TX;
	wire load_port_b;
	wire [63:0]data;
	wire [31:0]ram_out;
	reg  [7:0]port_b_out;
	wire  tx_start;
  
	RX_code rx(.data_out(data), .data_in(RX), .load_port_b(load_port_b), .tx_start(tx_start), .clk(clk), .rst(rst), .ram_out(ram_out));
	
	TX_code tx(.data_out(TX), .data_in(ram_out), .tx_start(tx_start), .rst(rst), .clk(clk));	
    
	//3to1Mux Port B out
	/*always@(posedge clk)
	begin
		if(rst) port_b_out <= 0;
		else
		begin
			case({sw2, sw1 ,sw0})
				3'b000:  port_b_out <= load_port_b ? data[7:0] : port_b_out;
				3'b001:  port_b_out <= load_port_b ? data[15:8] : port_b_out;
				3'b010:  port_b_out <= load_port_b ? data[23:16] : port_b_out;
				3'b011:  port_b_out <= load_port_b ? data[31:24] : port_b_out;
				3'b100:  port_b_out <= load_port_b ? data[39:32] : port_b_out;
				3'b101:  port_b_out <= load_port_b ? data[47:40] : port_b_out;
				3'b110:  port_b_out <= load_port_b ? data[55:48] : port_b_out;
				3'b111:  port_b_out <= load_port_b ? data[63:56] : port_b_out;
			endcase
		end
	end*/
	
	always@(posedge clk)
	begin
		if(rst) port_b_out <= 0;
		else
		begin
		  case({sw2, sw1 ,sw0})
				3'b000:  port_b_out <= load_port_b ? ram_out[7:0] : port_b_out;
				3'b001:  port_b_out <= load_port_b ? ram_out[15:8] : port_b_out;
				3'b010:  port_b_out <= load_port_b ? ram_out[23:16] : port_b_out;
				3'b011:  port_b_out <= load_port_b ? ram_out[31:24] : port_b_out;
				default: port_b_out <= 0;
			endcase
		end
	end
	
    
endmodule



//////////////////////////////////////
//* 02,FF,04,08,16,32,00,03
//* 02,7F,00,00,00,00,00,03
//* 02,FE,0A,0B,0C,0D,00,03
//* 02,7E,00,00,00,00,00,03
//*
///////////////////////////////////////