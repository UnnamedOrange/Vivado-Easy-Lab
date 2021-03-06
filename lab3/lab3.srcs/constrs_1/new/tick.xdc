set_property PACKAGE_PIN U2 [get_ports {led_sel_L[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_sel_L[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_sel_L[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_sel_L[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_sel_L[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_segs_L[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_segs_L[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_segs_L[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_segs_L[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_segs_L[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_segs_L[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_segs_L[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_segs_L[0]}]
set_property PACKAGE_PIN U4 [get_ports {led_sel_L[1]}]
set_property PACKAGE_PIN V4 [get_ports {led_sel_L[2]}]
set_property PACKAGE_PIN W4 [get_ports {led_sel_L[3]}]

set_property PACKAGE_PIN V7 [get_ports {led_segs_L[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports button]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports overflow]
set_property IOSTANDARD LVCMOS33 [get_ports RESET]
set_property PACKAGE_PIN U18 [get_ports button]
set_property PACKAGE_PIN U16 [get_ports overflow]
set_property PACKAGE_PIN W5 [get_ports CLK]

set_property PACKAGE_PIN T18 [get_ports RESET]

set_property PACKAGE_PIN V8 [get_ports {led_segs_L[3]}]
set_property PACKAGE_PIN U7 [get_ports {led_segs_L[6]}]
set_property PACKAGE_PIN W7 [get_ports {led_segs_L[0]}]
set_property PACKAGE_PIN W6 [get_ports {led_segs_L[1]}]
set_property PACKAGE_PIN U8 [get_ports {led_segs_L[2]}]
set_property PACKAGE_PIN U5 [get_ports {led_segs_L[4]}]
set_property PACKAGE_PIN V5 [get_ports {led_segs_L[5]}]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
