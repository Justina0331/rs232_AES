onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider RS232
add wave -noupdate -radix hexadecimal /aes_data_tb/port_b_out
add wave -noupdate /aes_data_tb/TX
add wave -noupdate /aes_data_tb/RX
add wave -noupdate /aes_data_tb/rst
add wave -noupdate /aes_data_tb/clk
add wave -noupdate -divider TX
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/counter
add wave -noupdate /aes_data_tb/f_rs232/tx/rst_counter
add wave -noupdate /aes_data_tb/f_rs232/tx/package_start
add wave -noupdate /aes_data_tb/f_rs232/tx/restart
add wave -noupdate /aes_data_tb/f_rs232/tx/tx_start
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/package_q
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/check_q
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/tx/data_in
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/tx/data_r
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/ps
add wave -noupdate -divider RX
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/counter
add wave -noupdate /aes_data_tb/f_rs232/rx/rst_counter
add wave -noupdate /aes_data_tb/f_rs232/rx/package_start
add wave -noupdate /aes_data_tb/f_rs232/rx/start
add wave -noupdate /aes_data_tb/f_rs232/rx/restart
add wave -noupdate /aes_data_tb/f_rs232/rx/tx_start
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/package_q
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/check_q
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/data_out
add wave -noupdate /aes_data_tb/f_rs232/rx/finish
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
WaveRestoreCursors {{Cursor 1} {14491 ps} 0}
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
WaveRestoreZoom {0 ps} {239568 ps}
