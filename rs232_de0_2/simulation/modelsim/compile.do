vlib work

set DESIGN 				../../

#################################
### TOP
vlog ../../rs232.v

#################################
### INPUT&OUTPUT
vlog ../../RX_code.v
vlog ../../TX_code.v

#################################
## AES
vlog ../../aes_core.v
vlog ../../aes_decipher_block.v
vlog ../../aes_encipher_block.v
vlog ../../aes_inv_sbox.v
vlog ../../aes_key_mem.v
vlog ../../aes_sbox.v

#################################
## TEST BENTCH
##vlog ../../bits64_test.v
vlog ../../aes_data_tb.v