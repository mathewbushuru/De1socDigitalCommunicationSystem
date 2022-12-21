module xor_caesar_tb();

reg [17:0] plaintext_input;
wire [17:0] ciphertext;
wire [17:0] plaintext_output;

encipher in(plaintext_input, ciphertext);
decipher out(ciphertext, plaintext_output);

initial 
begin 
plaintext_input = 50;
#10
$stop;
end

endmodule