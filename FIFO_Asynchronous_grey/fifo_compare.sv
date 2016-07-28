module fifo_compare #(parameter FIFO_DEPTH = 8)
	(output full,
	output empty,
	input [$clog2(FIFO_DEPTH)-1:0] write_Ptr, 
	input [$clog2(FIFO_DEPTH)-1:0] read_Ptr,
	input reset);
	
	assign empty = ~reset? 0: (read_Ptr == write_Ptr);
	assign full = ~reset? 0: (read_Ptr[$clog2(FIFO_DEPTH)-1] != write_Ptr[$clog2(FIFO_DEPTH)-1]) && (read_Ptr[$clog2(FIFO_DEPTH)-2:0] == write_Ptr[$clog2(FIFO_DEPTH)-2:0]);
		
	endmodule