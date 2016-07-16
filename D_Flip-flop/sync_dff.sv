module sync_dff(clk, rst, d, q);
	parameter DATA_SIZE = 0;
	input wire clk;
	input wire rst;
	input wire [0:DATA_SIZE-1]d;
	output reg [0:DATA_SIZE-1]q;
	
	always_ff@(posedge clk)
	begin
			q <= ~rst? 0: d;
	end

endmodule
