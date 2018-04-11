vlib work

vcom -2008 "../src/types.vhd"
vcom -2008 "../src/addressTranslator.vhd"
vcom -2008 "../src/resultRam.vhd"
vcom -2008 "tb_resultRam.vhd"

vsim tb_resultRam

add wave *
add wave -divider
add wave /resultRam_inst/*
add wave -divider

run -all
