module EX_MEM(clk, wbControl, memControl, rc, aluResult, writeDataIn, aluZero,
wbControlOut, memControlOut, rcOut, aluResultOut, writeDataOut, aluZeroOut);
	input clk;
	input [1:0] wbControl;
	input [2:0] memControl;
	input [4:0] rc;
	input [31:0] aluResult, writeDataIn;
	input aluZero;
	
	output reg [1:0] wbControlOut;
	output reg [2:0] memControlOut;
	output reg [4:0] rcOut;
	output reg [31:0] aluResultOut, writeDataOut;
	output reg aluZeroOut;
	
	always@(posedge clk) begin
		wbControlOut <= wbControl;
		memControlOut <= memControl;
		rcOut <= rc;
		aluResultOut <= aluResult;
		writeDataOut <= writeDataIn;
		aluZeroOut <= aluZero;
	end
	
	
endmodule