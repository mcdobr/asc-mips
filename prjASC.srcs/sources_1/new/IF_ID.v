module IF_ID #(parameter WIDTH = 32)(clk, pc_plus4, instruction, pc_plus4Out, instructionOut);
	
	input clk;
	input [WIDTH - 1 : 0] pc_plus4, instruction;
	output reg [WIDTH - 1 : 0] pc_plus4Out, instructionOut;

	always@(posedge clk) begin
		pc_plus4Out <= pc_plus4;
		instructionOut <= instruction;
	end
endmodule