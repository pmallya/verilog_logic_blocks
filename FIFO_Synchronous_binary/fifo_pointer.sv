module fifo_pointer #(parameter FIFO_DEPTH=8)
	(output logic [$clog2(FIFO_DEPTH)-1:0] pointer,
	input enable,
	input clk,
	input reset); 
	
	always@(posedge clk) begin: generatePointer
		if(~reset)
			pointer = 0;
		else if(enable)
			pointer = pointer + 'd1;
		else 
			pointer = pointer;
		end
		
	endmodule