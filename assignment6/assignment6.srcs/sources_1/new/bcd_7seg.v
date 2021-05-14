/// <author>Li Yancheng 1900012766</author>
/// <description>BCD-7Seg module in 3 implementations.</description>
/// <dependency></dependency>
/// <version>
/// 0.0.1 (2021-5-12 21:28:37): First commit.
/// 0.0.2 (2021-5-14 10:44:40): Specify bit width for literals.
/// </version>

`timescale 1ns / 1ps

// Use assign to implement.
module bcd_7seg_t_imp1(
    input [3:0] IN,
    output [6:0] OUT,
    input EN_L);

    assign OUT[0] = ~EN_L & ((IN == 4'd0) | (IN == 4'd2) | (IN == 4'd3) | (IN == 4'd5) | (IN == 4'd7) | (IN == 4'd8) | (IN == 4'd9));
    assign OUT[1] = ~EN_L & ((IN == 4'd0) | (IN == 4'd1) | (IN == 4'd2) | (IN == 4'd3) | (IN == 4'd4) | (IN == 4'd7) | (IN == 4'd8) | (IN == 4'd9));
    assign OUT[2] = ~EN_L & ((IN == 4'd0) | (IN == 4'd1) | (IN == 4'd3) | (IN == 4'd4) | (IN == 4'd5) | (IN == 4'd6) | (IN == 4'd7) | (IN == 4'd8) | (IN == 4'd9));
    assign OUT[3] = ~EN_L & ((IN == 4'd0) | (IN == 4'd2) | (IN == 4'd3) | (IN == 4'd5) | (IN == 4'd6) | (IN == 4'd8));
    assign OUT[4] = ~EN_L & ((IN == 4'd0) | (IN == 4'd2) | (IN == 4'd6) | (IN == 4'd8));
    assign OUT[5] = ~EN_L & ((IN == 4'd0) | (IN == 4'd4) | (IN == 4'd5) | (IN == 4'd6) | (IN == 4'd8) | (IN == 4'd9));
    assign OUT[6] = ~EN_L & ((IN == 4'd2) | (IN == 4'd3) | (IN == 4'd4) | (IN == 4'd5) | (IN == 4'd6) | (IN == 4'd8) | (IN == 4'd9));
endmodule

// Use reg to implement.
module bcd_7seg_t_imp2(
    input [3:0] IN,
    output reg [6:0] OUT,
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
                OUT[i] = storages[i][IN];
        else
            OUT = 7'b0;
    end
endmodule

// Use behavior description (case) to implement.
module bcd_7seg_t_imp3(
    input [3:0] IN,
    output reg [6:0] OUT,
    input EN_L);

    always @(*) begin
        if (~EN_L)
            case (IN)
                0: OUT = 7'b0111111;
                1: OUT = 7'b0000110;
                2: OUT = 7'b1011011;
                3: OUT = 7'b1001111;
                4: OUT = 7'b1100110;
                5: OUT = 7'b1101101;
                6: OUT = 7'b1111100;
                7: OUT = 7'b0000111;
                8: OUT = 7'b1111111;
                9: OUT = 7'b1100111;
                default: OUT = 7'b0;
            endcase
        else
            OUT = 7'b0;
    end
endmodule