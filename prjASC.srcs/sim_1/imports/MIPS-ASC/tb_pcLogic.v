module tb_pcLogic();

	reg clk, pcSrc;
	reg [31:0] offset;
	wire [31:0] pc;

	pcLogic DUT(.clk(clk),
		.pcSrc(pcSrc),
		.offset(offset),
		.pc(pc)
	);

	always begin
		#5 clk = ~clk;
	end

	initial begin
		clk = 0;
		pcSrc = 0;
		offset = 64;

		#100
		pcSrc = 1;

		#10
		pcSrc = 0;

		#10000
		$stop;
	end



	initial begin
		$monitor("time %t, pc = %h", $time, pc);
	end

endmodule
