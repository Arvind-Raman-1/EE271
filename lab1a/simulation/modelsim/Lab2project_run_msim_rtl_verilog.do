transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+Z:/Desktop/lab1a {Z:/Desktop/lab1a/fullAdder.sv}
vlog -sv -work work +incdir+Z:/Desktop/lab1a {Z:/Desktop/lab1a/fullAdder4.sv}

