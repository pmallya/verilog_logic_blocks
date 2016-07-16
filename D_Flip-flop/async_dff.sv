module async_dff(clk, rst, d, q); 
	parameter DATA_SIZE = 0;
	
	input logic clk;
	input logic rst;
	input logic [0:DATA_SIZE-1] d;
	output logic [0:DATA_SIZE-1] q;
	
	always_ff@(posedge clk or negedge rst)
	begin
		if(~rst)
			q <= 0;
		else
			q <= d;
		end
	endmodule
	