module read_write_ram( q,d,write_address, read_address,we, re, clk);
    output reg [23:0] q;
    input [23:0] d;
    input [7:0] write_address, read_address;
    input we, re, clk;
	 //  M10K ram style
    reg [23:0] mem [255:0];
	 
    always @ (posedge clk) begin
        if (we) begin
            mem[write_address] <= d;
        end
        else if (re) begin
                q <= mem[read_address]; // q doesn't get d in this clock cycle
            end 
    end
endmodule