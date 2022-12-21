
module textfsm(clk, reset, read_enable, write_enable, text_ram_in,read_address, write_address);

    input clk,reset;
    output reg read_enable, write_enable;
    output reg [23:0] text_ram_in;
    output reg [7:0] read_address, write_address;

    reg [22:0] counter;

    always @ (posedge clk) begin
        if (reset) begin
            counter <= 23'd0;
            text_ram_in <= 24'd1;
            read_enable <= 1'b0;
            write_enable <=1'b0;
            read_address <= 8'd0;
            write_address <= 8'd1;
        end 
        else if (counter == 23'd40) begin
            text_ram_in <= text_ram_in +24'd1;
            counter <= counter+23'd1;
            write_enable <=  1'd1;
            write_address <= write_address+8'd1;
        end
        else if (counter == 23'd80) begin
            counter <=23'd0;
            read_enable <=  1'd1;
            read_address <= read_address+8'd1;
        end
        else begin
            counter <= counter+23'd1;
            read_enable <= 1'b0;
            write_enable <=1'b0;
        end
    end

endmodule