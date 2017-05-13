module MEM_WB(clk, wbControl, rc, aluResult, memResult, wbControlOut, rcOut, aluResultOut, memResultOut);
	input clk;
	input [1:0] wbControl;
	input [4:0] rc;
	input [31:0] aluResult, memResult;
	
	output reg [1:0] wbControlOut;
	output reg [4:0] rcOut;
	output reg [31:0] aluResultOut, memResultOut;
	
	always@(posedge clk) begin
		wbControlOut <= wbControl;
		rcOut <= rc;
		aluResultOut <= aluResult;
		memResultOut <= memResult;
	end
	
endmodule