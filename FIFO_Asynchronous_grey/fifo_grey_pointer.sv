module fifo_grey_pointer #(parameter FIFO_DEPTH=8)
	(output logic [$clog2(FIFO_DEPTH)-1:0] grey_pointer,
	input enable,
	input clk,
	input reset); 
	
	logic [$clog2(FIFO_DEPTH)-1:0] binary_count;

	always@(posedge clk) begin: generatePointer
		if(~reset) begin
			grey_pointer <= 1;
			binary_count <= 0;
		end
	else begin 
		if(enable) begin
			binary_count <= binary_count + 'd1;
			grey_pointer <= {binary_count[$clog2(FIFO_DEPTH)-1] , binary_count[$clog2(FIFO_DEPTH)-2:0] ^ binary_count[$clog2(FIFO_DEPTH)-2:1]};
			end
		else 
			grey_pointer <= grey_pointer;
		end	  
	end
		
	endmodule