`timescale 1ps/1ps
module sys_tb();

reg [23:0] readdata_left;
wire [23:0] writedata_left;
reg clk, reset;

sub_sys DUT(.data_in(readdata_left), .data_out(writedata_left), .clk(clk), .reset(reset));

initial begin
    clk = 1; #1;
    forever begin
        clk = ~clk; #1;
    end
end

initial 
begin 
reset = 1;
readdata_left = 10;
#2;
reset = 0;
#6;
readdata_left = 4;
#5;
readdata_left = 1;
#1;
readdata_left = 2; 
#2;
#20;
#4;
$stop;
end

endmodule
