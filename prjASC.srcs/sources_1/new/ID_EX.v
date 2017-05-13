module ID_EX(clk, wbControl, memControl, exControl, ra, rb, rc, jumpPC, dataA, dataB, imm32,
wbControlOut, memControlOut, exControlOut, raOut, rbOut, rcOut, jumpPCOut, dataAOut, dataBOut, imm32Out);

	input clk;
	input [1:0] wbControl;
	input [2:0] memControl;
	input [3:0] exControl;
	input [4:0] ra, rb, rc;
	input [31:0] jumpPC, dataA, dataB, imm32;

	output reg [1:0] wbControlOut;
	output reg [2:0] memControlOut;
	output reg [3:0] exControlOut;
	output reg [4:0] raOut, rbOut, rcOut;
	output reg [31:0] jumpPCOut, dataAOut, dataBOut, imm32Out;

	initial begin
		wbControlOut = 0;
		memControlOut = 0;
		exControlOut = 0;
		raOut = 0;
		rbOut = 0;
		rcOut = 0;
		jumpPCOut = 0;
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
		jumpPCOut = jumpPC;
		dataAOut <= dataA;
		dataBOut <= dataB;
		imm32Out <= imm32;
	end

endmodule