/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>enable_module</modulename>
/// <filedescription>Enable module.</filedescription>
/// <dependency>
/// </dependency>

module enable_module_t(
	output pulse,
	input RESET,
	input CLK);

	parameter pulse_frequency = 100; // 10 ms by default.
	parameter CLK_frequency = 100000000; // Assuming CLK is 100 MHz.
	localparam count_to = CLK_frequency / pulse_frequency;

	integer counter;

	always @(posedge CLK) begin
		if (RESET)
			counter <= 0;
		else begin
			if (counter + 1 < count_to)
				counter <= counter + 1;
			else
				counter <= 0;
		end
	end

	assign pulse = counter == 0;
endmodule