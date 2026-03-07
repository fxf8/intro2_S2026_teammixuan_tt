// $Id: $
// File name:   src1_tb.sv
// Created:     03/05/2026
// Author:      Rajin Braynard
// Description: Reader Block Testbench

`timescale 1ns / 10ps

module reader_tb ();

  // Define local parameters used by the test bench
  localparam CLK_PERIOD = 10;

  // Declare DUT portmap signals
  logic tb_clk;
  logic tb_nrst;
  // etc...

  // Data inputs (received from chip pins)
  logic [7:0] input_byte;
  logic is_key;
  logic reset_hash;

  // Handshake Management Inputs (received from chip pins)
  logic input_request;

  // FSM State (received from fsm state block)
  types_pkg::interface_state_t fsm_state;

  // Signals sent to the data router
  logic [7:0] input_byte_pulsed;  // This is the input byte that *gets pulsed*
  logic is_key_pulsed;
  logic input_byte_pulse;  // This is the pulse used to communicate the 2 outputs above

  // Signal sent to the hash generator
  logic reset_hash_pulse;

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


  // Clock generation block
  always begin
    #(CLK_PERIOD / 2.0);
    tb_clk++;
  end

  // Signal dump
  initial begin
    $dumpfile("support/waves/stream_cipher/reader.vcd");
    $dumpvars;
  end

  // DUT Port map
  reader DUT (
      .clk (tb_clk),
      .nrst(tb_nrst), /*add other ports*/

      .input_byte(input_byte),
      .is_key(is_key),
      .reset_hash(reset_hash),

      .input_request(input_request),

      .fsm_state(fsm_state),

      .input_byte_pulsed(input_byte_pulsed),
      .is_key_pulsed(is_key_pulsed),
      .input_byte_pulse(input_byte_pulse),

      .reset_hash_pulse(reset_hash_pulse)
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
    tb_test_num = 0;

    reset_dut();

    // ************************************************************************
    // Test Case 2: Providing Key Input
    // ************************************************************************
    tb_test_case = "Providing Key Input";
    tb_test_num = 1;

    @(negedge tb_clk);
    fsm_state = types_pkg::I_IDLE;
    @(negedge tb_clk);
    input_byte = 8'hA;
    @(negedge tb_clk);
    is_key = 1'b1;
    @(negedge tb_clk);
    input_request = 1'b1;
    repeat (4) @(negedge tb_clk);


    // ************************************************************************
    // Test Case 3: Provide Byte to Encrypt
    // ************************************************************************
    tb_test_case = "Provide Byte to Encrypt";
    tb_test_num = 2;

    reset_dut();

    @(negedge tb_clk);
    input_byte = 8'hB;
    @(negedge tb_clk);
    is_key = 1'b0;
    @(negedge tb_clk);
    input_request = 1'b1;
    repeat (4) @(negedge tb_clk);

    $display("\nTest cases passed: %1d/%1d\n", tb_passed, tb_test_num);
    $finish;

  end

endmodule
