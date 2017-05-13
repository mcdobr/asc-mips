module alu #(parameter WIDTH = 32) (opA, opB, aluOp, funct, aluResult, aluZero);
	// I/O stuff
	input [WIDTH - 1 : 0]	opA, opB;
	input [1 : 0]			aluOp;
	input [5 : 0]			funct;


	output reg [WIDTH - 1 : 0]	aluResult;
	output						aluZero;

	// Internal
	parameter aluAdd = 0;
	parameter aluSub = 1;
	parameter aluAnd = 2;
	parameter aluOr	 = 3;
	parameter aluNor = 4;
	parameter aluXor = 5;
	parameter aluSlt = 6;

	reg [3 : 0]				aluCode;

	// ALU logic
	
	// Determine operation to be done by alu
	always@(aluOp or funct) begin
		casex ({aluOp, funct})
			8'b00_xxxxxx:	aluCode = aluAdd;
			8'b01_xxxxxx:	aluCode = aluSub;
			8'b10_100000:	aluCode = aluAdd;
			8'b10_100010:	aluCode = aluSub;
			8'b10_100100:	aluCode = aluAnd;
			8'b10_100101:	aluCode = aluOr;
			8'b10_101010:	aluCode = aluSlt;
		endcase
	end

	// Do the actual operation
	always@(aluCode or opA or opB) begin
		case (aluCode)
			aluAdd:	aluResult = opA + opB;
			aluSub:	aluResult = opA - opB;
			aluAnd: aluResult = opA & opB;
			aluOr:	aluResult = opA | opB;
			aluNor:	aluResult = ~(opA | opB);
			aluSlt: aluResult = (opA < opB) ? 1 : 0;
			default:aluResult = 0;
		endcase
	end

	assign aluZero = (aluResult == 0);
endmodule
