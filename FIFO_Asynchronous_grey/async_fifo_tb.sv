module async_fifo_tb;
	
	   logic [7:0] dataOut, dataIn;
	   logic full, empty;
	   logic push, pop;
	   logic clock_W, clock_R;
	   logic reset;
	   
	   logic[7:0] mem[7:0];
	
	async_fifo#(8, 8) cdc_fifo
	(.dataOut(),
	 .full(full),
	 .empty(empty),
	 .dataIn(dataIn),
	 .push(push),
	 .pop(pop),
	 .clock_W(clock_W),
	 .clock_R(clock_R),
	 .reset); 
	 
	 initial begin
		 clock_W = 0;
		 clock_R = 0;
		 reset = 0;
		 push = 0;
		 pop = 0;
	 end
	 
	 always #1 clock_W = ~clock_W;
	 always #1 clock_R = ~clock_R;
		 
	initial begin
		#1 reset = 1;
		
		#2 push = 1; dataIn = 8'd34; 
				
		#4 push =0; pop = 1; 
	end
	
		 
		 
	endmodule