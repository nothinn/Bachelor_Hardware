vlib work

vcom -2008 "../src/addressTranslator.vhd"
vcom -2008 "tb_addressTranslator.vhd"

vsim tb_addressTranslator

add wave *
add wave -divider
add wave /addressTranslator_inst/*
add wave -divider

run -all
