/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>uut_system_controller</modulename>
/// <filedescription>UUT for system_controller.</filedescription>
/// <dependency>
/// 	system_controller
/// </dependency>

`timescale 1ns / 1ps

module uut_system_controller();
	reg RESET;
	reg CLK;
	reg EN;
	reg button;
	wire work;
	wire clear;

	system_controller_t U1(.work(work), .clear(clear), .button(button), .RESET(RESET), .CLK(CLK), .EN(EN));

	always begin : CLOCK
		#1;
		CLK = 1; #5;
		CLK = 0; #4;
	end

	initial begin : TB
		integer i;

		CLK = 0;
		EN = 0;
		button = 0;
		RESET = 1;
		#20;
		RESET = 0;

		#50;
		button = 1;
		for (i = 0; i < 10; i = i + 1) begin
			EN = 1;
			#20;
			EN = 0;
			#10;
		end
		button = 0;
		for (i = 0; i < 10; i = i + 1) begin
			EN = 1;
			#20;
			EN = 0;
			#10;
		end

		#50;
		button = 1;
		for (i = 0; i < 10; i = i + 1) begin
			EN = 1;
			#20;
			EN = 0;
			#10;
		end
		button = 0;
		for (i = 0; i < 10; i = i + 1) begin
			EN = 1;
			#20;
			EN = 0;
			#10;
		end

		#50;
		button = 1;
		for (i = 0; i < 10; i = i + 1) begin
			EN = 1;
			#20;
			EN = 0;
			#10;
		end
		button = 0;
		for (i = 0; i < 10; i = i + 1) begin
			EN = 1;
			#20;
			EN = 0;
			#10;
		end
		$stop(1);
	end
endmodule