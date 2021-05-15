/// <author>Li Yancheng 1900012766</author>
/// <description>UUT for heater.</description>
/// <dependency>heater.v</dependency>
/// <version>
/// 0.0.1 (2021-5-14 10:34:08): First commit.
/// </version>

`timescale 10ns / 1ps

module uut_heater();
    reg CLK;
    reg RESET;

    parameter n_instance = 2;
    parameter test_period = 2;

    wire test_heating_status[0:n_instance - 1];
    wire test_done_status[0:n_instance - 1];
    reg test_button;
    reg test_temperature;

    heater_t_imp1 U1(.HEATING_STATUS(test_heating_status[0]),
        .DONE_STATUS(test_done_status[0]),
        .BUTTON(test_button),
        .TEMPERATURE(test_temperature),
        .CLK(CLK),
        .RESET(RESET));

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

        // Reset.
        CLK = 0;
        RESET = 1;
        test_button = 0;
        test_temperature = 0;
        #10;
        RESET = 0;
        #10;

        // Test the ready status.
        assert(test_heating_status[0] === 0, "heating_status should be 0 when ready. (0)");
        assert(test_heating_status[1] === 0, "heating_status should be 0 when ready. (1)");
        assert(test_done_status[0] === 0, "done_status should be 0 when ready. (0)");
        assert(test_done_status[1] === 0, "done_status should be 0 when ready. (1)");

        // Test the heating status.
        test_button = 1;
        #10;
        test_button = 0;
        #10;
        for (i = 0; i < test_period; i = i + 1) begin
            assert(test_heating_status[0] === 1, "heating_status should be 1 when heating. (0)");
            assert(test_heating_status[1] === 1, "heating_status should be 1 when heating. (1)");
            assert(test_done_status[0] === 0, "done_status should be 0 when heating. (0)");
            assert(test_done_status[1] === 0, "done_status should be 0 when heating. (1)");
            #2;
        end

        // Test the finished status.
        test_temperature = 1;
        #10;
        test_temperature = 0; // This shows a shortcoming of this system in physical world. Without this line, the status will keep changing when the button is down.
        #10;
        for (i = 0; i < test_period; i = i + 1) begin
            assert(test_heating_status[0] === 0, "heating_status should be 0 when finished. (0)");
            assert(test_heating_status[1] === 0, "heating_status should be 0 when finished. (1)");
            assert(test_done_status[0] === 1, "done_status should be 1 when finished. (0)");
            assert(test_done_status[1] === 1, "done_status should be 1 when finished. (1)");
            #2;
        end

        // Can't test the ready status again.

        $display("%0d error(s) occurred.", failure_count);
        $stop(1);
    end
endmodule