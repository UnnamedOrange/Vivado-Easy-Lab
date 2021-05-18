/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>uut_tick_module</modulename>
/// <filedescription>UUT for tick_module.</filedescription>
/// <dependency>
/// 	tick_module
/// </dependency>

`timescale 1ns / 1ps

module uut_tick_module();
	reg RESET;
	reg CLK;
	reg EN;
	reg work;
	reg clear;
	wire [7:0] second;
	wire [15:0] millisecond;
	wire overflow;

	tick_module_t U1(.second(second), .millisecond(millisecond), .overflow(overflow), .work(work), .clear(clear), .RESET(RESET), .CLK(CLK), .EN(EN));

	always begin : CLOCK
		#1;
		CLK = 1; EN = 1; #5;
		CLK = 0; EN = 0; #4;
	end

	initial begin : TB
		integer i;

		CLK = 0;
		EN = 0;
		work = 0;
		clear = 0;
		RESET = 1;
		#20;
		RESET = 0;

		#50;
		work = 1;
		#700000;
		work = 0;
		#100;
		clear = 1;
		#10;
		clear = 0;
		$stop(1);
	end
endmodule