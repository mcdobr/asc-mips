module ID_EX(clk, wbControl, memControl, exControl, ra, rb, rc, dataA, dataB, imm32,
wbControlOut, memControlOut, exControlOut, raOut, rbOut, rcOut, dataAOut, dataBOut, imm32Out);

	input clk;
	input [1:0] wbControl;
	input [2:0] memControl;
	input [3:0] exControl;
	input [4:0] ra, rb, rc;
	input [31:0] dataA, dataB, imm32;

	output reg [1:0] wbControlOut;
	output reg [2:0] memControlOut;
	output reg [3:0] exControlOut;
	output reg [4:0] raOut, rbOut, rcOut;
	output reg [31:0] dataAOut, dataBOut, imm32Out;

	always@(posedge clk) begin
		wbControlOut <= wbControl;
		memControlOut <= memControlOut;
		exControlOut <= exControlOut;
		raOut <= ra;
		rbOut <= rb;
		rcOut <= rc;
		dataAOut <= dataA;
		dataBOut <= dataB;
		imm32Out <= imm32;
	end

endmodule