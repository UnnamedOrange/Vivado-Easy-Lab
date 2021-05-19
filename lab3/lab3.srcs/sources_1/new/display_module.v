/// <author>UnnamedOrange</author>
/// <projectname>tick</projectname>
/// <modulename>display_module</modulename>
/// <filedescription>Display module.</filedescription>
/// <dependency>
/// </dependency>

module display_module_t(
	output [7:0] led_segs_L,
	output reg [3:0] led_sel_L,
	input [7:0] second,
	input [15:0] millisecond,
	input RESET,
	input CLK,
	input EN);

	integer i;
	reg [3:0] bcd_input;
	wire [6:0] bcd_output;
	bcd_7seg_t U1(.IN(bcd_input), .OUT_L(bcd_output), .EN_L(0));

	always @(posedge CLK) begin
		if (RESET) begin
			led_sel_L <= 0;
		end
		else begin
			led_sel_L[0] <= !led_sel_L[1] && !led_sel_L[2] && !led_sel_L[3];
			for (i = 1; i < 4; i = i + 1)
				led_sel_L[i] <= led_sel_L[i - 1];
		end
	end

	always @(led_sel_L) begin
		case (led_sel_L)
			4'b0001: bcd_input <= millisecond[7:4];
			4'b0010: bcd_input <= millisecond[11:8];
			4'b0100: bcd_input <= second[3:0];
			4'b1000: bcd_input <= second[7:4];
			default: bcd_input <= 0;
		endcase
	end

	assign led_segs_L[6:0] = bcd_output;
	assign led_segs_L[7] = !(bcd_input == 4'b0100);
endmodule

module bcd_7seg_t(
    input [3:0] IN,
    output reg [6:0] OUT_L,
    input EN_L);

    reg [15:0] storages[0:6];
    integer i;
    always @(*) begin
        storages[0] = 16'b0000001110101101;
        storages[1] = 16'b0000001110011111;
        storages[2] = 16'b0000001111111011;
        storages[3] = 16'b0000000101101101;
        storages[4] = 16'b0000000101000101;
        storages[5] = 16'b0000001101110001;
        storages[6] = 16'b0000001101111100;
        if (~EN_L)
            for (i = 0; i < 7; i = i + 1)
                OUT_L[i] = !storages[i][IN];
        else
            OUT_L = 7'b0;
    end
endmodule