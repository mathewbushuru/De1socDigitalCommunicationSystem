  module bpsk_mod (rst, clk, input_data, read_ready, BPSK_MOD_OUT);
  
  input rst, clk,  read_ready;
  input  [17:0] input_data;
  output [17:0] BPSK_MOD_OUT;
  wire BPSK_out;  
  wire en;
  wire clk_25,clk_180;
  wire clk_0;
  
  assign clk_0 = clk;
  Modulation_CarrierWave CARRIER_GEN(clk_25, clk_180, clk, rst);
  Modulation_DataShifter BPSK_DataShift(rst, clk, clk_0, clk_180, clk_25, input_data, BPSK_out, en, read_ready);
  Modulation_DataPacker BPSK_DataPack(en, rst, clk, BPSK_out, BPSK_MOD_OUT, read_ready);   
     
endmodule
 
 
module Modulation_DataPacker ( en, rst, clk, BPSK_in, BPSK_MOD_OUT, read_ready);
  
  `define STATE0 2'b00
  `define STATE1 2'b01
  
  input  rst,  clk,  BPSK_in, en, read_ready;
  output reg[17:0] BPSK_MOD_OUT;
  
  wire clk_25, outclk;
  reg BPSK_de;
  reg [1:0] current_state;
  reg [17:0] de_sample;
  reg [6:0] count;
  
  Modulation_CarrierWave CLK(clk_25, outclk, clk, rst); 
     

  always @ (posedge clk_25 ) begin
    if (rst) begin
      de_sample = 18'b0;
      count = 0;
      current_state = `STATE0;
    end 
    
           
    else begin
      if (current_state == `STATE0) begin
        
        if (count < 18) begin            
          
          //1. Analyzing the Binary Data Represent by the Modulated Wave//
          if (BPSK_in == 1'b1)begin
            BPSK_de = 1'b1;
          end 
        
          else if (BPSK_in == 1'b0) begin
            BPSK_de = 1'b0;
          end 
                 
          else begin
            BPSK_de = 1'b0;
          end 
          //2. Packing Analyzed data in to 12 bits data segment//
          de_sample = de_sample  >> 1;
          de_sample [17] <= BPSK_de;
          count <= count + 1;
        end 
        
        else begin
          count = 0;
          current_state = `STATE1;
        end
         
      end
      
          //3. Sending Out Complete Data Segment//        
      else if (current_state == `STATE1) begin
        if (en == 1'b1) begin
          BPSK_MOD_OUT <= de_sample;
          current_state <= `STATE1;
        end 
       	else if (read_ready) begin
       	  current_state <= `STATE0;
     	  end
        else begin
          current_state <= `STATE1;
        end 
      end
      
      else begin
        current_state <= `STATE1;
     	end  
   
  end
end 

endmodule


module Modulation_BPSK_GENERATION (rst, clk, clk_1, clk_0, data, BPSK_MOD_OUT, signal_en);
  input rst, clk, clk_1, clk_0;
  
  /*
  rst - Aysnchornus Reset
  clk - 50 Mhz Sysem Clk
  clk_0 - 50 Mhz Carrier Wave
  clk_180 - 50 Mhz 180Phase Carrier Wave
  */
  
  input data, signal_en;
  output reg BPSK_MOD_OUT;

  always @ (clk) begin
    if (rst) begin
      //BPSK_MOD_OUT = (data) ? clk_0 : clk_180;  //If data = 1, use clk_0, if data = 0, use clk _180
      BPSK_MOD_OUT = (data) ? clk : ~clk;  //If data = 1, use clk_0, if data = 0, use clk _180
    end else begin
      //BPSK_MOD_OUT = (data) ? clk_0 : clk_180; 
      if (signal_en) begin
        BPSK_MOD_OUT = (data) ? clk : ~clk;
      end
      
      else begin
        BPSK_MOD_OUT = 1'b0;
        
    
     	end
   end  
     
  end
  
  
endmodule



module Modulation_CarrierWave (clk_25, outclk, clk, rst);

   input  clk, rst;
  
   output reg clk_25, outclk;

   wire [31:0] boundary = 32'h00000003; //25Mhz
   wire [31:0] temp = boundary >> 1;      //Half a Period is 200/2 = 100ns
   wire [31:0] counter;
   reg  [31:0] count;
   

always @(clk) begin
  
    outclk = ~clk;
  
end


always @(posedge clk ) begin
	
	if (rst) begin  //rsting the signal, rst = SW[0]  turing the outclk on/off
	count = 32'b0;
	clk_25 = 1'b1;
	end else begin
   	if (count == boundary) begin  //When count mathces boundary value, outclk and count = 0
		  count = 32'b0;
		  clk_25 = 1'b1;
		end 
		
		else begin
			clk_25 = (count < temp) ? 1'b1:1'b0;  //When count reaches half the boundary value, outclk is set to 1 to generate the second half of the waveform
			count = count + 1'b1;
		end
	end
end

endmodule


module Modulation_DataShifter (rst, clk, clk_0, clk_180, clk_25, input_data, output_data, en, read_ready);
  
  `define STATE0 2'b00
  `define STATE1 2'b01
  `define STATE2 2'b10
  `define STATE3 2'b11

  input rst, clk, clk_0, clk_180, clk_25, read_ready;
  input  [17:0] input_data;
  output output_data;
  output reg en;
  reg [17:0] sample;
  reg [1:0] current_state;
  reg [6:0] count;

  reg signal_en;
  Modulation_BPSK_GENERATION BPSK(rst, clk, clk_0, clk_180, sample[0], output_data, signal_en);  
  always @ (posedge clk_25 or posedge rst  ) begin
    if (rst) begin
      signal_en = 1'b0;
      sample = 18'b0;
      current_state = `STATE0;
      en = 1'b0;
      count = 1'b0;
    end 
  
    
    else if (current_state == `STATE0) begin
      
      signal_en <= 1'b1;
      //sample <= (read_ready) ? input_data : 18'b0 ;
      sample <= input_data;
      current_state <= (read_ready)? `STATE1:`STATE0;
      
      
    end
          
      
    
    else if (current_state == `STATE1) begin
      //en <= 1'b0;
      signal_en <= 1'b1;
      if (count < 18) begin
        sample <= sample >> 1;
        count <= count + 1;
      end
      
      else begin
        count <= 0;
        signal_en <= 1'b0;
        current_state <= `STATE2;
      end 
    end
          
    else if (current_state == `STATE2) begin
        signal_en <= 1'b0;
        en <= 1'b1;
        current_state <= `STATE3;
     
    end 
    
    else if (current_state == `STATE3) begin
        en <= 1'b0;
        signal_en <= 1'b0;
        current_state <= `STATE0;
     
    end
    
    else begin
        current_state <= `STATE0;
    end 
    
  end
  
endmodule

