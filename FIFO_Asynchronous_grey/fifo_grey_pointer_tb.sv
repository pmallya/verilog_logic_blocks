module fifo_grey_pointer_tb;

	logic [2:0] grey, bin;
	logic clk, rst, en;
	
	fifo_grey_pointer #(8) b2g
	(.grey_pointer(grey),
	.enable(en),
	.clk(clk),
	.reset(rst));
	
	initial begin
		en = 0;
		clk=0;
		rst = 0;
	end		  
	
	always #1 clk = ~clk; 
		
	initial begin
		#2 rst = 1;
		
		#1 en = 1; 
		repeat(20)
		@(posedge clk) bin = b2g.binary_count;		
		
		end
	
	endmodule