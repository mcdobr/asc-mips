module pcLogic#(parameter WIDTH = 32)(clk, pcSrc, jump, pc);

	input clk, pcSrc;
	input [WIDTH - 1 : 0] jump;
	output reg [WIDTH - 1 : 0] pc;
	
	initial begin
		pc = -4;
	end

	always@(posedge clk) begin
		if (pcSrc == 1) begin
			pc <= jump;		// Nu se va aduna 4
		end else begin
			pc <= pc + 4;
		end
	end

endmodule
