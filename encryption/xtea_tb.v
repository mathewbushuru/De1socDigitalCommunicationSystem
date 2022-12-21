module xtea_encryption_tb();

wire [17:0] ciphertext;
reg [17:0] plaintext;
wire [17:0] plaintext_out;
reg clk, rst;

xtea_encipher encip(plaintext, ciphertext, clk , rst);
xtea_decipher decip(ciphertext, plaintext_out, clk , rst);

initial begin
    clk = 1; #1;
    forever begin
        clk = ~clk; #1;
    end
end

initial 
begin 
rst = 1; 
plaintext = 3;
#2
rst = 0;
#200;
$stop;
end

endmodule