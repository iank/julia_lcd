// megafunction wizard: %LPM_MUX%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_MUX 

// ============================================================
// File Name: sdram_mux.v
// Megafunction Name(s):
// 			LPM_MUX
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 20.1.1 Build 720 11/11/2020 SJ Lite Edition
// ************************************************************


//Copyright (C) 2020  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and any partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details, at
//https://fpgasoftware.intel.com/eula.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module sdram_mux (
	data0x,
	data1x,
	data2x,
	sel,
	result);

	input	[55:0]  data0x;
	input	[55:0]  data1x;
	input	[55:0]  data2x;
	input	[1:0]  sel;
	output	[55:0]  result;

	wire [55:0] sub_wire0;
	wire [55:0] sub_wire4 = data2x[55:0];
	wire [55:0] sub_wire3 = data1x[55:0];
	wire [55:0] result = sub_wire0[55:0];
	wire [55:0] sub_wire1 = data0x[55:0];
	wire [167:0] sub_wire2 = {sub_wire4, sub_wire3, sub_wire1};

	lpm_mux	LPM_MUX_component (
				.data (sub_wire2),
				.sel (sel),
				.result (sub_wire0)
				// synopsys translate_off
				,
				.aclr (),
				.clken (),
				.clock ()
				// synopsys translate_on
				);
	defparam
		LPM_MUX_component.lpm_size = 3,
		LPM_MUX_component.lpm_type = "LPM_MUX",
		LPM_MUX_component.lpm_width = 56,
		LPM_MUX_component.lpm_widths = 2;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_SIZE NUMERIC "3"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MUX"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "56"
// Retrieval info: CONSTANT: LPM_WIDTHS NUMERIC "2"
// Retrieval info: USED_PORT: data0x 0 0 56 0 INPUT NODEFVAL "data0x[55..0]"
// Retrieval info: USED_PORT: data1x 0 0 56 0 INPUT NODEFVAL "data1x[55..0]"
// Retrieval info: USED_PORT: data2x 0 0 56 0 INPUT NODEFVAL "data2x[55..0]"
// Retrieval info: USED_PORT: result 0 0 56 0 OUTPUT NODEFVAL "result[55..0]"
// Retrieval info: USED_PORT: sel 0 0 2 0 INPUT NODEFVAL "sel[1..0]"
// Retrieval info: CONNECT: @data 0 0 56 0 data0x 0 0 56 0
// Retrieval info: CONNECT: @data 0 0 56 56 data1x 0 0 56 0
// Retrieval info: CONNECT: @data 0 0 56 112 data2x 0 0 56 0
// Retrieval info: CONNECT: @sel 0 0 2 0 sel 0 0 2 0
// Retrieval info: CONNECT: result 0 0 56 0 @result 0 0 56 0
// Retrieval info: GEN_FILE: TYPE_NORMAL sdram_mux.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL sdram_mux.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sdram_mux.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sdram_mux.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sdram_mux_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sdram_mux_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
