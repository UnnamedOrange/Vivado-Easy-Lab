/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>tick_module</modulename>
/// <filedescription>Tick module.</filedescription>
/// <dependency>
/// </dependency>

module tick_module_t(
	output [7:0] second,
	output [15:0] millisecond,
	output overflow,
	input work,
	input clear,
	input RESET,
	input CLK,
	input EN);

endmodule