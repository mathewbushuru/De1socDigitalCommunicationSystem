module data_decompression (c1, c2, c3, c4, e1, e2, e3, e4, compress_data, final_data);

  input [5:0] c1, c2, c3, c4;
  input [1:0] e1, e2, e3, e4;
  input [11:0] compress_data;
  
  output [23:0] final_data;
  reg [23:0] decompress_data;
  
  assign final_data = decompress_data;
  
  always @(*) begin

      case (compress_data[1:0])
        e1: decompress_data [5:0] = c1;
        e2: decompress_data [5:0] = c2;
        e3: decompress_data [5:0] = c3;
        e4: decompress_data [5:0] = c4;
      default: decompress_data [5:0] = 6'b0;
      endcase
    
      case (compress_data[3:2])
        e1: decompress_data [11:6] = c1;
        e2: decompress_data [11:6] = c2;
        e3: decompress_data [11:6] = c3;
        e4: decompress_data [11:6] = c4;
        default: decompress_data [11:6] = 6'b0;
      endcase
    
      case (compress_data[5:4])
        e1: decompress_data [17:12] = c1;
        e2: decompress_data [17:12] = c2;
        e3: decompress_data [17:12] = c3;
        e4: decompress_data [17:12] = c4;
        default: decompress_data [17:12] = 6'b0;
      endcase
    
      case (compress_data[7:6])
        e1: decompress_data [23:18] = c1;
        e2: decompress_data [23:18] = c2;
        e3: decompress_data [23:18] = c3;
        e4: decompress_data [23:18] = c4;
        default: decompress_data [23:18] = 6'b0;
      endcase


  end

endmodule 