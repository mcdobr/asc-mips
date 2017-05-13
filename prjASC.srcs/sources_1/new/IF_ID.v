module IF_ID #(parameter WIDTH = 32)(clk, jumpPC, instruction, jumpPCOut, instructionOut);
	
	input clk;
	input [WIDTH - 1 : 0] jumpPC, instruction;
	output reg [WIDTH - 1 : 0] jumpPCOut, instructionOut;

	initial begin
		jumpPCOut = 0;
		instructionOut = 0;
	end

	always@(posedge clk) begin
		jumpPCOut <= jumpPC;
		instructionOut <= instruction;
	end
endmodule