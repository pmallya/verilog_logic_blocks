`timescale 1ns/1ns
module  sync_fifo_tb ;
    
	logic [7:0] data_push;
	logic [7:0] data_pop;
	
	logic push; // increment write pointer 
	logic pop; // increment read pointer
	
	logic [7:0] memtmp [7:0];
	logic [2:0] read_Ptr; //read_Ptr_next;
	logic [2:0] wrt_ptr,wrt_ptr_next;
	logic [3:0] count;
	logic full;
	logic empty;
	
	logic almost_full; // a push will cause full next cycle
	
	logic almost_empty; // a pop will cause empty next cycle
	
	logic rst;
	logic clk;
	
	//sync_fifo fifo1 (.data_push (data_push), .data_pop (data_pop), . push(push), .pop(pop), .rst(rst), .clk(clk), .full(full), .empty(empty), .almost_full(almost_full), .almost_empty(almost_empty) );
	sync_fifo#(8, 8) fifo1
	( .dataOut(data_pop),
	  .full(full),
	  .empty(empty),
	  .dataIn(data_push),
	  .push(push),
	  .pop(pop),
	  .clk(clk),
	  .reset(rst));
	
	initial forever #5 clk = ~clk;	 
		
		initial begin
			clk = 0;
			rst = 0;
			
			memtmp = fifo1.memory.memory;  
			
			#5 	read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			////read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			// Write - 2
			#4 rst = 1;
			
			push = 1;	pop = 0;	data_push = 8'd5;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			////read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#5 read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			////read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#4 push = 1;	pop = 0;	data_push = 8'd8; 

			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			////read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#5 read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			////read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#4 data_push = 8'd4;	push = 1;	pop = 0; 

			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			////read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#5 	read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			////read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			/*
			// Read - 2
			#4 push = 0;	pop = 1;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			// Write and read - 1 -, 1
			
			#5 read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			  
			*/
			#4	push = 1;	pop = 0;	data_push = 8'd3;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			////read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#4 			
			push = 1;	pop = 0;	data_push = 8'd3;
				
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			////read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#10 			
			push = 1;	pop = 0;	data_push = 8'd2;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#10 			
			push = 1; pop = 0;	data_push = 8'd1;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#10 			
			push = 1;	pop = 0;	data_push = 8'd9;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#10 			
			push = 1;	pop = 0;	data_push = 8'd14;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#10 			
			push = 1;	pop = 0;	data_push = 8'd1;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#10 			
			push = 0;	pop = 1;	
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			 #20 			
			push = 1;	pop = 1;	data_push = 8'd14;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#5 count = fifo1.count;
			#10 			
			push = 0;	pop = 1;
			
			read_Ptr = fifo1.read_Ptr;	wrt_ptr = fifo1.write_Ptr;	
			//read_Ptr_next = fifo1.//read_Ptr_next;	wrt_ptr_next = fifo1.write_Ptr_next;
			memtmp = fifo1.memory.memory;	count = fifo1.count;
			
			#5 count = fifo1.count;
			#5 count = fifo1.count;
			#5 count = fifo1.count;
			#5 count = fifo1.count;
			#5 count = fifo1.count;
			#5 count = fifo1.count;
			#5 count = fifo1.count;
			#5 count = fifo1.count;
			#5 count = fifo1.count;
			#10 count = fifo1.count;
			#10 count = fifo1.count;
			#10 count = fifo1.count;
			#10 count = fifo1.count;
		end
		
endmodule