module pcLogic#(parameter WIDTH = 32)(clk, pcSrc, offset, pc);

	input clk, pcSrc;
	input [WIDTH - 1 : 0] offset;
	output reg [WIDTH - 1 : 0] pc;
	
	initial begin
		pc = -4;
	end

	always@(posedge clk) begin
		if (pcSrc == 1) begin
			pc <= pc + /*4 +*/ (offset << 2);	// Fiindca asa face beq in qtSpim
		end else begin
			pc <= pc + 4;
		end
	end

endmodule
