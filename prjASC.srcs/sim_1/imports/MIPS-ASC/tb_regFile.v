module tb_regFile();

	reg clk, regWrite;

	reg [4 : 0] ra, rb, rc;
	reg [31 : 0] dc;
	wire [31 : 0] da, db;

	regFile DUT(
		.clk(clk),
		.regWrite(regWrite),
		.ra(ra),
		.rb(rb),
		.rc(rc),
		.da(da),
		.db(db),
		.dc(dc)
	);

	// Setare clock
	always begin
		#5 clk = ~clk;
	end
	
	// Setare conditii initiale
	initial begin
		clk = 0;
		regWrite = 0;
		ra = 0;
		rb = 0;
		rc = 0;
		dc = 0;
	end

	// Testare minima
	initial begin
		#10
		regWrite = 1;
		rc = 12;
		dc = 32'hFFFF_FFFF;

		#20
		regWrite = 0;
		ra = 12;
		
		#50
		$stop;
	end

	initial begin
		$monitor("time %t, ra = %h, da = %h", $time, ra, da);
	end

endmodule
