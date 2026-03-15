// $Id: $
// File name:   hash_generator_tb.sv
// Created:     03/14/2026
// Author:      Rajin Braynard
// Description: Hash Generator Testbench

`timescale 1ns / 10ps

module hash_generator_tb ();

  // Define local parameters used by the test bench
  localparam CLK_PERIOD = 10;

  // Declare DUT portmap signals
  logic tb_clk;
  logic tb_nrst;
  // etc...
  logic reset_hash;

  // Input receivd from key storage
  logic [127:0] key_memory;

  // Input received from encryption block
  logic request_hash_byte_pulse;

  // Signals sent to encryption block
  logic [7:0] hash_byte_out;
  logic hash_byte_pulse_out;
  types_pkg::hash_generator_state_t generator_current_state_out;

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

  task test_request_hashed_byte();
    logic input_request_pulsed;

    begin
      input_request_pulsed = 0;
      key_memory = 'hABC;

      @(negedge tb_clk);
      request_hash_byte_pulse = 1;
      @(negedge tb_clk);
      request_hash_byte_pulse = 0;
      input_request_pulsed = 1;

      repeat (20) @(negedge tb_clk);

      reset_dut();
    end
  endtask

  // Clock generation block
  always begin
    #(CLK_PERIOD / 2.0);
    tb_clk++;
  end

  // Signal dump
  initial begin
    $dumpfile("support/waves/stream_cipher/hash_generator.vcd");
    $dumpvars;
  end

  // DUT Port map
  hash_generator DUT (
      .clk (tb_clk),
      .nrst(tb_nrst), /*add other ports*/

      // Inputs
      .reset_hash(reset_hash),
      .key_memory(key_memory),
      .request_hash_byte_pulse(request_hash_byte_pulse),

      // Outputs
      .hash_byte_out(hash_byte_out),
      .hash_byte_pulse_out(hash_byte_pulse_out),
      .generator_current_state_out(generator_current_state_out)
  );

  // Test bench main process
  initial begin
    // Initialize all of the test inputs here
    tb_clk = 0;
    tb_nrst = 1;
    // etc...

    // ************************************************************************
    // Test Case 1: Power-on Reset of the DUT
    // ************************************************************************
    tb_test_case = "Power on Reset";

    reset_dut();

    // ************************************************************************
    // Test Case 2: Continuous counting
    // ************************************************************************    
    tb_test_case = "Your Next Test Case";

    $display("\nTest cases passed: %1d/%1d\n", tb_passed, tb_test_num);
    $finish;

  end

endmodule
