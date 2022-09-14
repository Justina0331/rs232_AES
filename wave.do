onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {RS232}
add wave -noupdate /aes_data_tb/TX
add wave -noupdate /aes_data_tb/RX
add wave -noupdate /aes_data_tb/clk
add wave -noupdate /aes_data_tb/rst
add wave -noupdate /aes_data_tb/sw2
add wave -noupdate /aes_data_tb/sw1
add wave -noupdate /aes_data_tb/sw0
add wave -noupdate -radix hexadecimal /aes_data_tb/port_b_out

add wave -noupdate -divider {AES}
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/aes_data

add wave -noupdate -divider {RAM}
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/RAM/aes/e128_in
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/RAM/aes/encrypted128
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/RAM/aes/decrypted128
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {938046 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {989121 ps}
