transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/rs232.v}
vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/TX_code.v}
vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/RX_code.v}
vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/aes_sbox.v}
vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/aes_key_mem.v}
vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/aes_inv_sbox.v}
vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/aes_encipher_block.v}
vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/aes_decipher_block.v}
vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/aes_core.v}
vlog -vlog01compat -work work +incdir+E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2 {E:/user/just/Documents/GitHub/rs232_AES/rs232_de0_2/mcu.v}

