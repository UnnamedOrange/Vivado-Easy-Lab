/// <author>Li Yancheng 1900012766</author>
/// <description>UUT for heater.</description>
/// <dependency>heater.v</dependency>
/// <version>
/// 0.0.1 (2021-5-14 10:34:08): First commit.
/// </version>

`timescale 1ns / 1ps

module uut_heater();
    reg CLK;
    reg RESET;

    parameter n_instance = 2;

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
        #2;

        // Test


        $display("%0d error(s) occurred.", failure_count);
        $stop(1);
    end


endmodule