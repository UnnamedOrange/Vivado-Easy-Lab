/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>uut_enable_module</modulename>
/// <filedescription>UUT for enable module.</filedescription>
/// <dependency>
/// 	enable_module
/// </dependency>

`timescale 1ns / 1ps

module uut_enable_module();
	reg RESET;
	reg CLK;
	wire pulse;

	enable_module_t U1(.pulse(pulse), .RESET(RESET), .CLK(CLK));

    always begin : CLOCK
        #1;
        CLK = 1; #5;
        CLK = 0; #4;
    end

	initial begin : TB
		integer i;

		CLK = 0;
		RESET = 1;
		#20;
		RESET = 0;

		for (i = 0; i < U1.pulse_frequency; i = i + 1)
			#10;
	end
endmodule