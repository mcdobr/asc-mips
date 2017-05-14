module ForwardingUnit(EX_MEMregWrite, MEM_WBregWrite, EX_MEMrc, MEM_WBrc, ID_EXra, ID_EXrb, forwardA, forwardB);
	input EX_MEMregWrite, MEM_WBregWrite;
	input [4:0] EX_MEMrc, MEM_WBrc, ID_EXra, ID_EXrb;
	output reg [1:0] forwardA, forwardB;

	// Forward A
	always@(EX_MEMregWrite or MEM_WBregWrite or EX_MEMrc or MEM_WBrc or ID_EXra or ID_EXrb) begin
		if (MEM_WBregWrite == 1 && MEM_WBrc != 0 && MEM_WBrc == ID_EXra /*&& 
		!(EX_MEMregWrite == 1 && EX_MEMrc != 0 && EX_MEMrc != ID_EXra)*/) begin
			forwardA = 2'b01;
		end else if (EX_MEMregWrite == 1 && EX_MEMrc != 0 && EX_MEMrc == ID_EXra) begin
			forwardA = 2'b10;
		end else begin
			forwardA = 2'b00;
		end
	end
	
	// Forward B
	always@(EX_MEMregWrite or MEM_WBregWrite or EX_MEMrc or MEM_WBrc or ID_EXrb) begin
		if (MEM_WBregWrite == 1 && MEM_WBrc != 0 && MEM_WBrc == ID_EXrb/*&& 
			!(EX_MEMregWrite == 1 && EX_MEMrc != 0 && EX_MEMrc != ID_EXrb)*/) begin
			forwardB = 2'b01;
		end else if (EX_MEMregWrite == 1 && EX_MEMrc != 0 && EX_MEMrc == ID_EXrb) begin
			forwardB = 2'b10;
		end else begin
			forwardB = 2'b00;
		end
	end
endmodule