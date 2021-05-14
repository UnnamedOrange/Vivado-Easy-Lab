/// <author>Li Yancheng 1900012766</author>
/// <description>UUT for BCD60 counter.</description>
/// <dependency>bcd60_counter.v</dependency>
/// <version>
/// 0.0.1 (2021-5-13 23:11:26): First commit.
/// </version>

`timescale 1ns / 1ps

module uut_bdc60_counter();
    wire [7:0] test_OUT;
    reg CLK;
    reg test_RESET_L;
    reg test_EN_L;

    parameter n_system = 100; // This parameter can be up to 100. For better display, it is set to 12.

    bcd60_counter_t #(.n_system(n_system)) U1(.OUT(test_OUT), .CLK(CLK), .RESET_L(test_RESET_L), .EN_L(test_EN_L));

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

    always begin : CLOCK
        #0.05;
        CLK = 1; #0.5;
        CLK = 0; #0.45;
    end

    initial begin : TB
        integer i, j, k;
        reg [7:0] temp_pre;

        // Reset.
        CLK = 0;
        test_RESET_L = 0;
        test_EN_L = 1;
        #2;

        // Test the RESET.
        assert(test_OUT === 0, "OUT should be 0 after first RESET.");

        // Test the counter.
        test_RESET_L = 1;
        test_EN_L = 0;
        for (i = 0; i < n_system; i = i + 1) begin
            assert(test_OUT[3:0] == i % 10 && test_OUT[7:4] == i / 10,
                "OUT should be i.");
            #1; // Step.
        end

        // Test the next round.
        for (i = 0; i < n_system / 2; i = i + 1) begin
            assert(test_OUT[3:0] == i % 10 && test_OUT[7:4] == i / 10,
                "OUT should be i.");
            #1; // Step.
        end

        // Test the enable.
        test_EN_L = 1;
        temp_pre = test_OUT;
        #1;
        assert(test_OUT == temp_pre, "Counter should not work when EN_L == 1.");

        // Test the RESET again.
        test_RESET_L = 0;
        #1;
        assert(test_OUT == 0, "OUT should be 0 after reset.");

        $display("%0d error(s) occurred.", failure_count);
        $stop(1);
    end
endmodule
