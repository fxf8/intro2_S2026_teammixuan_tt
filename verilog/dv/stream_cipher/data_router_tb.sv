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
  logic   tb_clk;
  logic   tb_nrst;
  // etc...

  // Declare test bench signals
  integer tb_test_num;
  integer tb_passed;
  string  tb_test_case;

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
  data_router DUT ();

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

    repeat (5) @(negedge tb_clk);

    reset_dut();

    // ************************************************************************
    // Test Case 2: Continuous counting
    // ************************************************************************    
    tb_test_case = "Your Next Test Case";

    $display("\nTest cases passed: %1d/%1d\n", tb_passed, tb_test_num);
    $finish;

  end

endmodule
