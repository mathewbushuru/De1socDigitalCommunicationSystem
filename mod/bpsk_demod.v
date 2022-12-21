module bpsk_demod( rst, clk, data_in, ready, data_out);
  
  input ready, rst, clk;
  input [17:0] data_in;
  output reg [17:0] data_out;
  //output clk_25, outclk;
  wire clk_25, outclk;
  
  Modulation_CarrierWave Carrier(clk_25, outclk, clk, rst); 
  
  always @(posedge clk_25) begin
        data_out <= data_in ;
  end
 
  endmodule 