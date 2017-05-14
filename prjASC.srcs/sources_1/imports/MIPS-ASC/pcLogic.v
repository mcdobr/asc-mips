module pcLogic#(parameter WIDTH = 32)(clk, pcSrc, pcWrite, jump, pc);

	input clk, pcSrc, pcWrite;
	input [WIDTH - 1 : 0] jump;
	output reg [WIDTH - 1 : 0] pc;
	
	initial begin
		pc = -4;
	end

	always@(posedge clk) begin
		if (pcWrite == 1) begin
			if (pcSrc == 1) begin
				pc <= jump;		// Nu se va aduna 4
			end else begin
				pc <= pc + 4;
			end
		end
	end

endmodule
