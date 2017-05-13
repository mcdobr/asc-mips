module tb_alu();

	reg [31 : 0] opA = 32, opB = 15;
	reg [1 : 0]	aluOp = 2'b10;
	reg [5 : 0] funct = 6'b100000;

	wire [31 : 0] aluResult;
	wire aluZero;
	
	initial begin
		#15 funct = 6'b100010;
		#15 funct = 6'b100100;
		#15 funct = 6'b100101;
		#15 funct = 6'b101010;

		#100
		$stop;
	end

	alu DUT(.opA(opA),
			.opB(opB),
			.aluOp(aluOp),
			.funct(funct),
			.aluResult(aluResult),
			.aluZero(aluZero)
	);

	initial
		$monitor("time %t, aluResult = %h (%0d)", $time, aluResult, aluResult);

endmodule
