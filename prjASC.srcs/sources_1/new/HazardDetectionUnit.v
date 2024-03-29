module HazardDetectionUnit(ID_EXmemRead, waitForBranch, IF_IDra, IF_IDrb, ID_EXrb, PCwrite, IF_IDwrite, controlMuxSel, noop);
	input ID_EXmemRead, waitForBranch;
	input [4:0] IF_IDra, IF_IDrb, ID_EXrb;
	output reg PCwrite, IF_IDwrite, controlMuxSel, noop;
	
	initial begin
		PCwrite = 1;
		IF_IDwrite = 1;
		controlMuxSel = 0;
		noop = 0;
	end
	
	
	always@(*) begin
		if (waitForBranch == 1) begin
			PCwrite = 0;
			IF_IDwrite = 1;
			controlMuxSel = 0;
		end else if (ID_EXmemRead == 1 && (ID_EXrb == IF_IDra || ID_EXrb == IF_IDrb)) begin	// stall
			PCwrite = 0;
			IF_IDwrite = 0;
			controlMuxSel = 1;
		end else begin	//no stall
			PCwrite = 1;
			IF_IDwrite = 1;
			controlMuxSel = 0;
		end
	end
endmodule