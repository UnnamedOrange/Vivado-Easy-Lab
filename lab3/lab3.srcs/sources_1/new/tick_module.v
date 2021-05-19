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

	always @(second, millisecond, overflow) begin : EXCITATION
		next_millisecond = millisecond + 1;
		next_second = second;
		next_overflow = overflow;

		if (next_millisecond[3:0] >= 10) begin
			next_millisecond[3:0] = 0;
			next_millisecond[7:4] = millisecond[7:4] + 1;
		end
		if (next_millisecond[7:4] >= 10) begin
			next_millisecond[7:4] = 0;
			next_millisecond[11:8] = millisecond[11:8] + 1;
		end
		if (next_millisecond[11:8] >= 10) begin
			next_millisecond[11:8] = 0;
			next_millisecond[15:12] = millisecond[15:12] + 1;
		end
		if (next_millisecond[15:12] >= 1) begin
			next_millisecond[15:12] = 0;
			next_second = second + 1;
		end


		if (next_second[3:0] >= 10) begin
			next_second[3:0] = 0;
			next_second[7:4] = second[7:4] + 1;
		end
		if (next_second[7:4] >= 6) begin
			next_second[7:4] = 0;
			next_overflow = 1;
		end
	end
endmodule