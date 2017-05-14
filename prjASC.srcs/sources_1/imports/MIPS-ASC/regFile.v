module regFile #(parameter WIDTH = 32) (clk, regWrite, ra, rb, rc, da, db, dc);
	
	input clk, regWrite;
	input [4:0] ra, rb, rc;
	input [31:0] dc;

	output reg [31:0] da, db;

	reg [WIDTH - 1 : 0] mem [0 : WIDTH - 1];

	
	initial begin
		mem[0] = 0;
	end
	
	/*
	parameter DATA_FILE = "C:/Users/Mircea/prjASC/regFile.hex";
	initial begin
		$readmemh(DATA_FILE, mem, 0, WIDTH - 1);
	end
	*/

	
	always@* begin
		if (regWrite == 1 && rc == ra) begin
			da = dc;
		end else begin
			da = mem[ra];
		end
	end
	
	always@* begin
		if (regWrite == 1 && rc == rb) begin
			db = dc;
		end else begin
			db = mem[rb];
		end
	end
	
	// Scriere sincrona
	always@(posedge clk) begin
		if (regWrite == 1'b1)
			mem[rc] <= dc;
	end

	/*
	// Citire sincrona pe frontul negativ (adica in a doua jumatate)
	always@(negedge clk) begin
		da <= mem[ra];
		db <= mem[rb];
	end
	*/

	/*
	// Citire asincrona
	always@(*) begin
		da = mem[ra];
	end

	always@(*) begin
		db = mem[rb];
	end
	*/
endmodule
