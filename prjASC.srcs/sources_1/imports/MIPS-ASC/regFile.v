module regFile #(parameter WIDTH = 32) (clk, regWrite, ra, rb, rc, da, db, dc);
	
	input clk, regWrite;
	input [4:0] ra, rb, rc;
	input [31:0] dc;

	output reg [31:0] da, db;

	reg [WIDTH - 1 : 0] mem [0 : WIDTH - 1];

	/*
	initial begin
		mem[0] = 0;
	end*/
	
	parameter DATA_FILE = "C:/Users/Mircea/prjASC/regFile.hex";
	initial begin
		$readmemh(DATA_FILE, mem, 0, WIDTH - 1);
	end
	

	// Scriere sincrona
	always@(posedge clk) begin
		if (regWrite == 1'b1)
			mem[rc] <= dc;
	end

	// Citire asincrona
	always@(ra) begin
		da = mem[ra];
	end

	always@(rb) begin
		db = mem[rb];
	end

endmodule
