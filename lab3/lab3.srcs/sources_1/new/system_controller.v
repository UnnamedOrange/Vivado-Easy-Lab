/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>system_controller</modulename>
/// <filedescription>System controller.</filedescription>
/// <dependency>
/// </dependency>

module system_controller_t(
	output work,
	output clear,
	input button,
	input RESET,
	input CLK,
	input EN);

	localparam status_init = 2'b00;
	localparam status_working = 2'b01;
	localparam status_pause = 2'b11;
	reg [1:0] status;

	wire button_out;
	button_fliter_t bf(
		.button_out(button_out),
		.button_in(button),
		.RESET(RESET),
		.CLK(CLK),
		.EN(EN));

	always @(posedge CLK) begin
		if (RESET)
			status <= status_init;
		else begin
			case (status)
				status_init: if (button_out) status <= status_working;
				status_working: if (button_out) status <= status_pause;
				status_pause: if (button_out) status <= status_init;
				default: status <= status_init;
			endcase
		end
	end

	assign work = status == status_working;
	assign clear = status == status_init;

endmodule

module button_fliter_t(
	output button_out,
	input button_in,
	input RESET,
	input CLK,
	input EN);

	localparam status_init = 2'b00;
	localparam status_first = 2'b01;
	localparam status_second = 2'b11;
	localparam status_more = 2'b10;
	reg [1:0] status;

	reg one_beat;

	always @(posedge CLK) begin
		if (RESET) begin
			status <= status_init;
			one_beat <= 0;
		end
		else begin
			if (EN) begin
				case (status)
					status_init: status <= button_in ? status_first : status_init;
					status_first: status <= button_in ? status_second : status_init;
					status_second: status <= button_in ? status_more : status_init;
					status_more: status <= button_in ? status_more : status_init;
					default:
						status <= status_init;
				endcase
				one_beat <= 1;
			end
			else
				one_beat <= 0;
		end
	end

	assign button_out = one_beat && (status == status_second);

endmodule