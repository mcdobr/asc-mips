module cpu #(parameter WIDTH = 32)(clk);

	input clk;

	// Internal state
	reg aluSrc, memRead, memWrite, memToReg, regDst, regWrite, branch;
	reg [1:0] aluOp;


	// Glue
	wire [5:0] opcode, funct;
	wire [4:0] ra, rb, rc, shamt;
	wire [WIDTH - 1 : 0] pc, instruction;
	wire [WIDTH - 1 : 0] da, db, dc;
	wire [WIDTH -1 : 0] dMemOut;

	wire [WIDTH / 2 - 1: 0] imm16;
	wire [WIDTH - 1 : 0] imm32;


	// Alu stuff
	wire [WIDTH - 1 : 0] aluResult;
	wire aluZero;

	// Opcodes
	parameter RTYPE = 6'b000000;
	parameter LW	= 6'b100011;
	parameter SW	= 6'b101011;
	parameter BEQ	= 6'b000100;

	alu aluComp(
		.opA(da),
		.opB((aluSrc == 1) ? imm32 : db),		// Trebuie adauat un mux
		.aluOp(aluOp),
		.funct(funct),
		.aluResult(aluResult),
		.aluZero(aluZero)
	);

	dataMem dMemComp(
		.clk(clk),
		.memRead(memRead),
		.memWrite(memWrite),
		.address(aluResult),
		.dataIn(db),			// ?
		.dataOut(dMemOut)
	);
	
	iMem iMemComp(
		.readAddr(pc),
		.instruction(instruction)
	);
	
	pcLogic pcComp(
		.clk(clk),
		.pcSrc(aluZero & branch),
		.offset(imm32),
		.pc(pc)
	);
	regFile regComp(
		.clk(clk),
		.regWrite(regWrite),
		.ra(ra),
		.rb(rb),
		.rc((regDst == 1) ? rc : rb),
		.da(da),
		.db(db),
		.dc(dc)
	);

	assign opcode = instruction[31:26];
	assign ra = instruction[25:21];
	assign rb = instruction[20:16];
	assign rc = instruction[15:11];
	assign shamt = instruction[10:6];	
	assign funct = instruction[5:0];

	// Immediate values (32-bit one is sign extended)
	assign imm16 = instruction[15:0];
	assign imm32 = {{16{imm16[15]}}, imm16};


	assign dc = (memToReg == 1) ? dMemOut : aluResult;

	// Control behavior
	always@(opcode) begin
		casex (opcode)
			RTYPE:	{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'b100100010;
			LW:		{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'b011110000;
			SW:		{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'bx1x001000;
			BEQ:	{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'bx0x000101;
			default:{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'b000000000;
		endcase
	end
endmodule
