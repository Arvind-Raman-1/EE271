transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/ramanarv/Desktop/EE271/lab2a {C:/Users/ramanarv/Desktop/EE271/lab2a/DE1_SoC.sv}
vlog -sv -work work +incdir+C:/Users/ramanarv/Desktop/EE271/lab2a {C:/Users/ramanarv/Desktop/EE271/lab2a/DiscountedStolenDetector.sv}

