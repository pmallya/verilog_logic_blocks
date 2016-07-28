module sync_fifo 
	#(parameter int wL = 8,
	  parameter int d = 8 ) 
	
   (input logic [wL-1:0] data_push,
	output logic [wL-1:0] data_pop,
	
	input logic push, // increment write pointer 
	input logic pop, // increment read pointer
	
	output logic full,
	output logic almost_full, // a push will cause full next cycle
	output logic empty,
	output logic almost_empty, // a pop will cause empty next cycle
	
	input logic rst,
	input logic clk
	);
	
	parameter addL = $clog2(d); // $
	
	logic [wL-1:0]  mem[d-1:0];
	logic [addL-1:0] wrtPtr, wrtPtr_next;
	logic [addL-1:0] rdPtr, rdPtr_next;	 
	logic [addL:0] cnt;
	
	logic full_next, empty_next, almost_full_next, almost_empty_next;
	
	// Assertions 
	// assert -> cant pop on empty
	// assert ( empty_next == 1 ) else $error("Empty: The memory is completely read and empty") ;
	// assert -> cant push on full
	// assert ( full_next == 1 ) else $error("Full: The memory is full.") ;
	// assert -> push w/o pop and almost_full last cycle is full now			  
	// assert ( almost_full_next == 1 ) else $error("Alomost Full: The memory one write entry left.") ;
	// assert -> pop w/o push and almost_empty last cycle is empty now			  
	// assert ( almost_empty_next == 1 ) else $error("Almost Empty: The memory has one element left to reead.") ;
	
	assign data_pop = mem[rdPtr];
	assign full_next = (cnt == wL)? 1 : 0;
	assign empty_next = ((cnt == 0) && (rdPtr == wrtPtr)) ? 1: 0;
	
	assign almost_full_next = (cnt == wL-1)? 1 : 0;					  
	assign almost_empty_next = (cnt == 1) ? 1: 0;
	
	always_ff @(posedge clk) begin
		if (~rst) begin
			wrtPtr <= 0;
			// for loop to reset the memory
			for (int i=0;i<wL;i=i+1) begin
				mem[i] <= 0;
			end
		end
		else begin	  
			// write into FIFO when read is 0
			if (push && ~full_next) begin
				mem[wrtPtr] <= data_push;
     			wrtPtr <= wrtPtr_next;
			end else if (push && pop && ~full_next) begin
				mem[wrtPtr] <= data_push;
     			wrtPtr <= wrtPtr_next;
			end
		end
		end
				
		always_ff @(posedge clk) begin
				if (~rst) begin
					rdPtr <= 0;
				end
			// READ from FIFO and pop is 1
		else begin 	
			// rdPtr <=  (pop && !empty)? rdPtr_next: rdPtr; 
				if (pop && ~empty_next) begin
				 	rdPtr <= rdPtr_next;
				end else if (push && pop && ~empty_next) begin
					rdPtr <= rdPtr_next;
				end
			end
		end

	always @( posedge clk ) begin
  		if( ~rst ) 
    		cnt <= 0;
  		else begin
    		case ({push,pop})
      			2'b00 : cnt <= cnt;
      			2'b01 : cnt <= (cnt==0) ? 0 : cnt-1; 
      			2'b10 : cnt <= (cnt==wL) ? wL : cnt+1; 
      			2'b11 : cnt <= cnt;
      			default: cnt <= cnt;
    		endcase 
  		end
	end

	always_comb begin 
		if (~rst) begin
			wrtPtr_next = 0;
			rdPtr_next = 0;	
		end
		else begin 
			wrtPtr_next = (push && ~full_next)? wrtPtr + 1 : wrtPtr;
	  		rdPtr_next = (pop && ~empty_next)? rdPtr + 1 : rdPtr;
		end		 	
	end
	
	always_ff @(posedge clk) begin
		if (~rst) begin
			almost_full <= 0;
			almost_empty <= 0;
			full <= 0;
			empty <= 1;
		end
		// READ from FIFO and pop is 1
		else begin 	
			full <= full_next;
			empty <= empty_next;
			almost_full <= almost_full_next;
			almost_empty <= almost_empty_next;
		end 
			
	end
	
endmodule