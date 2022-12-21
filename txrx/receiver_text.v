module receiver_text(SIGNAL_IN, ATTEN_IN, SIGNAL_OUT,RESET,CLK); 
	input [35:0] SIGNAL_IN; //received signal
	input [4:0] ATTEN_IN; //received attenuation factor
	output [17:0] SIGNAL_OUT; //filtered and corrected signal output
	input RESET,CLK;

	
	wire [17:0] SIGNAL_FILTER; //signal when being filtered
	reg [32:0] SIGNAL_ATTEN; //signal when having attenuation corrected
	reg [4:0] ATTEN_FACTOR; //Value signal is attenuated by
	
	
	always @(*) begin //attenuator
		if (ATTEN_IN == 5'd16) begin
			SIGNAL_ATTEN = SIGNAL_IN[35:3] ;
		end
		else if (ATTEN_IN == 5'd8) begin
			SIGNAL_ATTEN = SIGNAL_IN[34:2] ; //if divided by 2 (shift by 1)
		end
		else if (ATTEN_IN == 5'd4) begin
			SIGNAL_ATTEN = SIGNAL_IN[33:1] ; //if divided by 4 (shift by 2)
		end
		else if (ATTEN_IN == 5'd2) begin
			SIGNAL_ATTEN = SIGNAL_IN[32:0] ; //if divided by 8 (shift by 3)
		end
		else begin
			SIGNAL_ATTEN = 32'd0;
		end
	end

	assign SIGNAL_OUT = SIGNAL_FILTER; //signal out post receiver functions

	filter_text FILTER(SIGNAL_ATTEN, SIGNAL_FILTER);//instantiate filter module
	
endmodule


module filter_text(SIGNAL_IN, SIGNAL_FILTER);
	input [32:0] SIGNAL_IN;
	output [17:0] SIGNAL_FILTER;
	
	
	assign SIGNAL_FILTER = SIGNAL_IN[32:15]; //remove noise vary size according to amount of noise and text size
	
endmodule
