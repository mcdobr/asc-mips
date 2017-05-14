module dataMem #(parameter WIDTH = 32, parameter WORDS = 1024) (clk, memRead, memWrite, address, dataIn, dataOut);

	input clk, memRead, memWrite;
	input [WIDTH - 1 : 0] address;
	input [WIDTH - 1 : 0] dataIn;
	output [WIDTH - 1 : 0]  dataOut;

	reg [WIDTH - 1 : 0] mem [0 : WORDS - 1];

	parameter DATA_FILE = "C:/Users/Mircea/prjASC/dataSegment.hex";
	initial begin
		$readmemh(DATA_FILE, mem, 0, WORDS - 1);
	end

	// Read sincron in a doua jumatate
	
	assign dataOut = mem[address >> 2];
	
	// Write sincron in prima jumatate
	always@(posedge clk) begin
		if (memWrite == 1)
			mem[address >> 2] <= dataIn;
	end

endmodule
