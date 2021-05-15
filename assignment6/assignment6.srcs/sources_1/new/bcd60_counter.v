/// <author>Li Yancheng 1900012766</author>
/// <description>BCD60 counter.</description>
/// <dependency></dependency>
/// <version>
/// 0.0.1 (2021-5-13 22:23:02): First commit.
/// </version>

`timescale 1ns / 1ps

module bcd60_counter_t(
    output reg [7:0] OUT, // Direct output encoding.
    input CLK,
    input RESET_L,
    input EN_L);

    parameter n_system = 60; // < 100
    parameter [3:0] _digit_0 = (n_system - 1) % 10;
    parameter [3:0] _digit_1 = (n_system - 1) / 10;
    parameter _n_digit = 2; // Internal now.

    reg [7:0] next;

    reg i, j, k;

    always @(posedge CLK) begin
        if (~RESET_L)
            OUT <= 0;
        else
            OUT <= next;
    end

    always @(EN_L, OUT) begin
        if (~EN_L) begin
            if (OUT[7:4] >= 10 || OUT[3:0] >= 10)
                next = 0;
            else if (OUT[7:4] == _digit_1[3:0] && OUT[3:0] == _digit_0[3:0])
                next = 0;
            else begin
                next[7:4] = OUT[7:4] + (OUT[3:0] == 4'd9 ? 1 : 0);
                next[3:0] = OUT[3:0] == 4'd9 ? 0 : OUT[3:0] + 4'd1;
            end
        end
        else
            next = OUT;
    end
endmodule