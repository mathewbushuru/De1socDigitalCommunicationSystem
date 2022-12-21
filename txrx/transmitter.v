
/*
module Transmitter(CLOCK_50, SIGNAL_IN, SIGNAL_OUT, ATTEN_START);
	input CLOCK_50; //pulse generation
	input [29:0] SIGNAL_IN; //input signal after modulation
	output [32:0] SIGNAL_OUT; //output signal after adding with pulse
	output [4:0] ATTEN_START; //output signal used to measure attenuation
	
	reg [32:0] SIGNAL_OUT;
	wire [4:0] ATTEN_START;
	
	always@(posedge CLOCK_50) begin
		SIGNAL_OUT <= {SIGNAL_IN, 3'b0};
	end

	assign ATTEN_START = 5'd16; //known value for signal attenuation

endmodule 
*/
//To be used after compression/modulation is confirmed to be working
module Transmitter(CLOCK_50, SIGNAL_IN, SIGNAL_OUT, ATTEN_START);
	input CLOCK_50; //pulse generation
	input [17:0] SIGNAL_IN; //input signal after modulation
	//output [20:0] SIGNAL_OUT; //output signal after adding with pulse
	output [20:0] SIGNAL_OUT;
	output [4:0] ATTEN_START; //output signal used to measure attenuation
	
	reg [20:0] SIGNAL_OUT;
	wire [4:0] ATTEN_START;
	
	always@(posedge CLOCK_50) begin
		SIGNAL_OUT <= {SIGNAL_IN, 3'b0};
		//SIGNAL_OUT <= {SIGNAL_IN, 18'b0};
	end

	assign ATTEN_START = 5'd16; //known value for signal attenuation
endmodule

module Transmitter_text (CLOCK_50, SIGNAL_IN, SIGNAL_OUT, ATTEN_START);
	input CLOCK_50; //pulse generation
	input [17:0] SIGNAL_IN; //input signal after modulation
	//output [20:0] SIGNAL_OUT; //output signal after adding with pulse
	output [35:0] SIGNAL_OUT;
	output [4:0] ATTEN_START; //output signal used to measure attenuation
	
	reg [35:0] SIGNAL_OUT;
	wire [4:0] ATTEN_START;
	
	always@(posedge CLOCK_50) begin
		//SIGNAL_OUT <= {SIGNAL_IN, 3'b0};
		SIGNAL_OUT <= {SIGNAL_IN, 18'b0};
	end

	assign ATTEN_START = 5'd16; //known value for signal attenuation

endmodule

