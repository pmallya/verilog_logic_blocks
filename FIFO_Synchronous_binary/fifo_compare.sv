module fifo_compare #(parameter FIFO_DEPTH = 8)
	(output full,
	output empty,
	input[$clog2(FIFO_DEPTH):0] count,	
	input reset);
	
	assign empty = ~reset? 0: count == 0;
	assign full = ~reset? 0: count == FIFO_DEPTH;
		
	endmodule