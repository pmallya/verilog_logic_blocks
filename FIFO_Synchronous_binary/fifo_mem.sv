module fifo_mem #(parameter DATA_LENGTH=8, FIFO_DEPTH=8)
	(output logic [DATA_LENGTH-1:0] dataOut,
	
	input logic [DATA_LENGTH-1:0] dataIn,
	input [$clog2(DATA_LENGTH)-1:0] read_address,
	input read_enable,
	input [$clog2(DATA_LENGTH)-1:0] write_address,
	input write_enable,
	input clk,
	input reset);
	
	integer i;
	logic[DATA_LENGTH-1:0] memory[FIFO_DEPTH-1:0];
	
	always@(posedge clk) begin: memoryOperation
		if(~reset) 
			for(i=0; i < FIFO_DEPTH; i=i+1) 
				memory[i] <= 'd0;
			else begin 
				memory[write_address] <= write_enable? dataIn: memory[write_address];
				dataOut <= read_enable? memory[read_address]: dataOut;
				end
		end
	
	endmodule