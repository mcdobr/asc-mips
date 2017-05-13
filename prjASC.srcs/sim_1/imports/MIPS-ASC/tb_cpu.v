module tb_cpu();
	
	reg clk;

	cpu DUT(.clk(clk));

	always begin
		#2 clk = ~clk;
	end

	initial begin
		clk = 0;
		
		
		
		#2000
		$finish;
	end
endmodule
