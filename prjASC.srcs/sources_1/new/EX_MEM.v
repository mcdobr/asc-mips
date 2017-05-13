module EX_MEM(clk, wbControl, memControl, rc, jumpPC, aluResult, writeDataIn, aluZero,
wbControlOut, memControlOut, rcOut, jumpPCOut, aluResultOut, writeDataOut, aluZeroOut);
	input clk;
	input [1:0] wbControl;
	input [2:0] memControl;
	input [4:0] rc;
	input [31:0] jumpPC, aluResult, writeDataIn;
	input aluZero;
	
	output reg [1:0] wbControlOut;
	output reg [2:0] memControlOut;
	output reg [4:0] rcOut;
	output reg [31:0] jumpPCOut, aluResultOut, writeDataOut;
	output reg aluZeroOut;
	
	initial begin
		wbControlOut = 0;
		memControlOut = 0;
		rcOut = 0;
		jumpPCOut = 0;
		aluResultOut = 0;
		writeDataOut = 0;
		aluZeroOut = 0;
	end
	
	always@(posedge clk) begin
		wbControlOut <= wbControl;
		memControlOut <= memControl;
		rcOut <= rc;
		jumpPCOut <= jumpPC;
		aluResultOut <= aluResult;
		writeDataOut <= writeDataIn;
		aluZeroOut <= aluZero;
	end
	
	
endmodule