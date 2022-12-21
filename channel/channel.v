//`define constant16 5'd16
//`define transmission_distance = 13'd100
/*
module channel (clk, ATTEN_START, reset,transmitter_signal,receiver_signal, attenuated_constant );
    input clk, reset;
    input [32:0] transmitter_signal;
    input [4:0] ATTEN_START;
    output [32:0] receiver_signal;
    output [4:0] attenuated_constant;

    wire [32:0] attenuated_signal;
    attenuation AttenuationBlock (clk,ATTEN_START, transmitter_signal, attenuated_signal,attenuated_constant);

    wire [32:0] generated_noise;
    wire noise_enable = 1'b1;
    //noise_generator NoiseBlock (clk,noise_enable,generated_noise);

    awgn_noise_generator AWGNBlock (clk, reset,generated_noise);

    assign receiver_signal = transmitter_signal; //attenuated_signal + generated_noise;

endmodule 

module attenuation (clk, ATTEN_START, original_signal, attenuated_signal,attenuated_constant);
    input [32:0] original_signal;
    input [4:0] ATTEN_START;
    input clk;
    output reg [32:0] attenuated_signal;
    output  reg  [4:0] attenuated_constant;

    wire [5:0]constant16 = ATTEN_START;
    parameter transmission_distance = 13'd100;              //either 100m, 500m or 1000m

    always @(posedge clk) begin 
        if (transmission_distance == 13'd100) begin
          attenuated_signal = original_signal >>> 1;
          attenuated_constant = constant16 >>> 1;
        end
        else if (transmission_distance == 13'd500) begin
          attenuated_signal = original_signal >>> 2;
          attenuated_constant = constant16 >>> 2;
        end
        else begin
          attenuated_signal = original_signal >>> 3;
          attenuated_constant = constant16 >>> 3;
        end
    end 

endmodule


module noise_generator (clk,enable,generated_noise);
    input clk,enable;
    output [15:0] generated_noise;

    reg [2:0] counter = 3'd0;

    always @ (posedge clk)
        if (enable)
            counter = counter +1'b1;

    //assign generated_noise = { {2{counter[2]}}, counter, 11'd0 };
    assign generated_noise = {{13{1'd0}},counter};

endmodule 


//Using LFSRs to produce generated noise
//LFSR works by cunningly manipulating output of shift register back to input in order to endlessly cycle through sequences of patterns
//avoid having value of 0 in register since it will then indefinitely remain 0
module awgn_noise_generator (clk, reset,generated_noise);

    input clk,reset;
    output reg [32:0] generated_noise;

    wire feedback = generated_noise[0] ^ generated_noise[32];

    parameter LFSR_starting_state = 24'b101010111010101110101011;

    always @ (posedge clk or posedge reset) begin
      if (reset)
        generated_noise <= 6'hF;
      else 
        generated_noise <= {generated_noise[31:0],feedback};
    end

endmodule 
*/

module channel (clk, ATTEN_START, reset,transmitter_signal,receiver_signal, attenuated_constant );
    input clk, reset;
    input [20:0] transmitter_signal;
    //input [35:0] transmitter_signal;
    input [4:0] ATTEN_START;
    output [20:0] receiver_signal;
    //output [35:0] receiver_signal;
    output [4:0] attenuated_constant;

    wire [20:0] attenuated_signal;
   // wire [35:0] attenuated_signal;
    attenuation AttenuationBlock (clk,ATTEN_START, transmitter_signal, attenuated_signal,attenuated_constant);

    wire [15:0] generated_noise;
    wire noise_enable = 1'b1;
    noise_generator NoiseBlock (clk,noise_enable,generated_noise);

    //awgn_noise_generator AWGNBlock (clk, reset,generated_noise);

    assign receiver_signal = attenuated_signal + generated_noise;

endmodule 

module channel_text (clk, ATTEN_START, reset,transmitter_signal,receiver_signal, attenuated_constant );
    input clk, reset;
    //input [20:0] transmitter_signal;
    input [35:0] transmitter_signal;
    input [4:0] ATTEN_START;
    //output [20:0] receiver_signal;
    output [35:0] receiver_signal;
    output [4:0] attenuated_constant;

    //wire [20:0] attenuated_signal;
    wire [35:0] attenuated_signal;
    attenuation AttenuationBlock (clk,ATTEN_START, transmitter_signal, attenuated_signal,attenuated_constant);

    wire [15:0] generated_noise;
    wire noise_enable = 1'b1;
    noise_generator NoiseBlock (clk,noise_enable,generated_noise);

    //awgn_noise_generator AWGNBlock (clk, reset,generated_noise);

    assign receiver_signal = attenuated_signal + generated_noise;

endmodule 

module attenuation (clk, ATTEN_START, original_signal, attenuated_signal,attenuated_constant);
    input [20:0] original_signal;
    input [4:0] ATTEN_START;
    input clk;
    output reg [20:0] attenuated_signal;
    output  reg  [4:0] attenuated_constant;

    wire [4:0]constant16 = ATTEN_START;
    parameter transmission_distance = 13'd100;              //either 100m, 500m or 1000m

    always @(posedge clk) begin 
        if (transmission_distance == 13'd100) begin
          attenuated_signal = original_signal >>> 1;
          attenuated_constant = constant16 >>> 1;
        end
        else if (transmission_distance == 13'd500) begin
          attenuated_signal = original_signal >>> 2;
          attenuated_constant = constant16 >>> 2;
        end
        else begin
          attenuated_signal = original_signal >>> 3;
          attenuated_constant = constant16 >>> 3;
        end
    end 

endmodule


module noise_generator (clk,enable,generated_noise);
    input clk,enable;
    output [15:0] generated_noise;

    reg [2:0] counter = 3'd0;

    always @ (posedge clk)
        if (enable)
            counter = counter +1'b1;

    //assign generated_noise = { {2{counter[2]}}, counter, 11'd0 };
    assign generated_noise = {{13{1'd0}},counter};

endmodule 


//Using LFSRs to produce generated noise
//LFSR works by cunningly manipulating output of shift register back to input in order to endlessly cycle through sequences of patterns
//avoid having value of 0 in register since it will then indefinitely remain 0
module awgn_noise_generator (clk, reset,generated_noise);

    input clk,reset;
    output reg [15:0] generated_noise;

    wire feedback = generated_noise[0] ^ generated_noise[15];

    parameter LFSR_starting_state = 24'b101010111010101110101011;

    always @ (posedge clk or posedge reset) begin
      if (reset)
        generated_noise <= 6'hF;
      else 
        generated_noise <= {generated_noise[14:0],feedback};
    end

endmodule 
