vlib work
vsim -voptargs="+acc"  work.aes_data_tb

view structure wave signals


do wave.do

log -r *
run -all

#quit -sim

