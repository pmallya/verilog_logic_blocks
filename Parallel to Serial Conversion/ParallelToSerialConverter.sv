																								   // Code your design here
module ParallelToSerialConverter(clk, reset, request, parallelDataIn, grant, serialDataOut);
  parameter DATA_WIDTH = 8;
  
  input logic clk;
  input logic reset;
  input logic request;
  output logic grant;
  
  input logic [DATA_WIDTH-1 : 0] parallelDataIn;
  output logic serialDataOut;
  
  logic [DATA_WIDTH-1:0] tempParallelHolder;
  
  always@(posedge clk)
    begin
      if(~reset)
        begin
          serialDataOut <= 0;
          tempParallelHolder <= 0;
          grant <= 1;      
        end
      else if (request)	 
		  begin
			  tempParallelHolder <= parallelDataIn;
			  grant <= 0;
		  end
      else 
        begin
          serialDataOut <= tempParallelHolder[DATA_WIDTH-1];
          tempParallelHolder <= (tempParallelHolder << 1);
		  if(~(|tempParallelHolder))
			  grant <= 1;
        end
    end
        
endmodule