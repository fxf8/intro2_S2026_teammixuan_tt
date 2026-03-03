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
  logic input_request;
  logic input_acknowledged;
  logic output_byte_is_ready;
  logic output_acknowledge;

  // Output Byte
  logic [7:0] output_byte;

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
    is_key = '0;
    reset_hash = '0;

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
    tb_test_case = "Providing Key Input";
    tb_test_num  = 2;


    $display("\nTest cases passed: %1d/%1d\n", tb_passed, tb_test_num);
    $finish;

  end

endmodule
