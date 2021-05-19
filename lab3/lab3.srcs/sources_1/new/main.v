/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>main</modulename>
/// <filedescription>Main module of the tick system.</filedescription>
/// <dependency>
/// 	enable_module
/// 	system_controller
/// 	tick_module
/// 	enable_module
/// </dependency>

module main(
	output overflow,
	output [7:0] led_segs_L,
	output [3:0] led_sel_L,
	input button,
	input RESET,
	input CLK);

	wire pulse_10ms;
	wire pulse_1ms;
	wire pulse_120hz;

	wire work;
	wire clear;

	wire [7:0] second;
	wire [15:0] millisecond;

	enable_module_t #(.pulse_frequency(100)) em10ms(
		.pulse(pulse_10ms),
		.RESET(RESET),
		.CLK(CLK));
	enable_module_t #(.pulse_frequency(1000)) em1ms(
		.pulse(pulse_1ms),
		.RESET(RESET),
		.CLK(CLK));
	enable_module_t #(.pulse_frequency(480)) em120hz(
		.pulse(pulse_120hz),
		.RESET(RESET),
		.CLK(CLK));
	system_controller_t sc(
		.work(work),
		.clear(clear),
		.button(button),
		.RESET(RESET),
		.CLK(CLK),
		.EN(pulse_10ms));
	tick_module_t tm(
		.second(second),
		.millisecond(millisecond),
		.overflow(overflow),
		.work(work),
		.clear(clear),
		.RESET(RESET),
		.CLK(CLK),
		.EN(pulse_1ms));
	display_module_t dm(
		.led_segs_L(led_segs_L),
		.led_sel_L(led_sel_L),
		.second(second),
		.millisecond(millisecond),
		.RESET(RESET),
		.CLK(CLK),
		.EN(pulse_120hz));
endmodule