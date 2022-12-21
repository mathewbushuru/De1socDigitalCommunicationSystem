// megafunction wizard: %ALTECC%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altecc_decoder 

// ============================================================
// File Name: hamming_decoder.v
// Megafunction Name(s):
// 			altecc_decoder
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 19.1.0 Build 670 09/22/2019 SJ Lite Edition
// ************************************************************


//Copyright (C) 2019  Intel Corporation. All rights reserved.
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


//altecc_decoder CBX_AUTO_BLACKBOX="ALL" device_family="Cyclone V" lpm_pipeline=0 width_codeword=18 width_dataword=12 data err_corrected err_detected err_fatal q
//VERSION_BEGIN 19.1 cbx_altecc_decoder 2019:09:22:11:00:28:SJ cbx_cycloneii 2019:09:22:11:00:28:SJ cbx_lpm_add_sub 2019:09:22:11:00:28:SJ cbx_lpm_compare 2019:09:22:11:00:28:SJ cbx_lpm_decode 2019:09:22:11:00:28:SJ cbx_mgl 2019:09:22:11:02:15:SJ cbx_nadder 2019:09:22:11:00:28:SJ cbx_stratix 2019:09:22:11:00:28:SJ cbx_stratixii 2019:09:22:11:00:28:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = lpm_decode 1 mux21 12 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  hamming_decoder_altecc_decoder_eqe
	( 
	data,
	err_corrected,
	err_detected,
	err_fatal,
	q) ;
	input   [17:0]  data;
	output   err_corrected;
	output   err_detected;
	output   err_fatal;
	output   [11:0]  q;

	wire  [31:0]   wire_error_bit_decoder_eq;
	wire	wire_mux21_0_dataout;
	wire	wire_mux21_1_dataout;
	wire	wire_mux21_10_dataout;
	wire	wire_mux21_11_dataout;
	wire	wire_mux21_2_dataout;
	wire	wire_mux21_3_dataout;
	wire	wire_mux21_4_dataout;
	wire	wire_mux21_5_dataout;
	wire	wire_mux21_6_dataout;
	wire	wire_mux21_7_dataout;
	wire	wire_mux21_8_dataout;
	wire	wire_mux21_9_dataout;
	wire  data_bit;
	wire  [11:0]  data_t;
	wire  [17:0]  data_wire;
	wire  [31:0]  decode_output;
	wire  err_corrected_wire;
	wire  err_detected_wire;
	wire  err_fatal_wire;
	wire  [8:0]  parity_01_wire;
	wire  [3:0]  parity_02_wire;
	wire  [1:0]  parity_03_wire;
	wire  [0:0]  parity_04_wire;
	wire  [0:0]  parity_05_wire;
	wire  parity_bit;
	wire  [16:0]  parity_final_wire;
	wire  [4:0]  parity_t;
	wire  [11:0]  q_wire;
	wire  syn_bit;
	wire  syn_e_int;
	wire  [3:0]  syn_t;
	wire  [5:0]  syndrome;

	lpm_decode   error_bit_decoder
	( 
	.data(syndrome[4:0]),
	.eq(wire_error_bit_decoder_eq)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0),
	.enable(1'b1)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		error_bit_decoder.lpm_decodes = 32,
		error_bit_decoder.lpm_width = 5,
		error_bit_decoder.lpm_type = "lpm_decode";
	assign		wire_mux21_0_dataout = (syndrome[5] === 1'b1) ? (decode_output[3] ^ data_wire[0]) : data_wire[0];
	assign		wire_mux21_1_dataout = (syndrome[5] === 1'b1) ? (decode_output[5] ^ data_wire[1]) : data_wire[1];
	assign		wire_mux21_10_dataout = (syndrome[5] === 1'b1) ? (decode_output[15] ^ data_wire[10]) : data_wire[10];
	assign		wire_mux21_11_dataout = (syndrome[5] === 1'b1) ? (decode_output[17] ^ data_wire[11]) : data_wire[11];
	assign		wire_mux21_2_dataout = (syndrome[5] === 1'b1) ? (decode_output[6] ^ data_wire[2]) : data_wire[2];
	assign		wire_mux21_3_dataout = (syndrome[5] === 1'b1) ? (decode_output[7] ^ data_wire[3]) : data_wire[3];
	assign		wire_mux21_4_dataout = (syndrome[5] === 1'b1) ? (decode_output[9] ^ data_wire[4]) : data_wire[4];
	assign		wire_mux21_5_dataout = (syndrome[5] === 1'b1) ? (decode_output[10] ^ data_wire[5]) : data_wire[5];
	assign		wire_mux21_6_dataout = (syndrome[5] === 1'b1) ? (decode_output[11] ^ data_wire[6]) : data_wire[6];
	assign		wire_mux21_7_dataout = (syndrome[5] === 1'b1) ? (decode_output[12] ^ data_wire[7]) : data_wire[7];
	assign		wire_mux21_8_dataout = (syndrome[5] === 1'b1) ? (decode_output[13] ^ data_wire[8]) : data_wire[8];
	assign		wire_mux21_9_dataout = (syndrome[5] === 1'b1) ? (decode_output[14] ^ data_wire[9]) : data_wire[9];
	assign
		data_bit = data_t[11],
		data_t = {(data_t[10] | decode_output[17]), (data_t[9] | decode_output[15]), (data_t[8] | decode_output[14]), (data_t[7] | decode_output[13]), (data_t[6] | decode_output[12]), (data_t[5] | decode_output[11]), (data_t[4] | decode_output[10]), (data_t[3] | decode_output[9]), (data_t[2] | decode_output[7]), (data_t[1] | decode_output[6]), (data_t[0] | decode_output[5]), decode_output[3]},
		data_wire = data,
		decode_output = wire_error_bit_decoder_eq,
		err_corrected = err_corrected_wire,
		err_corrected_wire = ((syn_bit & syn_e_int) & data_bit),
		err_detected = err_detected_wire,
		err_detected_wire = (syn_bit & (~ (syn_e_int & parity_bit))),
		err_fatal = err_fatal_wire,
		err_fatal_wire = (err_detected_wire & (~ err_corrected_wire)),
		parity_01_wire = {(data_wire[11] ^ parity_01_wire[7]), (data_wire[10] ^ parity_01_wire[6]), (data_wire[8] ^ parity_01_wire[5]), (data_wire[6] ^ parity_01_wire[4]), (data_wire[4] ^ parity_01_wire[3]), (data_wire[3] ^ parity_01_wire[2]), (data_wire[1] ^ parity_01_wire[1]), (data_wire[0] ^ parity_01_wire[0]), data_wire[12]},
		parity_02_wire = {((data_wire[9] ^ data_wire[10]) ^ parity_02_wire[2]), ((data_wire[5] ^ data_wire[6]) ^ parity_02_wire[1]), ((data_wire[2] ^ data_wire[3]) ^ parity_02_wire[0]), (data_wire[13] ^ data_wire[0])},
		parity_03_wire = {((((data_wire[7] ^ data_wire[8]) ^ data_wire[9]) ^ data_wire[10]) ^ parity_03_wire[0]), (((data_wire[14] ^ data_wire[1]) ^ data_wire[2]) ^ data_wire[3])},
		parity_04_wire = {(((((((data_wire[15] ^ data_wire[4]) ^ data_wire[5]) ^ data_wire[6]) ^ data_wire[7]) ^ data_wire[8]) ^ data_wire[9]) ^ data_wire[10])},
		parity_05_wire = {(data_wire[16] ^ data_wire[11])},
		parity_bit = parity_t[4],
		parity_final_wire = {(data_wire[16] ^ parity_final_wire[15]), (data_wire[15] ^ parity_final_wire[14]), (data_wire[14] ^ parity_final_wire[13]), (data_wire[13] ^ parity_final_wire[12]), (data_wire[12] ^ parity_final_wire[11]), (data_wire[11] ^ parity_final_wire[10]), (data_wire[10] ^ parity_final_wire[9]), (data_wire[9] ^ parity_final_wire[8]), (data_wire[8] ^ parity_final_wire[7]), (data_wire[7] ^ parity_final_wire[6]), (data_wire[6] ^ parity_final_wire[5]), (data_wire[5] ^ parity_final_wire[4]), (data_wire[4] ^ parity_final_wire[3]), (data_wire[3] ^ parity_final_wire[2]), (data_wire[2] ^ parity_final_wire[1]), (data_wire[1] ^ parity_final_wire[0]), (data_wire[17] ^ data_wire[0])},
		parity_t = {(parity_t[3] | decode_output[16]), (parity_t[2] | decode_output[8]), (parity_t[1] | decode_output[4]), (parity_t[0] | decode_output[2]), decode_output[1]},
		q = q_wire,
		q_wire = {wire_mux21_11_dataout, wire_mux21_10_dataout, wire_mux21_9_dataout, wire_mux21_8_dataout, wire_mux21_7_dataout, wire_mux21_6_dataout, wire_mux21_5_dataout, wire_mux21_4_dataout, wire_mux21_3_dataout, wire_mux21_2_dataout, wire_mux21_1_dataout, wire_mux21_0_dataout},
		syn_bit = syn_t[3],
		syn_e_int = syndrome[5],
		syn_t = {(syn_t[2] | syndrome[4]), (syn_t[1] | syndrome[3]), (syn_t[0] | syndrome[2]), (syndrome[0] | syndrome[1])},
		syndrome = {parity_final_wire[16], parity_05_wire[0], parity_04_wire[0], parity_03_wire[1], parity_02_wire[3], parity_01_wire[8]};
endmodule //hamming_decoder_altecc_decoder_eqe
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module hamming_decoder (
	data,
	err_corrected,
	err_detected,
	err_fatal,
	q);

	input	[17:0]  data;
	output	  err_corrected;
	output	  err_detected;
	output	  err_fatal;
	output	[11:0]  q;

	wire  sub_wire0;
	wire  sub_wire1;
	wire  sub_wire2;
	wire [11:0] sub_wire3;
	wire  err_corrected = sub_wire0;
	wire  err_detected = sub_wire1;
	wire  err_fatal = sub_wire2;
	wire [11:0] q = sub_wire3[11:0];

	hamming_decoder_altecc_decoder_eqe	hamming_decoder_altecc_decoder_eqe_component (
				.data (data),
				.err_corrected (sub_wire0),
				.err_detected (sub_wire1),
				.err_fatal (sub_wire2),
				.q (sub_wire3));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: lpm_pipeline NUMERIC "0"
// Retrieval info: CONSTANT: width_codeword NUMERIC "18"
// Retrieval info: CONSTANT: width_dataword NUMERIC "12"
// Retrieval info: USED_PORT: data 0 0 18 0 INPUT NODEFVAL "data[17..0]"
// Retrieval info: USED_PORT: err_corrected 0 0 0 0 OUTPUT NODEFVAL "err_corrected"
// Retrieval info: USED_PORT: err_detected 0 0 0 0 OUTPUT NODEFVAL "err_detected"
// Retrieval info: USED_PORT: err_fatal 0 0 0 0 OUTPUT NODEFVAL "err_fatal"
// Retrieval info: USED_PORT: q 0 0 12 0 OUTPUT NODEFVAL "q[11..0]"
// Retrieval info: CONNECT: @data 0 0 18 0 data 0 0 18 0
// Retrieval info: CONNECT: err_corrected 0 0 0 0 @err_corrected 0 0 0 0
// Retrieval info: CONNECT: err_detected 0 0 0 0 @err_detected 0 0 0 0
// Retrieval info: CONNECT: err_fatal 0 0 0 0 @err_fatal 0 0 0 0
// Retrieval info: CONNECT: q 0 0 12 0 @q 0 0 12 0
// Retrieval info: GEN_FILE: TYPE_NORMAL hamming_decoder.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL hamming_decoder.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL hamming_decoder.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL hamming_decoder.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL hamming_decoder_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL hamming_decoder_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
