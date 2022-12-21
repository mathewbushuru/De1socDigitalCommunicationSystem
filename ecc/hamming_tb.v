`timescale 1ps/1ps
module hamming_tb();

reg [11:0] ecc_enc_input;
wire [17:0] ecc_enc_output;
wire [11:0] ecc_dec_output;
reg [17:0] inter;
wire err_corrected;
wire err_detected;
wire err_fatal;

hamming_encoder enc(ecc_enc_input, ecc_enc_output);
hamming_decoder dec(.data(inter), .q(ecc_dec_output), .*);

initial 
begin 
ecc_enc_input = 10;
#1;
inter = ecc_enc_output; 
inter[10] = ~inter[10];
inter[1] = ~inter[1];
inter[13] = ~inter[13];
#4;
$stop;
end

endmodule
