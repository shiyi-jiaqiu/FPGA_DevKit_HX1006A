# Copyright (C) 2018  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: music_palyer.tcl
# Generated on: Tue Oct 29 17:33:07 2019

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "music_palyer"]} {
		puts "Project music_palyer is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists music_palyer]} {
		project_open -revision music_palyer music_palyer
	} else {
		project_new -revision music_palyer music_palyer
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone 10 LP"
	set_global_assignment -name DEVICE 10CL006YU256C8G
	set_global_assignment -name TOP_LEVEL_ENTITY music_player
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 18.1.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "15:57:24  OCTOBER 29, 2019"
	set_global_assignment -name LAST_QUARTUS_VERSION "18.1.0 Standard Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 256
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 8
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
	set_global_assignment -name NOMINAL_CORE_SUPPLY_VOLTAGE 1.2V
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name QIP_FILE pll.qip
	set_global_assignment -name VERILOG_FILE fdiv.v
	set_global_assignment -name VERILOG_FILE music_palyer.v
	set_global_assignment -name VERILOG_FILE cnt138t.v
	set_global_assignment -name QIP_FILE music.qip
	set_global_assignment -name VERILOG_FILE f_code.v
	set_global_assignment -name VERILOG_FILE speak.v
	set_global_assignment -name VERILOG_FILE DFF.v
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name EDA_GENERATE_FUNCTIONAL_NETLIST ON -section_id eda_simulation
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_location_assignment PIN_K10 -to speak
	set_location_assignment PIN_E15 -to clk
	set_location_assignment PIN_D15 -to high
	set_location_assignment PIN_T10 -to led[0]
	set_location_assignment PIN_R9 -to led[1]
	set_location_assignment PIN_T9 -to led[2]
	set_location_assignment PIN_K8 -to led[3]
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
