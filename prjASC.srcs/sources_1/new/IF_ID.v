module IF_ID #(parameter WIDTH = 32)(clk, IF_IDwrite, IF_IDflush, instruction, instructionOut);
	
	input clk, IF_IDwrite, IF_IDflush;
	input [WIDTH - 1 : 0] instruction;
	output reg [WIDTH - 1 : 0] instructionOut;

	initial begin
		instructionOut = 0;
	end

	always@(posedge clk) begin
		if (IF_IDflush == 1) begin
			instructionOut <= 0;
		end else if (IF_IDwrite == 1) begin
			instructionOut <= instruction;
		end
	end
endmodule