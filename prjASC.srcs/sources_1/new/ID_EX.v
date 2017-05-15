module ID_EX(clk, wbControl, memControl, exControl, ra, rb, rc, opcode, dataA, dataB, imm32,
wbControlOut, memControlOut, exControlOut, raOut, rbOut, rcOut, opcodeOut, dataAOut, dataBOut, imm32Out);

	input clk;
	input [1:0] wbControl;
	input [2:0] memControl;
	input [3:0] exControl;
	input [4:0] ra, rb, rc;
	input [5:0] opcode;
	input [31:0] dataA, dataB, imm32;

	output reg [1:0] wbControlOut;
	output reg [2:0] memControlOut;
	output reg [3:0] exControlOut;
	output reg [4:0] raOut, rbOut, rcOut;
	output reg [5:0] opcodeOut;
	output reg [31:0] dataAOut, dataBOut, imm32Out;

	initial begin
		wbControlOut = 0;
		memControlOut = 0;
		exControlOut = 0;
		raOut = 0;
		rbOut = 0;
		rcOut = 0;
		opcodeOut = 0;
		dataAOut = 0;
		dataBOut = 0;
		imm32Out = 0;
	end

	always@(posedge clk) begin
		wbControlOut <= wbControl;
		memControlOut <= memControl;
		exControlOut <= exControl;
		raOut <= ra;
		rbOut <= rb;
		rcOut <= rc;
		dataAOut <= dataA;
		dataBOut <= dataB;
		imm32Out <= imm32;
		opcodeOut <= opcode;
	end

endmodule