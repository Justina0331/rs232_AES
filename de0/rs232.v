module rs232(TX, RX, sw2, sw1 ,sw0, clk, rst, port_b_out);

  input  clk, rst, RX, sw2, sw1 ,sw0;
	output TX, port_b_out;
	
	wire rst;
	wire TX;
	wire load_port_b;
	wire [63:0]data;
  reg  [7:0]port_b_out;
  wire  tx_start;
  
	RX_code rx(.data_out(data), .data_in(RX), .load_port_b(load_port_b), .tx_start(tx_start), .clk(clk), .rst(rst));
	
  TX_code tx(.data_out(TX), .data_in(data), .tx_start(tx_start), .rst(rst), .clk(clk));	
    
  //3to1Mux Port B out
  always@(posedge clk)
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
  end
    
endmodule

