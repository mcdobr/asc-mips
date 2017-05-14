module cpu(clk);
	input clk;

	// Internal state
	reg aluSrc, memRead, memWrite, memToReg, regDst, regWrite, branch;
	reg [1:0] aluOp;

	// Opcodes
	parameter RTYPE = 6'b000000;
	parameter LW	= 6'b100011;
	parameter SW	= 6'b101011;
	parameter BEQ	= 6'b000100;
	
	// IF wires
	wire [31:0] pcIF, instructionIF;
	
	// ID wires
	wire [5:0] opcodeID, functID;
	wire [4:0] raID, rbID, rcID, shamtID;
	wire [15:0] imm16ID;
	wire [31:0] daID, dbID, instructionID, jumpPCID, imm32ID;	
	
	// EX wires
	wire [1:0] wbControlEX;
	wire [2:0] memControlEX;
	wire [3:0] exControlEX;
	wire [4:0] raEX, rbEX, rcEX;
	wire [31:0] daEX, dbEX, imm32EX, jumpPCEX, aluResultEX;
	wire aluZeroEX;
		
	// MEM wires
	wire aluZeroMEM;
	wire [1:0] wbControlMEM;
	wire [2:0] memControlMEM;
	wire [4:0] rcMEM;
	wire [31:0] jumpPCMEM, aluResultMEM, writeDataMEM, dOutMEM;
	
	// WB wires	
	wire [1:0] wbControlWB;
	wire [4:0] rcWB;
	wire [31:0] aluResultWB, memResultWB, dcWB;	
	
	// Hazard unit wires
	wire PCwrite, IF_IDwrite, controlMuxSel;
	
	/*
	 * Instruction fetch
	 */
	pcLogic pcComp(
		.clk(clk),
		.pcWrite(PCwrite),
		.pcSrc(aluZeroMEM & memControlMEM[2]),
		.jump(jumpPCMEM),
		.pc(pcIF)
	);
	
	iMem iMemComp(
		.readAddr(pcIF),
		.instruction(instructionIF)
	);
	
	IF_ID IF_IDcomp(
		.clk(clk),
		.IF_IDwrite(IF_IDwrite),
		.jumpPC(pcIF),	// Fara +4 din cauza neconcordantei QtSpim/ H&P
		.instruction(instructionIF),
		.jumpPCOut(jumpPCID),
		.instructionOut(instructionID)
	);
	
	/*
	 * Instruction decode
	 */
	assign opcodeID = instructionID[31:26];
	assign raID = instructionID[25:21];
	assign rbID = instructionID[20:16];
	assign rcID = instructionID[15:11];
	assign shamtID = instructionID[10:6];	
	assign functID = instructionID[5:0];	 	
	// Immediate values (32-bit one is sign extended)
	assign imm16ID = instructionID[15:0];
	assign imm32ID = {{16{imm16ID[15]}}, imm16ID};
	 
	regFile regComp(
		.clk(clk),
		.regWrite(wbControlWB[1]),
		.ra(raID),
		.rb(rbID),
		.rc(rcWB),
		.da(daID),
		.db(dbID),
		.dc(dcWB)
	);
	
	HazardDetectionUnit hazComp(
		.ID_EXmemRead(memControlEX[1]),
		.IF_IDra(raID),
		.IF_IDrb(rbID),
		.ID_EXrb(rbEX),
		.PCwrite(PCwrite),
		.IF_IDwrite(IF_IDwrite),
		.controlMuxSel(controlMuxSel)
	);
	
	ID_EX ID_EXcomp(
		.clk(clk),
		.wbControl((controlMuxSel == 1) ? 2'b00 : {regWrite, memToReg}),
		.memControl((controlMuxSel == 1) ? 3'b000 : {branch, memRead, memWrite}),
		.exControl((controlMuxSel == 1) ? 4'b0000 : {regDst, aluOp, aluSrc}),
		.ra(raID),
		.rb(rbID),
		.rc(rcID),
		.jumpPC(jumpPCID),
		.dataA(daID),
		.dataB(dbID),
		.imm32(imm32ID),
		// Outputs
		.wbControlOut(wbControlEX),
		.memControlOut(memControlEX),
		.exControlOut(exControlEX),
		.raOut(raEX),
		.rbOut(rbEX),
		.rcOut(rcEX),
		.jumpPCOut(jumpPCEX),
		.dataAOut(daEX),
		.dataBOut(dbEX),
		.imm32Out(imm32EX)
	);
	
	/*
	 * Execute
	 */
	
	wire [1:0] forwardA, forwardB;
	wire [31:0] forwardedDA, forwardedDB;
	
	// dataA, dataB considering possible forwarding
	ForwardingUnit forwardUnitComp(
		.EX_MEMregWrite(wbControlMEM[1]),
		.MEM_WBregWrite(wbControlWB[1]),
		.EX_MEMrc(rcMEM),
		.MEM_WBrc(rcWB),
		.ID_EXra(raEX),
		.ID_EXrb(rbEX),
		.forwardA(forwardA),
		.forwardB(forwardB)
	);
	
	// Cele doua muxuri
	assign forwardedDA = (forwardA == 2'b00) ? daEX :
						 (forwardA == 2'b01) ? dcWB :
						 aluResultMEM;
	
	assign forwardedDB = (forwardB == 2'b00) ? dbEX :
						 (forwardB == 2'b01) ? dcWB :
						 aluResultMEM;
						 	
	alu aluComp(
		.opA(forwardedDA),										// daEX in trecut
		.opB((exControlEX[0] == 1) ? imm32EX : forwardedDB),	// (aluSrc == 1) ? imm32 : db .... dbEX in trecut
		.aluOp(exControlEX[2:1]),								// aluOp
		.funct(imm32EX[5:0]),									// funct
		.aluResult(aluResultEX),
		.aluZero(aluZeroEX)
	);
	
	EX_MEM EX_MEMcomp(
		.clk(clk),
		.wbControl(wbControlEX),
		.memControl(memControlEX),
		.rc(exControlEX[3] == 1 ? rcEX : rbEX),		// (regDst == 1) ? rc : rb
		.jumpPC(jumpPCEX + imm32EX << 2),				// PC + (imm32 << 2)
		.aluResult(aluResultEX),
		.writeDataIn(dbEX),
		.aluZero(aluZeroEX),
		// Outputs
		.wbControlOut(wbControlMEM),
		.memControlOut(memControlMEM),
		.rcOut(rcMEM),
		.jumpPCOut(jumpPCMEM),
		.aluResultOut(aluResultMEM),
		.writeDataOut(writeDataMEM),
		.aluZeroOut(aluZeroMEM)
	);
	
	/* 
	 * Memory access
	 */
	dataMem dMemComp(
		.clk(clk),
		.memRead(memControlMEM[1]),
		.memWrite(memControlMEM[0]),
		.address(aluResultMEM),
		.dataIn(writeDataMEM),
		.dataOut(dOutMEM)
	);
	
	MEM_WB MEM_WBcomp(
		.clk(clk),
		.wbControl(wbControlMEM),
		.rc(rcMEM),
		.aluResult(aluResultMEM),
		.memResult(dOutMEM),
		// Outputs
		.wbControlOut(wbControlWB),
		.rcOut(rcWB),
		.aluResultOut(aluResultWB),
		.memResultOut(memResultWB)
		);
	 
	/* 
	 * Write Back
	 */
	assign dcWB = (wbControlWB[0] == 1) ? memResultWB : aluResultWB;	

	// Control behavior
	always@(opcodeID) begin
		casex (opcodeID)
			RTYPE:	{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'b100100010;
			LW:		{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'b011110000;
			SW:		{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'bx1x001000;
			BEQ:	{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'bx0x000101;
			default:{regDst, aluSrc, memToReg, regWrite, memRead, memWrite, branch, aluOp} = 9'b000000000;
		endcase
	end
endmodule
