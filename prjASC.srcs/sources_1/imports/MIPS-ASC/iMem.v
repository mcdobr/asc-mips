module iMem #(parameter WIDTH = 32, parameter WORDS = 256)(readAddr, waitForBranch, instruction);

	input [WIDTH - 1 : 0] readAddr;
	input waitForBranch;
	output reg [WIDTH - 1 : 0] instruction;

	reg [WIDTH - 1 : 0] mem [0 : WORDS - 1];


	parameter IM_FILE = "C:/Users/Mircea/prjASC/codeSegment.hex";
	initial begin
		$readmemh(IM_FILE, mem, 0, WORDS - 1);
	end
	
	always@(*) begin
		if (waitForBranch == 1) begin
			instruction = 0;
		end else begin
			instruction = mem[readAddr >> 2];
		end
	end

endmodule
