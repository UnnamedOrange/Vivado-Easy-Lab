/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>display_module</modulename>
/// <filedescription>Display module.</filedescription>
/// <dependency>
/// </dependency>

module display_module_t(
	output [7:0] led_segs,
	output [3:0] led_sel,
	input [7:0] second,
	input [15:0] millisecond,
	input RESET,
	input CLK,
	input EN);

endmodule