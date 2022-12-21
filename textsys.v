module sys (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT,HEX0,HEX2,HEX4);

	input CLOCK_50, CLOCK2_50;
	input [0:0] KEY;
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;

	output [6:0] HEX0,HEX2,HEX4;
	
	// Local wires.
	wire read_ready, write_ready, read, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	wire reset = ~KEY[0];

	//text wires
	wire	[7:0]  read_address,write_address;
	wire	[23:0]  text_ram_in;
	wire	  write_enable,read_enable;
	wire	[23:0]  text_ram_out;
	wire	[23:0]  system_text_output;

	//CODEC rdy/en signals for reading and writing 
	assign read = read_ready ? 1'b1 : 1'b0;
	assign write = write_ready ? 1'b1 : 1'b0; 

	//TEXT FSM
	textfsm control_text_oper (
		.clk(CLOCK_50), 
		.reset(reset), 
		.read_enable(read_enable), 
		.write_enable(write_enable), 
		.text_ram_in(text_ram_in)
		);

	//RAM instantiation
	/*s_memory text_ram (
						.address (read_address),
						.clock(CLOCK_50),
						.data(text_ram_in),
						.wren(write_to_ram),
						.q(text_ram_out)
						);*/
	/*read_write_ram text_ram ( 
					.q(text_ram_out),
					.d(text_ram_in),
					.write_address(write_address), 
					.read_address(read_address),
					.we(write_enable),
					.re (read_enable),
					.clk(CLOCK_50)
				);*/
			
	s_mem2	text_ram (
						.address ( write_address ),
						.clock ( CLOCK_50 ),
						.data ( text_ram_in ),
						.rden ( read_enable ),
						.wren ( write_enable ),
						.q ( text_ram_out )
						);

	/*SevenSegmentDisplayDecoder display5 (
						.ssOut(HEX5), 
						.nIn(text_ram_in[7:4])
						);*/
	SevenSegmentDisplayDecoder display4 (
						.ssOut(HEX4), 
						.nIn(text_ram_in[3:0])
						);

	/*SevenSegmentDisplayDecoder display3 (
						.ssOut(HEX3), 
						.nIn(text_ram_out[7:4])
						);*/
	SevenSegmentDisplayDecoder display2 (
						.ssOut(HEX2), 
						.nIn(text_ram_out[3:0])
						);
	
	/*SevenSegmentDisplayDecoder display1 (
						.ssOut(HEX1), 
						.nIn(system_text_output[7:4])
						);*/
	SevenSegmentDisplayDecoder display0 (
						.ssOut(HEX0), 
						.nIn(system_text_output[3:0])
						);

	//Sub-Module Instantiations for left and right audio
	sub_sys left_audio(
						.data_in(readdata_left), 
						.data_out(writedata_left), 
						.clk(CLOCK_50), 
						.reset(reset),
						.read_ready(read_ready)
						);
	
	sub_sys right_audio(
						.data_in(readdata_right), 
						.data_out(writedata_right), 
						.clk(CLOCK_50), 
						.reset(reset),
						.read_ready(read_ready)
						);

	sub_sys_text text(
						.data_in(text_ram_out), 
						.data_out(system_text_output), 
						.clk(CLOCK_50), 
						.reset(reset),
						.read_ready(read_ready)
						);

	
/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

endmodule

/*
Purpose: Reuseable system module for audio left, audio right, and text
*/
module sub_sys(data_in, data_out, clk, reset, read_ready);

	//I/O
	input [23:0] data_in;
	input clk, reset, read_ready;
	output [23:0] data_out;

	///////////////////////////////////////////////
	//				INTEGRATION WIRES
	///////////////////////////////////////////////

	wire [23:0] compression_input = data_in;
wire [11:0] compression_output; 

wire [11:0] ecc_enc_input = compression_output;
wire [17:0] ecc_enc_output; 

wire [17:0] encryption_input = ecc_enc_output;
wire [17:0] encryption_output;

wire [17:0] bpsk_mod_input = ecc_enc_output;
wire [17:0] bpsk_mod_output;

wire [17:0] transmitter_input = bpsk_mod_output;
wire [20:0] transmitter_output;

wire [20:0] channel_input = transmitter_output;
wire [20:0] channel_output;

wire [20:0] receiver_input = channel_output;
wire [17:0] receiver_output;

wire [17:0] bpsk_demod_input = receiver_output;
wire [17:0] bpsk_demod_output;

wire [17:0] decryption_input = bpsk_demod_output;
wire [17:0] decryption_output;

wire [17:0] ecc_dec_input = bpsk_demod_output;
wire [11:0] ecc_dec_output;

wire [11:0] decompression_input = ecc_dec_output;
wire [23:0] decompression_output;

assign data_out = decompression_output;

//WIRES FOR TX/RX, CHANNEL
wire [4:0] ATTEN_START, ATTEN_CONST, attenuated;

//WIRES FOR COMPRESSION MODULE
wire [5:0] c1, c2, c3, c4;
wire [1:0] e1, e2, e3, e4;

//WIRES FOR ECC
wire err_corrected, err_detected, err_fatal;

	///////////////////////////////////////////////
	//		MODULE INSTANTIATIONS
	///////////////////////////////////////////////

	data_compression compression(
								.data_in(compression_input), 
								.c1(c1), 
								.c2(c2), 
								.c3(c3), 
								.c4(c4), 
								.e1(e1), 
								.e2(e2), 
								.e3(e3), 
								.e4(e4), 
								.compress_data(compression_output)
								);

	hamming_encoder error_encoder(
								.data(ecc_enc_input), 
								.q(ecc_enc_output)
								);

	bpsk_mod mod(
				.read_ready(read_ready), 
				.rst(reset), 
				.clk(clk), 
				.input_data(bpsk_mod_input), 
				.BPSK_MOD_OUT(bpsk_mod_output)
				);

	bpsk_demod demod(.ready(read_ready), 
					.rst(reset), 
					.clk(clk), 
					.data_in(bpsk_demod_input), 
					.data_out(bpsk_demod_output)
					);

	hamming_decoder error_decoder(
								.data(ecc_dec_input), 
								.err_corrected(err_corrected), 
								.err_detected(err_detected), 
								.err_fatal(err_fatal), 
								.q(ecc_dec_output)
								);

	data_decompression decompression(
									.c1(c1), 
									.c2(c2), 
									.c3(c3), 
									.c4(c4), 
									.e1(e1), 
									.e2(e2), 
									.e3(e3), 
									.e4(e4), 
									.compress_data(decompression_input), 
									.final_data(decompression_output)
									);

	Transmitter transmitter_module(
									.CLOCK_50(clk), 
									.SIGNAL_IN(transmitter_input), 
									.SIGNAL_OUT(transmitter_output), 
									.ATTEN_START(ATTEN_START)
									);

	channel noise_channel(
						.clk(clk), 
						.ATTEN_START(ATTEN_START),
						.reset(reset),
						.transmitter_signal(channel_input),
						.receiver_signal(channel_output), 
						.attenuated_constant(attenuated)
						);

	Receiver receiver_module(
							.CLK(clk), 
							.SIGNAL_IN(receiver_input), 
							.ATTEN_IN(attenuated), 
							.SIGNAL_OUT(receiver_output),
							.RESET(reset)
							);

	encipher encrypt(
				.plaintext(encryption_input),
				.ciphertext(encryption_output)
				);

   decipher decrypt(
				.ciphertext(decryption_input),
				.plaintext(decryption_output)
				);

endmodule

/*
Purpose: Reuseable system module for audio left, audio right, and text
*/
module sub_sys_text (data_in, data_out, clk, reset, read_ready);

	//I/O
	input [23:0] data_in;
	input clk, reset, read_ready;
	output [23:0] data_out;

	///////////////////////////////////////////////
	//				INTEGRATION WIRES
	///////////////////////////////////////////////

	wire [23:0] compression_input = data_in;
	wire [11:0] compression_output; 

	wire [11:0] ecc_enc_input = compression_output;
	wire [17:0] ecc_enc_output; 

	wire [17:0] encryption_input = ecc_enc_output;
	wire [17:0] encryption_output;

	wire [17:0] bpsk_mod_input = ecc_enc_output;
	wire [17:0] bpsk_mod_output;

	wire [17:0] transmitter_input = bpsk_mod_output;
	wire [35:0] transmitter_output;

	wire [35:0] channel_input = transmitter_output;
	wire [35:0] channel_output;

	wire [35:0] receiver_input = channel_output;
	wire [17:0] receiver_output;

	wire [17:0] bpsk_demod_input = receiver_output;
	wire [17:0] bpsk_demod_output;

	wire [17:0] decryption_input = bpsk_demod_output;
	wire [17:0] decryption_output;

	wire [17:0] ecc_dec_input = bpsk_demod_output;
	wire [11:0] ecc_dec_output;

	wire [11:0] decompression_input = ecc_dec_output;
	wire [23:0] decompression_output;

	assign data_out = decompression_output;

	//WIRES FOR TX/RX, CHANNEL
	wire [4:0] ATTEN_START, ATTEN_CONST, attenuated;

	//WIRES FOR COMPRESSION MODULE
	wire [5:0] c1, c2, c3, c4;
	wire [1:0] e1, e2, e3, e4;

	//WIRES FOR ECC
	wire err_corrected, err_detected, err_fatal;

	///////////////////////////////////////////////
	//		MODULE INSTANTIATIONS
	///////////////////////////////////////////////

	data_compression compression(
								.data_in(compression_input), 
								.c1(c1), 
								.c2(c2), 
								.c3(c3), 
								.c4(c4), 
								.e1(e1), 
								.e2(e2), 
								.e3(e3), 
								.e4(e4), 
								.compress_data(compression_output)
								);

	hamming_encoder error_encoder(
								.data(ecc_enc_input), 
								.q(ecc_enc_output)
								);

	bpsk_mod mod(
				.read_ready(read_ready), 
				.rst(reset), 
				.clk(clk), 
				.input_data(bpsk_mod_input), 
				.BPSK_MOD_OUT(bpsk_mod_output)
				);

	bpsk_demod demod(.ready(read_ready), 
					.rst(reset), 
					.clk(clk), 
					.data_in(bpsk_demod_input), 
					.data_out(bpsk_demod_output)
					);

	hamming_decoder error_decoder(
								.data(ecc_dec_input), 
								.err_corrected(err_corrected), 
								.err_detected(err_detected), 
								.err_fatal(err_fatal), 
								.q(ecc_dec_output)
								);

	data_decompression decompression(
									.c1(c1), 
									.c2(c2), 
									.c3(c3), 
									.c4(c4), 
									.e1(e1), 
									.e2(e2), 
									.e3(e3), 
									.e4(e4), 
									.compress_data(decompression_input), 
									.final_data(decompression_output)
									);

	Transmitter_text transmitter_module(
									.CLOCK_50(clk), 
									.SIGNAL_IN(transmitter_input), 
									.SIGNAL_OUT(transmitter_output), 
									.ATTEN_START(ATTEN_START)
									);

	channel noise_channel(
						.clk(clk), 
						.ATTEN_START(ATTEN_START),
						.reset(reset),
						.transmitter_signal(channel_input),
						.receiver_signal(channel_output), 
						.attenuated_constant(attenuated)
						);

	receiver_text receiver_module(
							.CLK(clk), 
							.SIGNAL_IN(receiver_input), 
							.ATTEN_IN(attenuated), 
							.SIGNAL_OUT(receiver_output),
							.RESET(reset)
							);

endmodule



