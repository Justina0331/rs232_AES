vlib work

#################################
### TOP
vlog rs232.v

#################################
### INPUT&OUTPUT
vlog RX_code.v
vlog TX_code.v

#################################
## AES
vlog AES.v

vlog AES_Encrypt.v
vlog keyExpansion.v
vlog addRoundKey.v
vlog encryptRound.v
vlog subBytes.v
vlog shiftRows.v
vlog mixColumns.v

vlog AES_Decrypt.v
vlog decryptRound.v
vlog inverseShiftRows.v
vlog inverseSubBytes.v
vlog inverseMixColumns.v

#################################
## TEST BENTCH
vlog bits64_test.v
vlog aes_data_tb.v


#################################
## ram
vlog ram_128x32.v
