// $Id: $
// File name:   top_tb.sv
// Created:     03/02/2026
// Author:      Rajin Braynard
// Description: Top-Level test bench

`timescale 1ns / 10ps

module top_tb ();

  // Define local parameters used by the test bench
  localparam CLK_PERIOD = 10;

  // Declare DUT portmap signals
  logic tb_clk;
  logic tb_nrst;
  // etc...
  // General Data Pins
  logic [7:0] input_byte;
  logic is_key;
  logic reset_hash;

  // 4-Phase-Handshake Interfacing pins in order of change
  logic input_request;  // Chip Input
  logic input_acknowledged;  // Chip Output
  logic output_byte_is_ready;  // Chip Output
  logic output_acknowledge;  // Chip Input

  // Output Byte
  logic [7:0] output_byte;

  // Declare test bench signals
  integer tb_test_num;
  integer tb_passed;
  string tb_test_case;

  // Task for standard DUT reset procedure
  task static reset_dut;
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

  task static wait_for_chip_output();
    begin
      wait (output_byte_is_ready == 1);
    end
  endtask

  task static input_byte_task(input logic [7:0] t_input_byte, input logic t_is_key);
    begin
      if (input_acknowledged || input_request) begin
        wait_for_chip_output();

        output_acknowledge = 1;  // Acknowledge the output of the chip

        wait ((input_acknowledged == 0) && (output_byte_is_ready == 0));
      end

      output_acknowledge = 0;

      input_byte = t_input_byte;
      is_key = t_is_key;
      input_request = 1;

      wait (input_acknowledged == 1);

      input_request = 0;
    end
  endtask

  task static test_provide_key_input();
    begin
      tb_test_case = "Providing Key Input";
      tb_test_num  = 2;

      @(negedge tb_clk);
      input_byte = 8'hA;
      is_key = 1;
      input_request = 1;
      repeat (10) @(negedge tb_clk);
      input_request = 0;
      @(negedge tb_clk);
      output_acknowledge = 1;
      repeat (3) @(negedge tb_clk);

      reset_dut();
    end
  endtask

  task static test_provide_key_input_rollover();
    // This task will test the behavior of a key input larger than 128 bits,
    // resulting in a rollover.
    begin
      tb_test_case = "Providing Key Input Rollover";
      tb_test_num  = 3;

      repeat (3) @(negedge tb_clk);
      for (int iteration = 0; iteration < 32; iteration++) begin
        input_byte_task(iteration, 1);
      end

      reset_dut();
    end
  endtask

  // Add more tasks as needed

  // Clock generation block
  always begin
    #(CLK_PERIOD / 2.0);
    tb_clk++;
  end

  // Signal dump
  initial begin
    $dumpfile("support/waves/stream_cipher/top.vcd");
    $dumpvars;
  end

  // DUT Port map
  top DUT (
      // System Control Pins
      .clk(tb_clk),
      .nrst(tb_nrst),
      // Data pins
      .input_byte(input_byte),
      .is_key(is_key),
      .reset_hash(reset_hash),
      // 4-phase handshake pins
      .input_request(input_request),
      .input_acknowledged(input_acknowledged),
      .output_byte_is_ready(output_byte_is_ready),
      .output_acknowledge(output_acknowledge),
      // Output Byte
      .output_byte(output_byte)
  );

  // Test bench main process
  initial begin
    // Initialize all of the test inputs here
    tb_clk = 0;
    tb_nrst = 1;
    // etc...

    input_byte = '0;
    is_key = 0;
    reset_hash = 0;

    input_request = '0;
    output_acknowledge = '0;

    // ************************************************************************
    // Test Case 1: Power-on Reset of the DUT
    // ************************************************************************
    tb_test_case = "Power on Reset";
    tb_test_num = 1;

    repeat (3) @(negedge tb_clk);

    reset_dut();

    // ************************************************************************
    // Test Case 2: Providing Key Input
    // ************************************************************************

    test_provide_key_input();

    // ************************************************************************
    // Test Case 3: Providing Key Input with Rollover
    // ************************************************************************

    test_provide_key_input_rollover();

    $display("\nTest cases passed: %1d/%1d\n", tb_passed, tb_test_num);
    $finish;

  end

endmodule
