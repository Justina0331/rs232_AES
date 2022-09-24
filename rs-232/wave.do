onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider RS232
add wave -noupdate -radix hexadecimal /aes_data_tb/port_b_out
add wave -noupdate /aes_data_tb/TX
add wave -noupdate /aes_data_tb/RX
add wave -noupdate /aes_data_tb/rst
add wave -noupdate /aes_data_tb/clk
add wave -noupdate -divider TX
add wave -noupdate /aes_data_tb/f_rs232/tx/tx_start
add wave -noupdate /aes_data_tb/f_rs232/tx/rst_cnt_1
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/cnt_1
add wave -noupdate /aes_data_tb/f_rs232/tx/delta_time_1_flag
add wave -noupdate /aes_data_tb/f_rs232/tx/rst_cnt_tx_bits
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/cnt_tx_bits
add wave -noupdate /aes_data_tb/f_rs232/tx/inc_cnt_tx_bits
add wave -noupdate /aes_data_tb/f_rs232/tx/rst_cnt_tx_bytes
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/cnt_tx_bytes
add wave -noupdate /aes_data_tb/f_rs232/tx/inc_cnt_tx_bytes
add wave -noupdate /aes_data_tb/f_rs232/tx/shift_reg
add wave -noupdate /aes_data_tb/f_rs232/tx/start_data
add wave -noupdate /aes_data_tb/f_rs232/tx/rst_data
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/tx/data_in
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/tx/data_r
add wave -noupdate /aes_data_tb/f_rs232/tx/data
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/ps
add wave -noupdate -divider RX
add wave -noupdate /aes_data_tb/f_rs232/rx/start
add wave -noupdate /aes_data_tb/f_rs232/rx/rst_start
add wave -noupdate /aes_data_tb/f_rs232/rx/en
add wave -noupdate /aes_data_tb/f_rs232/rx/tx_start
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/data_out
add wave -noupdate /aes_data_tb/f_rs232/rx/rst_cnt_1_5
add wave -noupdate -radix decimal /aes_data_tb/f_rs232/rx/cnt_1_5
add wave -noupdate /aes_data_tb/f_rs232/rx/delta_time_1_5_flag
add wave -noupdate /aes_data_tb/f_rs232/rx/rst_cnt_1
add wave -noupdate -radix decimal /aes_data_tb/f_rs232/rx/cnt_1
add wave -noupdate /aes_data_tb/f_rs232/rx/delta_time_1_flag
add wave -noupdate /aes_data_tb/f_rs232/rx/rst_cnt_rx_bits
add wave -noupdate -radix decimal /aes_data_tb/f_rs232/rx/cnt_rx_bits
add wave -noupdate /aes_data_tb/f_rs232/rx/inc_cnt_rx_bits
add wave -noupdate /aes_data_tb/f_rs232/rx/rst_cnt_rx_bytes
add wave -noupdate -radix decimal /aes_data_tb/f_rs232/rx/cnt_rx_bytes
add wave -noupdate /aes_data_tb/f_rs232/rx/inc_cnt_rx_bytes
add wave -noupdate /aes_data_tb/f_rs232/rx/shift_reg
add wave -noupdate /aes_data_tb/f_rs232/rx/watch_dog
add wave -noupdate /aes_data_tb/f_rs232/rx/packet_loss
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/ps
add wave -noupdate -divider AES
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/RAM/aes/e128_in
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/RAM/aes/e128_out
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/RAM/aes/encrypted128
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/RAM/aes/decrypted128
add wave -noupdate -divider RAM
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/RAM/ram[106]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1049345 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 133
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {994401 ps} {1114209 ps}
