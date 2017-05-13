module tb_dataMem();
	reg clk, memRead, memWrite;
	reg [9:0] address;
	reg [31:0] dataIn;
	wire [31:0] dataOut;


	dataMem DUT(.clk(clk),
		.memRead(memRead),
		.memWrite(memWrite),
		.address(address),
		.dataIn(dataIn),
		.dataOut(dataOut)
	);

	always begin
		#5 clk = ~clk;
	end

	initial begin
		clk = 0;
		memWrite = 0;
		address = 42;
		memRead = 1;
		dataIn = 32'hFFFF_FFFF;
	end


	initial begin
		#10
		memWrite = 1;

		#10
		memWrite = 0;

		#50
		$stop;
	end

	initial begin
		$monitor("time %t, address = %h, mem[%h] = %h", $time, address, address, dataOut);
	end
endmodule
