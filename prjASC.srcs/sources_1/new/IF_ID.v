module IF_ID #(parameter WIDTH = 32)(clk, IF_IDwrite, jumpPC, instruction, jumpPCOut, instructionOut);
	
	input clk, IF_IDwrite;
	input [WIDTH - 1 : 0] jumpPC, instruction;
	output reg [WIDTH - 1 : 0] jumpPCOut, instructionOut;

	initial begin
		jumpPCOut = 0;
		instructionOut = 0;
	end

	always@(posedge clk) begin
		if (IF_IDwrite == 1) begin
			jumpPCOut <= jumpPC;
			instructionOut <= instruction;
		end
	end
endmodule