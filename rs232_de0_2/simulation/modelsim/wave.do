onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider RS232
add wave -noupdate /aes_data_tb/TX
add wave -noupdate /aes_data_tb/RX
add wave -noupdate /aes_data_tb/rst
add wave -noupdate -divider TX
add wave -noupdate /aes_data_tb/f_rs232/tx/tx_start
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/cnt_1
add wave -noupdate /aes_data_tb/f_rs232/tx/delta_time_1_flag
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/tx/cnt_tx_bits
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/cnt_tx_bytes
add wave -noupdate /aes_data_tb/f_rs232/tx/start_data
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/tx/data_in
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/tx/data_r
add wave -noupdate /aes_data_tb/f_rs232/tx/data
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/tx/ps
add wave -noupdate -divider RX
add wave -noupdate /aes_data_tb/f_rs232/rx/start
add wave -noupdate /aes_data_tb/f_rs232/rx/tx_start
add wave -noupdate /aes_data_tb/f_rs232/rx/delta_time_1_5_flag
add wave -noupdate /aes_data_tb/f_rs232/rx/delta_time_1_flag
add wave -noupdate -radix decimal /aes_data_tb/f_rs232/rx/cnt_rx_bits
add wave -noupdate -radix decimal /aes_data_tb/f_rs232/rx/cnt_rx_bytes
add wave -noupdate /aes_data_tb/f_rs232/rx/watch_dog
add wave -noupdate /aes_data_tb/f_rs232/rx/packet_loss
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/ps
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/aes_flag
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/ram_data_in
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/addr
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/write_data_en
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/read_data_en
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/aes_in
add wave -noupdate -radix hexadecimal -childformat {{{/aes_data_tb/f_rs232/rx/aes_out[127]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[126]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[125]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[124]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[123]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[122]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[121]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[120]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[119]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[118]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[117]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[116]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[115]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[114]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[113]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[112]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[111]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[110]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[109]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[108]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[107]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[106]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[105]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[104]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[103]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[102]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[101]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[100]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[99]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[98]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[97]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[96]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[95]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[94]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[93]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[92]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[91]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[90]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[89]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[88]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[87]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[86]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[85]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[84]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[83]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[82]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[81]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[80]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[79]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[78]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[77]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[76]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[75]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[74]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[73]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[72]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[71]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[70]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[69]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[68]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[67]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[66]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[65]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[64]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[63]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[62]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[61]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[60]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[59]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[58]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[57]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[56]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[55]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[54]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[53]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[52]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[51]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[50]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[49]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[48]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[47]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[46]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[45]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[44]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[43]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[42]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[41]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[40]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[39]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[38]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[37]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[36]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[35]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[34]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[33]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[32]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[31]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[30]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[29]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[28]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[27]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[26]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[25]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[24]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[23]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[22]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[21]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[20]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[19]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[18]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[17]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[16]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[15]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[14]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[13]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[12]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[11]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[10]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[9]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[8]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[7]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[6]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[5]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[4]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[3]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[2]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[1]} -radix hexadecimal} {{/aes_data_tb/f_rs232/rx/aes_out[0]} -radix hexadecimal}} -subitemconfig {{/aes_data_tb/f_rs232/rx/aes_out[127]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[126]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[125]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[124]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[123]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[122]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[121]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[120]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[119]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[118]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[117]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[116]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[115]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[114]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[113]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[112]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[111]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[110]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[109]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[108]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[107]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[106]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[105]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[104]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[103]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[102]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[101]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[100]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[99]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[98]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[97]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[96]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[95]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[94]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[93]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[92]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[91]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[90]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[89]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[88]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[87]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[86]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[85]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[84]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[83]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[82]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[81]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[80]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[79]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[78]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[77]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[76]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[75]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[74]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[73]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[72]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[71]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[70]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[69]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[68]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[67]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[66]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[65]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[64]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[63]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[62]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[61]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[60]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[59]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[58]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[57]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[56]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[55]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[54]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[53]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[52]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[51]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[50]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[49]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[48]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[47]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[46]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[45]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[44]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[43]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[42]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[41]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[40]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[39]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[38]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[37]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[36]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[35]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[34]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[33]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[32]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[31]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[30]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[29]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[28]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[27]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[26]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[25]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[24]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[23]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[22]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[21]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[20]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[19]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[18]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[17]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[16]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[15]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[14]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[13]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[12]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[11]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[10]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[9]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[8]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[7]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[6]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[5]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[4]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[3]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[2]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[1]} {-height 15 -radix hexadecimal} {/aes_data_tb/f_rs232/rx/aes_out[0]} {-height 15 -radix hexadecimal}} /aes_data_tb/f_rs232/rx/aes_out
add wave -noupdate -divider AES
add wave -noupdate /aes_data_tb/f_rs232/rx/aes/init
add wave -noupdate /aes_data_tb/f_rs232/rx/aes/next
add wave -noupdate /aes_data_tb/f_rs232/rx/aes/encdec
add wave -noupdate /aes_data_tb/f_rs232/rx/aes/keylen
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/aes/key
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/aes/block
add wave -noupdate -radix hexadecimal /aes_data_tb/f_rs232/rx/aes/result
add wave -noupdate -divider RAM
add wave -noupdate -radix unsigned /aes_data_tb/f_rs232/rx/addr
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[4]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[5]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[6]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[7]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[8]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[13]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[14]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[15]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[16]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[64]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[65]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[66]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[67]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[68]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[73]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[74]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[75]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[76]}
add wave -noupdate -radix hexadecimal {/aes_data_tb/f_rs232/rx/ram[60]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {655837 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 57
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
WaveRestoreZoom {478434 ps} {1619624 ps}
