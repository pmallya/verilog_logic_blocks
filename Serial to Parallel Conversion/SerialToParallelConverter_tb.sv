`timescale 1 ns/1 ps
module SerialToParallelConverter_tb;
	
	logic [7:0] parallelDataOut, tempParallelHolder;
	logic [3:0] count;
	logic grant;
	logic serialDataIn;
	logic clk;
	logic reset;
	
	SerialToParallelConverter #(8)S2P(
	.parallelDataOut(parallelDataOut), 
	.grant(grant),
	.serialDataIn(serialDataIn), 
	.clk(clk),
	.reset(reset));

	initial begin 
		clk = 0;
		reset = 0;
		serialDataIn = 0;
	end
	
	always clk = #1 ~clk;		
	
	initial begin 
		
		#2 reset = 1;
				
		repeat(32) begin
		@(posedge clk) serialDataIn = $random;
		#2 serialDataIn = $random;
		tempParallelHolder = S2P.tempParallelHolder;
		count = S2P.count;
		end
	end
	
endmodule	