vlib work

vcom -2008 "../src/types.vhd"
vcom -2008 "../src/mac.vhd"
vcom -2008 "tb_MAC.vhd"

vsim tb_MAC

add wave *
add wave -divider
add wave /MAC_inst/*
add wave -divider

run -all
