/// <author>Li Yancheng 1900012766</author>
/// <description>UUT for BCD-7Seg.</description>
/// <dependency>bcd_7seg.v</dependency>
/// <version>
/// 0.0.1 (2021-5-13 16:29:03): First commit.
/// 0.0.2 (2021-5-14 10:20:52): Add assertion template.
/// </version>

`timescale 1ns / 1ps

module uut_bcd_7seg();
    reg [3:0] test_input;
    parameter n_instance = 3;
    wire [6:0] test_output[0:n_instance - 1];
    reg test_en;

    bcd_7seg_t_imp1 U1(.IN(test_input), .OUT(test_output[0]), .EN_L(test_en));
    bcd_7seg_t_imp2 U2(.IN(test_input), .OUT(test_output[1]), .EN_L(test_en));
    bcd_7seg_t_imp3 U3(.IN(test_input), .OUT(test_output[2]), .EN_L(test_en));

    // Assertion template.
    integer failure_count;
    task assert;
        input statement;
        input [256 * 8 - 1:0] comment;

        if (!statement) begin
            $display("Assertion failed at %0t.%s%0s%s",
                $time,
                comment ? " (" : "",
                comment,
                comment ? ")" : "");
            failure_count = failure_count + 1;
        end
    endtask
    initial failure_count = 0;

    initial begin : TB
        integer i, j;

        // Test whether the EN_L is working.
        test_en = 1;
        for (i = 0; i < 16; i = i + 1) begin
            test_input = i;
            #10;
            for (j = 0; j < n_instance; j = j + 1)
                assert(test_output[j] == 0, "test_output[j] == 0");
        end

        // Test whether all cases are the same.
        test_en = 0;
        for (i = 0; i < 16; i = i + 1) begin
            test_input = i;
            #10;
            for (j = 1; j < n_instance; j = j + 1)
                assert(test_output[j] == test_output[j - 1], "test_output[j] == test_output[j - 1]");
            if (1 <= i && i <= 9)
                assert(test_output[j] != 0, "test_output[j] != 0 when 1 <= i && i <= 9");
        end

        $display("%0d error(s) occurred.", failure_count);
        $stop(1);
    end
endmodule