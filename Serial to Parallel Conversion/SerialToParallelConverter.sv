module SerialToParallelConverter #(parameter DATA_WIDTH = 8)(
	output logic[DATA_WIDTH-1:0] parallelDataOut, 
	output logic grant,
	input serialDataIn, 
	input clk,
	input reset);
  
  logic [DATA_WIDTH-1:0] tempParallelHolder;
  logic [$clog2(DATA_WIDTH):0] count;
  
  int i;
    
  always@(posedge clk or negedge reset)
    begin
      if(~reset)
        begin
          parallelDataOut <= 0;
          tempParallelHolder <= 0;
          grant <= 1;      
		  count <= 0;
        end
      else	 
		  begin	  
			  tempParallelHolder <= {serialDataIn, tempParallelHolder[DATA_WIDTH-1:1]};
			  count <= count + 1;
			  if(count == 8) begin
				  grant <= 1;
				  count <= 1;
				  parallelDataOut <= tempParallelHolder;
			  end
			  else 
				  grant <= 0;
				  
        end
    end
        
endmodule