
/*
module Receiver(CLK, SIGNAL_IN, ATTEN_IN, SIGNAL_OUT);
	input [32:0] SIGNAL_IN; //received signal
	input [4:0] ATTEN_IN; //received attenuation factor
	input CLK;
	output [29:0] SIGNAL_OUT; //filtered and corrected signal output
	
	wire [29:0] SIGNAL_FILTER; //signal when being filtered
	reg [29:0] SIGNAL_ATTEN; //signal when having attenuation corrected
	reg [4:0] ATTEN_FACTOR; //Value signal is attenuated by
	
	
	always @(*) begin //attenuator
		if (ATTEN_IN == 5'd16) begin
			SIGNAL_ATTEN = SIGNAL_IN[32:3] ;
		end
		else if (ATTEN_IN == 5'd8) begin
			SIGNAL_ATTEN = SIGNAL_IN[31:2] ; //if divided by 2 (shift by 1)
		end
		else if (ATTEN_IN == 5'd4) begin
			SIGNAL_ATTEN = SIGNAL_IN[30:1] ; //if divided by 4 (shift by 2)
		end
		else if (ATTEN_IN == 5'd2) begin
			SIGNAL_ATTEN = SIGNAL_IN[29:0] ; //if divided by 8 (shift by 3)
		end
		else begin
			SIGNAL_ATTEN = 30'd0;
		end
	end

	assign SIGNAL_OUT = SIGNAL_FILTER; //signal out post receiver functions

	filter FILTER(CLK, SIGNAL_ATTEN, SIGNAL_FILTER);//instantiate filter module
	
endmodule


module filter(CLK, SIGNAL_IN, SIGNAL_FILTER);
	input CLK;
	input [29:0] SIGNAL_IN;
	output [29:0] SIGNAL_FILTER;

	reg signed [29:0] in_reg_2;
	reg signed [29:0] in_reg_1;
	reg signed [29:0] in_reg_3;
	reg signed [29:0] in_reg_4;
	reg signed [29:0] in_reg_5;
	reg signed [29:0] in_reg_6;
	reg signed [29:0] in_reg_7;
	reg signed [29:0] in_reg_8;
	
	wire signed [29:0] in_wire_1;
	wire signed [29:0] in_wire_3;
	wire signed [29:0] in_wire_2;
	wire signed [29:0] in_wire_4;
	wire signed [29:0] in_wire_5;
	wire signed [29:0] in_wire_6;
	wire signed [29:0] in_wire_7;
	wire signed [29:0] in_wire_8;

	always @(posedge CLK) begin
	begin
		in_reg_1 <= SIGNAL_IN;
		in_reg_2 <= in_reg_1;
		in_reg_3 <= in_reg_2;
		in_reg_4 <= in_reg_3;
		in_reg_5 <= in_reg_4;
		in_reg_6 <= in_reg_5;
		in_reg_7 <= in_reg_6;
		in_reg_8 <= in_reg_7;
	end
	end
	
	assign in_wire_1 = in_reg_1 >>> 3;
	assign in_wire_2 = in_reg_2 >>> 3;
	assign in_wire_3 = in_reg_3 >>> 3;
	assign in_wire_4 = in_reg_4 >>> 3;
	assign in_wire_5 = in_reg_5 >>> 3;
	assign in_wire_6 = in_reg_6 >>> 3;
	assign in_wire_7 = in_reg_7 >>> 3;
	assign in_wire_8 = in_reg_8 >>> 3;
	
	assign SIGNAL_FILTER = in_wire_1 + in_wire_2 + in_wire_3 + in_wire_4 + in_wire_5 + in_wire_6 + in_wire_7 + in_wire_8; 

endmodule
*/

module Receiver(CLK, SIGNAL_IN, ATTEN_IN, SIGNAL_OUT, RESET);
	input [20:0] SIGNAL_IN; //received signal
	input [4:0] ATTEN_IN; //received attenuation factor
	input CLK;
	output [17:0] SIGNAL_OUT; //filtered and corrected signal output
	input RESET;
	
	wire [17:0] SIGNAL_FILTER; //signal when being filtered
	reg [17:0] SIGNAL_ATTEN; //signal when having attenuation corrected
	reg [4:0] ATTEN_FACTOR; //Value signal is attenuated by
	
	
	always @(*) begin //attenuator
		if (ATTEN_IN == 5'd16) begin
			SIGNAL_ATTEN = SIGNAL_IN[20:3] ;
		end
		else if (ATTEN_IN == 5'd8) begin
			SIGNAL_ATTEN = SIGNAL_IN[19:2] ; //if divided by 2 (shift by 1)
		end
		else if (ATTEN_IN == 5'd4) begin
			SIGNAL_ATTEN = SIGNAL_IN[18:1] ; //if divided by 4 (shift by 2)
		end
		else if (ATTEN_IN == 5'd2) begin
			SIGNAL_ATTEN = SIGNAL_IN[17:0] ; //if divided by 8 (shift by 3)
		end
		else begin
			SIGNAL_ATTEN = 18'd0;
		end
	end

	assign SIGNAL_OUT = SIGNAL_FILTER; //signal out post receiver functions

	filter FILTER(CLK, SIGNAL_ATTEN, SIGNAL_FILTER, RESET);//instantiate filter module
	
endmodule

module filter(CLK, SIGNAL_IN, SIGNAL_FILTER, RESET);
	input CLK, RESET;
	input [17:0] SIGNAL_IN;
	output [17:0] SIGNAL_FILTER;
	
	reg signed [17:0] in_reg_1;
	reg signed [17:0] in_reg_2;
	reg signed [17:0] in_reg_3;
	reg signed [17:0] in_reg_4;
	reg signed [17:0] in_reg_5;
	reg signed [17:0] in_reg_6;
	reg signed [17:0] in_reg_7;
	reg signed [17:0] in_reg_8;
	reg signed [17:0] in_reg_9;
	reg signed [17:0] in_reg_10;
	reg signed [17:0] in_reg_11;
	reg signed [17:0] in_reg_12;
	reg signed [17:0] in_reg_13;
	reg signed [17:0] in_reg_14;
	reg signed [17:0] in_reg_15;
	reg signed [17:0] in_reg_16;
	reg signed [17:0] in_reg_17;
	reg signed [17:0] in_reg_18;
	reg signed [17:0] in_reg_19;
	reg signed [17:0] in_reg_20;
	reg signed [17:0] in_reg_21;
	reg signed [17:0] in_reg_22;
	reg signed [17:0] in_reg_23;
	reg signed [17:0] in_reg_24;
	reg signed [17:0] in_reg_25;
	reg signed [17:0] in_reg_26;
	reg signed [17:0] in_reg_27;
	reg signed [17:0] in_reg_28;
	reg signed [17:0] in_reg_29;
	reg signed [17:0] in_reg_30;
	reg signed [17:0] in_reg_31;
	reg signed [17:0] in_reg_32;

	wire signed [17:0] in_wire_1;
	wire signed [17:0] in_wire_2;
	wire signed [17:0] in_wire_3;
	wire signed [17:0] in_wire_4;
	wire signed [17:0] in_wire_5;
	wire signed [17:0] in_wire_6;
	wire signed [17:0] in_wire_7;
	wire signed [17:0] in_wire_8;
	wire signed [17:0] in_wire_9;
	wire signed [17:0] in_wire_10;
	wire signed [17:0] in_wire_11;
	wire signed [17:0] in_wire_12;
	wire signed [17:0] in_wire_13;
	wire signed [17:0] in_wire_14;
	wire signed [17:0] in_wire_15;
	wire signed [17:0] in_wire_16;
	wire signed [17:0] in_wire_17;
	wire signed [17:0] in_wire_18;
	wire signed [17:0] in_wire_19;
	wire signed [17:0] in_wire_20;
	wire signed [17:0] in_wire_21;
	wire signed [17:0] in_wire_22;
	wire signed [17:0] in_wire_23;
	wire signed [17:0] in_wire_24;
	wire signed [17:0] in_wire_25;
	wire signed [17:0] in_wire_26;
	wire signed [17:0] in_wire_27;
	wire signed [17:0] in_wire_28;
	wire signed [17:0] in_wire_29;
	wire signed [17:0] in_wire_30;
	wire signed [17:0] in_wire_31;
	wire signed [17:0] in_wire_32;

	always @(posedge CLK) begin
		if(RESET)
		begin
			in_reg_1 <= 0;
			in_reg_2 <= 0;
			in_reg_3 <= 0;
			in_reg_4 <= 0;
			in_reg_5 <= 0;
			in_reg_6 <= 0;
			in_reg_7 <= 0;
			in_reg_8 <= 0;
			in_reg_9 <= 0;
			in_reg_10 <= 0;
			in_reg_11 <= 0;
			in_reg_12 <= 0;
			in_reg_13 <= 0;
			in_reg_14 <= 0;
			in_reg_15 <= 0;
			in_reg_16 <= 0;
			in_reg_17 <= 0;
			in_reg_18 <= 0;
			in_reg_19 <= 0;
			in_reg_20 <= 0;
			in_reg_21 <= 0;
			in_reg_22 <= 0;
			in_reg_23 <= 0;
			in_reg_24 <= 0;
			in_reg_25 <= 0;
			in_reg_26 <= 0;
			in_reg_27 <= 0;
			in_reg_28 <= 0;
			in_reg_29 <= 0;
			in_reg_30 <= 0;
			in_reg_31 <= 0;
			in_reg_32 <= 0;
		end
			
		else
		begin
			in_reg_1 <= SIGNAL_IN;
			in_reg_2 <= in_reg_1;
			in_reg_3 <= in_reg_2;
			in_reg_4 <= in_reg_3;
			in_reg_5 <= in_reg_4;
			in_reg_6 <= in_reg_5;
			in_reg_7 <= in_reg_6;
			in_reg_8 <= in_reg_7;
			in_reg_9 <= in_reg_8;
			in_reg_10 <= in_reg_9;
			in_reg_11 <= in_reg_10;
			in_reg_12 <= in_reg_11;
			in_reg_13 <= in_reg_12;
			in_reg_14 <= in_reg_13;
			in_reg_15 <= in_reg_14;
			in_reg_16 <= in_reg_15;
			in_reg_17 <= in_reg_16;
			in_reg_18 <= in_reg_17;
			in_reg_19 <= in_reg_18;
			in_reg_20 <= in_reg_19;
			in_reg_21 <= in_reg_20;
			in_reg_22 <= in_reg_21;
			in_reg_23 <= in_reg_22;
			in_reg_24 <= in_reg_23;
			in_reg_25 <= in_reg_24;
			in_reg_26 <= in_reg_25;
			in_reg_27 <= in_reg_26;
			in_reg_28 <= in_reg_27;
			in_reg_29 <= in_reg_28;
			in_reg_30 <= in_reg_29;
			in_reg_31 <= in_reg_30;
			in_reg_32 <= in_reg_31;
		end

	end
	
	assign in_wire_1 = in_reg_1 >>> 5;
	assign in_wire_2 = in_reg_2 >>> 5;
	assign in_wire_3 = in_reg_3 >>> 5;
	assign in_wire_4 = in_reg_4 >>> 5;
	assign in_wire_5 = in_reg_5 >>> 5;
	assign in_wire_6 = in_reg_6 >>> 5;
	assign in_wire_7 = in_reg_7 >>> 5;
	assign in_wire_8 = in_reg_8 >>> 5;
	assign in_wire_9 = in_reg_9 >>> 5;
	assign in_wire_10 = in_reg_10 >>> 5;
	assign in_wire_11 = in_reg_11 >>> 5;
	assign in_wire_12 = in_reg_12 >>> 5;
	assign in_wire_13 = in_reg_13 >>> 5;
	assign in_wire_14 = in_reg_14 >>> 5;
	assign in_wire_15 = in_reg_15 >>> 5;
	assign in_wire_16 = in_reg_16 >>> 5;
	assign in_wire_17 = in_reg_17 >>> 5;
	assign in_wire_18 = in_reg_18 >>> 5;
	assign in_wire_19 = in_reg_19 >>> 5;
	assign in_wire_20 = in_reg_20 >>> 5;
	assign in_wire_21 = in_reg_21 >>> 5;
	assign in_wire_22 = in_reg_22 >>> 5;
	assign in_wire_23 = in_reg_23 >>> 5;
	assign in_wire_24 = in_reg_24 >>> 5;
	assign in_wire_25 = in_reg_25 >>> 5;
	assign in_wire_26 = in_reg_26 >>> 5;
	assign in_wire_27 = in_reg_27 >>> 5;
	assign in_wire_28 = in_reg_28 >>> 5;
	assign in_wire_29 = in_reg_29 >>> 5;
	assign in_wire_30 = in_reg_30 >>> 5;
	assign in_wire_31 = in_reg_31 >>> 5;
	assign in_wire_32 = in_reg_32 >>> 5;
	
	assign SIGNAL_FILTER = in_wire_1 + in_wire_2 + in_wire_3 + in_wire_4 + in_wire_5 + in_wire_6 + in_wire_7 + in_wire_8 + 
						   in_wire_9 + in_wire_10 + in_wire_11 + in_wire_12 + in_wire_13 + in_wire_14 + in_wire_15 + in_wire_16 +
						   in_wire_17 + in_wire_18 + in_wire_19 + in_wire_20 + in_wire_21 + in_wire_22 + in_wire_23 + in_wire_24 + 
						   in_wire_25 + in_wire_26 + in_wire_27 + in_wire_28 + in_wire_29 + in_wire_30 + in_wire_31 + in_wire_32; 

endmodule

