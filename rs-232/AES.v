module AES(enable, e128_in, e128_out, d128);

	output wire d128;
	output wire[127:0] e128_out;

	input enable;
	input wire[127:0] e128_in;

	//加密key128
	wire[127:0] key128 = 128'h_000102030405060708090a0b0c0d0e0f;

	wire[127:0] encrypted128;
	wire[127:0] decrypted128;

	//加密
	AES_Encrypt a(e128_in,key128,encrypted128);
	
	assign e128_out = encrypted128;

	//解密
	AES_Decrypt a2(encrypted128,key128,decrypted128);

	//檢查加密後解密是否正確
	assign d128 = (decrypted128 == e128_in) && enable ? 1'b1 : 1'b0;
	
	//ram_128x32 RAM(data_out[47:16], addr, write_en, read_en, clk, ram_out);
	
	//fsm

endmodule
