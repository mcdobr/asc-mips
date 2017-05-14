module HazardDetectionUnit(ID_EXmemRead, IF_IDra, IF_IDrb, ID_EXrb, PCwrite, IF_IDwrite, controlMuxSel);
	input ID_EXmemRead;
	input [4:0] IF_IDra, IF_IDrb, ID_EXrb;
	output reg PCwrite, IF_IDwrite, controlMuxSel;
	
	initial begin
		PCwrite = 1;
		IF_IDwrite = 1;
		controlMuxSel = 0;
	end
	
	
	always@(*) begin
		if (ID_EXmemRead == 1 && (ID_EXrb == IF_IDra || ID_EXrb == IF_IDrb)) begin	// stall
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