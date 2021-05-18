/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>tick_module</modulename>
/// <filedescription>Tick module.</filedescription>
/// <dependency>
/// </dependency>

module tick_module_t(
	output reg [7:0] second,
	output reg [15:0] millisecond,
	output reg overflow,
	input work,
	input clear,
	input RESET,
	input CLK,
	input EN);

	reg [7:0] next_second;
	reg [15:0] next_millisecond;
	reg next_overflow;

	always @(posedge CLK) begin
		if (RESET || clear) begin
			second <= 0;
			millisecond <= 0;
			overflow <= 0;
		end
		else if (EN && work) begin
			second <= next_second;
			millisecond <= next_millisecond;
			overflow <= next_overflow;
		end
	end

	always @(second, millisecond, overflow) begin
		next_millisecond = millisecond + 1;
		if (next_millisecond >= 1000) begin
			next_millisecond = 0;
			next_second = second + 1;
		end
		else
			next_second = second;
		if (next_second >= 60) begin
			next_second = 0;
			next_overflow = 1;
		end
		else
			next_overflow = overflow;
	end
endmodule