transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/ramanarv/Desktop/EE271/lab1a {C:/Users/ramanarv/Desktop/EE271/lab1a/fullAdder.sv}
vlog -sv -work work +incdir+C:/Users/ramanarv/Desktop/EE271/lab1a {C:/Users/ramanarv/Desktop/EE271/lab1a/DE1_SoC.sv}

