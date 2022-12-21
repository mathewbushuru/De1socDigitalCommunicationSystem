module data_compression (data_in, c1, c2, c3, c4, e1, e2, e3, e4, compress_data);
  input [23:0] data_in;
  
  output [5:0] c1, c2, c3, c4;
  output [1:0] e1, e2, e3, e4;
  
  output [11:0] compress_data;
  
  compression_conca data_compression_concatenation(data_in, c1, c2, c3, c4, e1, e2, e3, e4, compress_data);
 
endmodule

module compression_conca (data_in, c1, c2, c3, c4, e1, e2, e3 ,e4, compress_data);

  input[23:0] data_in;
  output [5:0] c1, c2, c3, c4;
  
  output [1:0] e1, e2, e3 ,e4;
  output [11:0] compress_data;
  
  assign c1 = data_in[5:0];
  assign c2 = data_in[11:6];
  assign c3 = data_in[17:12];
  assign c4 = data_in[23:18];
  
  assign e1 = 2'b00;
  assign e2 = 2'b01;
  assign e3 = 2'b10;
  assign e4 = 2'b11;
  
  assign compress_data = {4'b0,e4,e3,e2,e1};
  
endmodule