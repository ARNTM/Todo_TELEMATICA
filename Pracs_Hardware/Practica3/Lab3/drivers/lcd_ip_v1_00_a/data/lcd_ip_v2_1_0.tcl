##############################################################################
## Filename:          C:\Xilinx\Practica3_Santos_Jose\CodigoFuente\Lab2_2018/drivers/lcd_ip_v1_00_a/data/lcd_ip_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Thu Dec 17 17:34:16 2020 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "lcd_ip" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
