module encipher(plaintext, ciphertext);

input [17:0] plaintext;
output [17:0] ciphertext;

wire [17:0] xor1; 
wire [17:0] xor2;
wire [17:0] xor3; 

assign xor1 = plaintext ^ 'h345A;
assign xor2 = xor1 ^ 'hB01A;
assign xor3 = xor2 ^ 'h9312;

wire [17:0] caesar_key = 'hABC3;

assign ciphertext = {(plaintext + caesar_key) % 26};

endmodule

module decipher(ciphertext, plaintext);

input [17:0] ciphertext;
output [17:0] plaintext;

wire [17:0] xor1; 
wire [17:0] xor2;
wire [17:0] xor3; 

wire [17:0] caesar_key = 5;

wire [17:0] decrypted_caesar = (ciphertext - caesar_key) % 26;

assign xor1 = decrypted_caesar ^ 'h9312;
assign xor2 = xor1 ^ 'hB01A;
assign xor3 = xor2 ^ 'h345A;

assign plaintext = xor3;

endmodule


module xtea_encipher(plaintext, ciphertext, clk, rst);

input [17:0] plaintext;
output reg [17:0] ciphertext;
input clk, rst;

wire [31:0] delta = 'h9E3779B9;

wire [0:3] keyarray [31:0];
assign keyarray[0] = 1034;
assign keyarray[1] = 320;
assign keyarray[2] = 12;
assign keyarray[3] = 311;

wire [5:0] num_rounds = 32;

reg [17:0] v0; 
reg [17:0] v1;
reg [5:0] i;
reg [31:0] sum;

always@(posedge clk)
begin
    if(rst)
    begin
        sum <= 0;
        i <= 0;
        v0 <= plaintext;
        v1 <= 0;
        ciphertext <= 0;
    end

    else
    begin
        if(i < num_rounds)
        begin
            v0 <= v0 + (((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + keyarray[sum & 3]);
            sum <= sum + delta;
            v1 <= (((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + keyarray[(sum>>11) & 3]);
            i <= i + 1;
        end
        
        else
        begin
            ciphertext <= v0;
            sum <= 0;
            i <= 0;
            v0 <= plaintext;
            v1 <= 0;
        end
        
    end

end

endmodule


module xtea_decipher(ciphertext, plaintext, clk, rst);

output reg [17:0] plaintext;
input [17:0] ciphertext;
input clk, rst;

wire [31:0] delta = 'h9E3779B9;

wire [0:3] keyarray [31:0];
assign keyarray[0] = 1034;
assign keyarray[1] = 320;
assign keyarray[2] = 12;
assign keyarray[3] = 311;

wire [5:0] num_rounds = 32;

reg [17:0] v0; 
reg [17:0] v1;
reg [5:0] i;
reg [31:0] sum;

always@(posedge clk)
begin
    if(rst)
    begin
        sum <= delta*num_rounds;
        i <= 0;
        v0 <= ciphertext;
        v1 <= 0;
        plaintext <= 0;
    end

    else
    begin
        if(i < num_rounds)
        begin
            v1 <= v1 - (((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + keyarray[(sum>>11) & 3]);
            sum <= sum - delta;
            v0 <= v0 - (((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + keyarray[sum & 3]);
            i <= i + 1;
        end
        
        else
        begin
            plaintext <= v0;
            sum <= delta*num_rounds;
            i <= 0;
            v0 <= ciphertext;
            v1 <= 0;
        end
        
    end

end


endmodule
