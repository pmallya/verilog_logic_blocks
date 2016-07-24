// fifo_counter
// Counter only keeps track of the count for full or empty status
module fifo_counter #(parameter FIFO_DEPTH = 8) 
	( output logic [$clog2(FIFO_DEPTH):0] count,
	  input[1:0] enable_count,
	  input reset,	  
	  input clk);
	    
	  always@(posedge clk) begin: Counter	 
		  if( ~reset ) 
    		count <= 0;
		  else begin
			  case (enable_count)
					  2'b00        : count <= count;      			
					  2'b01        : count <= (count==0) ? count : count-1; 
					  2'b10        : count <= (count==FIFO_DEPTH) ? count : count+1;       			
					  2'b11        : count <= count;      			
					  default      : count <= count;
				  endcase 
			  end
		  end: Counter

endmodule