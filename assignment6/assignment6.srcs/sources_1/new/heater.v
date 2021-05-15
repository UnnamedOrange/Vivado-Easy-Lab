/// <author>Li Yancheng 1900012766</author>
/// <description>Heater.</description>
/// <dependency></dependency>
/// <version>
/// 0.0.1 (2021-5-14 10:34:08): First commit.
/// </version>

`timescale 1ns / 1ps

// Three-section coding style.
module heater_t_imp1(
    output reg HEATING_STATUS,
    output reg DONE_STATUS,
    input BUTTON,
    input TEMPERATURE,
    input CLK,
    input RESET);

    parameter [1:0] status_ready = 2'b00;
    parameter [1:0] status_heating = 2'b01;
    parameter [1:0] status_finished = 2'b11;

    reg [1:0] crt, next;

    always @(posedge CLK) begin
        if (RESET)
            crt <= status_ready;
        else
            crt <= next;
    end

    always @(BUTTON, TEMPERATURE, crt) begin
        case (crt)
            status_ready:
                if (BUTTON)
                    next = status_heating;
                else
                    next = status_ready;
            status_heating:
                if (TEMPERATURE)
                    next = status_finished;
                else
                    next = status_heating;
            status_finished:
                if (BUTTON)
                    next = status_ready;
                else
                    next = status_finished;
            default:
                next = status_ready;
        endcase
    end

    always @(BUTTON, TEMPERATURE, crt) begin
        case (crt)
            status_ready:
                if (BUTTON)
                    {HEATING_STATUS, DONE_STATUS} = 2'b10;
                else
                    {HEATING_STATUS, DONE_STATUS} = 2'b00;
            status_heating:
                if (TEMPERATURE)
                    {HEATING_STATUS, DONE_STATUS} = 2'b01;
                else
                    {HEATING_STATUS, DONE_STATUS} = 2'b10;
            status_finished:
                if (BUTTON)
                    {HEATING_STATUS, DONE_STATUS} = 2'b00;
                else
                    {HEATING_STATUS, DONE_STATUS} = 2'b01;
            default:
                {HEATING_STATUS, DONE_STATUS} = 2'b00;
        endcase
    end
endmodule

// Two-section coding style.
module heater_t_imp2(
    output reg HEATING_STATUS,
    output reg DONE_STATUS,
    input BUTTON,
    input TEMPERATURE,
    input CLK,
    input RESET);

    parameter [1:0] status_ready = 2'b00;
    parameter [1:0] status_heating = 2'b01;
    parameter [1:0] status_finished = 2'b11;

    reg [1:0] crt;

    always @(posedge CLK) begin
        if (RESET)
            crt <= status_ready;
        else
            case (crt)
                status_ready:
                    if (BUTTON)
                        crt <= status_heating;
                    else
                        crt <= status_ready;
                status_heating:
                    if (TEMPERATURE)
                        crt <= status_finished;
                    else
                        crt <= status_heating;
                status_finished:
                    if (BUTTON)
                        crt <= status_ready;
                    else
                        crt <= status_finished;
                default:
                    crt <= status_ready;
            endcase
    end

    always @(BUTTON, TEMPERATURE, crt) begin
        case (crt)
            status_ready:
                if (BUTTON)
                    {HEATING_STATUS, DONE_STATUS} = 2'b10;
                else
                    {HEATING_STATUS, DONE_STATUS} = 2'b00;
            status_heating:
                if (TEMPERATURE)
                    {HEATING_STATUS, DONE_STATUS} = 2'b01;
                else
                    {HEATING_STATUS, DONE_STATUS} = 2'b10;
            status_finished:
                if (BUTTON)
                    {HEATING_STATUS, DONE_STATUS} = 2'b00;
                else
                    {HEATING_STATUS, DONE_STATUS} = 2'b01;
            default:
                {HEATING_STATUS, DONE_STATUS} = 2'b00;
        endcase
    end
endmodule