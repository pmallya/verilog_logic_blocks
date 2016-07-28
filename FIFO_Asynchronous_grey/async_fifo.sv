module async_fifo#(parameter DATA_LENGTH=8, FIFO_DEPTH=8)
	( output logic [FIFO_DEPTH-1:0] dataOut,
	  output logic full,
	  output logic empty,
	  input logic [FIFO_DEPTH-1:0] dataIn,
	  input logic push,
	  input logic pop,
	  input clock_W,
	  input clock_R,
	  input logic reset);
	
	logic [$clog2(FIFO_DEPTH)-1:0] write_Ptr, read_Ptr;
	
	logic write_enable,read_enable;
		
	assign write_enable = ~reset? 0: (push && !full);
	assign read_enable = ~reset? 0: (pop && !empty);
		
	fifo_mem #(DATA_LENGTH, FIFO_DEPTH)	memory(.dataOut(dataOut),	
	.dataIn(dataIn),
	.read_address(read_Ptr),
	.read_enable(read_enable),
	.write_address(write_Ptr),
	.write_enable(write_enable),
	.write_clk(clock_W),
	.read_clk(clock_R),
	.reset(reset));
	
	fifo_grey_pointer #(FIFO_DEPTH) write_pointer
	(.grey_pointer(write_Ptr),
	.enable(write_enable),
	.clk(clock_W),
	.reset(reset));
	
	fifo_grey_pointer #(FIFO_DEPTH) read_pointer
	(.grey_pointer(read_Ptr),
	.enable(read_enable),
	.clk(clock_R),
	.reset(reset));
	
	fifo_compare #(FIFO_DEPTH) compare
	(.full(full),
	.empty(empty),
	.write_Ptr(write_Ptr),
	.read_Ptr(read_Ptr),
	.reset(reset));
	
	
	endmodule