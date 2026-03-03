// $Id: $
// File name:   data_router_tb.sv
// Created:     03/02/2026
// Author:      Rajin Braynard
// Description: Test bench for the data_router module

`timescale 1ns / 10ps

module data_router_tb ();

  // Define local parameters used by the test bench
  localparam CLK_PERIOD = 10;

  // Declare DUT portmap signals
  logic tb_clk;
  logic tb_nrst;
  // etc...
  // Inputs received from reader
  logic [7:0] input_byte_pulsed;
  logic is_key_pulsed;
  logic input_pulse;

  // Signals sent to the key storage
  logic [7:0] key_byte;
  logic key_byte_pulse;

  // Signals sent to the encryption block
  logic [7:0] byte_pulsed;
  logic byte_pulse;

  // Declare test bench signals
  integer tb_test_num;
  integer tb_passed;
  string tb_test_case;

  // Task for standard DUT reset procedure
  task reset_dut;
    begin
      // Activate the reset
      tb_nrst = 1'b0;
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(negedge tb_clk);
      // deactivate reset
      tb_nrst = 1'b1;
      @(negedge tb_clk);
      @(negedge tb_clk);
    end
  endtask

  // Add more tasks as needed
  always begin
    #(CLK_PERIOD / 2.0);
    tb_clk++;
  end

  // Signal dump
  initial begin
    $dumpfile("support/waves/stream_cipher/data_router.vcd");
    $dumpvars;
  end

  // DUT Port map
  data_router DUT (.*);

  // Test bench main process
  initial begin
    // Initialize all of the test inputs here
    // etc...
    tb_clk = 0;
    tb_nrst = 1;

    // ************************************************************************
    // Test Case 1: Power-on Reset of the DUT
    // ************************************************************************
    tb_test_case = "Power on Reset";
    tb_test_num = 1;

    reset_dut();

    // ************************************************************************
    // Test Case 2: Routing to Key Stoage
    // ************************************************************************
    tb_test_case = "Routing tot Key Storage";
    tb_test_num = 2;

    input_byte_pulsed = 8'b10101010;
    is_key_pulsed = 1'b1;
    input_pulse = 1'b0;
    @(posedge tb_clk);
    input_pulse = 1'b1;
    @(posedge tb_clk);
    input_pulse = 1'b0;
    repeat (3) @(posedge tb_clk);

    // ************************************************************************
    // Test Case 3: Routing to Encryption Block
    // ************************************************************************
    tb_test_case = "Routing to Encryption Block";
    tb_test_num = 3;

    input_byte_pulsed = 8'b10101010;
    is_key_pulsed = 1'b0;
    input_pulse = 1'b0;
    @(posedge tb_clk);
    input_pulse = 1'b1;
    @(posedge tb_clk);
    repeat (3) @(posedge tb_clk);

    // ************************************************************************
    // Test Case 4: Alternating a Route
    // ************************************************************************
    tb_test_case = "Alternating a Route";
    tb_test_num = 4;

    input_byte_pulsed = 8'b10011001;
    is_key_pulsed = 1'b1;
    input_pulse = 1'b0;
    @(posedge tb_clk);
    input_pulse = 1'b1;
    @(posedge tb_clk);
    is_key_pulsed = 1'b0;
    @(posedge tb_clk);
    input_pulse = 1'b0;
    repeat (3) @(posedge tb_clk);

    $display("\nTest cases passed: %1d/%1d\n", tb_passed, tb_test_num);
    $finish;

  end

endmodule
