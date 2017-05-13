module tb_iMem();

	reg [31 : 0] mem [0 : 255];
	reg [31 : 0] readAddr;
	wire [31 : 0] instruction;


	iMem DUT(
		.readAddr(readAddr),
		.instruction(instruction)
	);

	initial begin
		readAddr = 0;

		#20
		readAddr = 1;

		#20
		readAddr = 2;

		#20
		readAddr = 5;

		#50
		$finish;
	end

	initial begin
		$monitor("time %t, readAddr = %h, instruction = %h", $time, readAddr, instruction);
	end

endmodule
