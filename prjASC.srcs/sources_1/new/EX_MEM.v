module EX_MEM(clk, wbControl, memControl, rc, imm32, aluResult, writeDataIn, aluZero,
wbControlOut, memControlOut, rcOut, imm32Out, aluResultOut, writeDataOut, aluZeroOut);
	input clk;
	input [1:0] wbControl;
	input [2:0] memControl;
	input [4:0] rc;
	input [31:0] imm32, aluResult, writeDataIn;
	input aluZero;
	
	output reg [1:0] wbControlOut;
	output reg [2:0] memControlOut;
	output reg [4:0] rcOut;
	output reg [31:0] imm32Out, aluResultOut, writeDataOut;
	output reg aluZeroOut;
	
	initial begin
		wbControlOut = 0;
		memControlOut = 0;
		rcOut = 0;
		imm32Out = 0;
		aluResultOut = 0;
		writeDataOut = 0;
		aluZeroOut = 0;
	end
	
	always@(posedge clk) begin
		wbControlOut <= wbControl;
		memControlOut <= memControl;
		rcOut <= rc;
		imm32Out <= imm32;
		aluResultOut <= aluResult;
		writeDataOut <= writeDataIn;
		aluZeroOut <= aluZero;
	end
	
	
endmodule