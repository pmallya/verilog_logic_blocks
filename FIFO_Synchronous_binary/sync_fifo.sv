module sync_fifo#(parameter DATA_LENGTH=8, FIFO_DEPTH=8)
	( output logic [FIFO_DEPTH-1:0] dataOut,
	  output logic full,
	  output logic empty,
	  input logic [FIFO_DEPTH-1:0] dataIn,
	  input logic push,
	  input logic pop,
	  input clk,
	  input logic reset);
	
	logic [$clog2(FIFO_DEPTH)-1:0] write_Ptr, read_Ptr;
	logic [$clog2(FIFO_DEPTH):0] count;		   
	
	logic write_enable,read_enable;
	logic[1:0] count_enable;
	
	assign write_enable = ~reset? 0: (push && !full);
	assign read_enable = ~reset? 0: (pop && !empty);
	assign count_enable = ~reset? 0: {write_enable,read_enable};
	
	fifo_mem #(8, 8)	memory(.dataOut(dataOut),	
	.dataIn(dataIn),
	.read_address(read_Ptr),
	.read_enable(read_enable),
	.write_address(write_Ptr),
	.write_enable(write_enable),
	.clk(clk),
	.reset(reset));
	
	fifo_pointer #(8) write_pointer
	(.pointer(write_Ptr),
	.enable(write_enable),
	.clk(clk),
	.reset(reset));
	
	fifo_pointer #(8) read_pointer
	(.pointer(read_Ptr),
	.enable(read_enable),
	.clk(clk),
	.reset(reset));
	
	fifo_compare #(8) compare
	(.full(full),
	.empty(empty),
	.count(count),
	.reset(reset));
	
	fifo_counter #(8) counter 
	( .count(count),
	  .enable_count(count_enable),
	  .reset(reset),	  
	  .clk(clk));
	
	
	endmodule