// $Id: $
// File name:   interface_reader_tb.sv
// Created:     04/18/2026
// Author:      Gemini
// Description: Test bench for the interface_fsm and reader modules

`timescale 1ns / 10ps

module interface_reader_tb ();

  // Include package for custom types
  import types_pkg::*;

  // Define local parameters used by the test bench
  localparam CLK_PERIOD = 10;

  // Declare DUT portmap signals
  logic tb_clk;
  logic tb_nrst;

  // Signals for interface_fsm
  logic input_request_sig;
  logic output_acknowledge_sig;
  types_pkg::output_holder_state_t output_holder_state_sig;
  types_pkg::interface_state_t interface_state_sig;

  // Signals for reader
  logic [7:0] input_byte_sig;
  logic command_sig;
  logic [7:0] input_byte_pulsed_sig;
  logic command_pulsed_sig;
  logic pulse_sig;

  // Declare test bench signals
  integer tb_test_num;
  integer tb_passed;
  string tb_test_case;

  // Helper function to get string name of interface_state_t
  function string get_interface_state_name(types_pkg::interface_state_t state);
    case (state)
      types_pkg::I_IDLE: return "I_IDLE";
      types_pkg::I_PROCESSING: return "I_PROCESSING";
      types_pkg::I_DONE: return "I_DONE";
      default: return "UNKNOWN_INTERFACE_STATE";
    endcase
  endfunction

  // Helper function to get string name of output_holder_state_t
  function string get_output_holder_state_name(types_pkg::output_holder_state_t state);
    case (state)
      types_pkg::O_EMPTY: return "O_EMPTY";
      types_pkg::O_READY: return "O_READY";
      default: return "UNKNOWN_OUTPUT_HOLDER_STATE";
    endcase
  endfunction

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

  // Task to simulate a full 4-phase handshake cycle
  task automatic four_phase_handshake_cycle_subtask(input logic [7:0] data_in, input logic cmd_in);
    begin
      // 1. Assert input_request
      input_byte_sig = data_in;
      command_sig = cmd_in;
      input_request_sig = 1'b1;
      output_acknowledge_sig = 1'b0;
      output_holder_state_sig = O_EMPTY;

      @(negedge tb_clk);
      // Expect FSM to go to I_PROCESSING and reader to pulse
      if (interface_state_sig == I_PROCESSING && pulse_sig == 1'b1 &&
          input_byte_pulsed_sig == data_in && command_pulsed_sig == cmd_in) begin
        $display("  [PASS] %s: Input request processed. State: %s, Pulse: %b", tb_test_case,
                 get_interface_state_name(interface_state_sig), pulse_sig);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Input request failed. State: %s, Pulse: %b", tb_test_case,
                 get_interface_state_name(interface_state_sig), pulse_sig);
      end

      // De-assert input_request after one cycle
      input_request_sig = 1'b0;
      @(negedge tb_clk);
      // Pulse should be de-asserted
      if (pulse_sig == 1'b0) begin
        $display("  [PASS] %s: Pulse de-asserted.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Pulse not de-asserted.", tb_test_case);
      end

      // 2. Simulate output_holder becoming ready
      output_holder_state_sig = O_READY;
      @(negedge tb_clk);
      // Expect FSM to go to I_DONE
      if (interface_state_sig == I_DONE) begin
        $display("  [PASS] %s: Output holder ready. State: %s", tb_test_case,
                 get_interface_state_name(interface_state_sig));
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Output holder ready failed. State: %s", tb_test_case,
                 get_interface_state_name(interface_state_sig));
      end

      // 3. Assert output_acknowledge
      output_acknowledge_sig = 1'b1;
      @(negedge tb_clk);
      // Expect FSM to go back to I_IDLE
      if (interface_state_sig == I_IDLE) begin
        $display("  [PASS] %s: Output acknowledged. State: %s", tb_test_case,
                 get_interface_state_name(interface_state_sig));
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Output acknowledged failed. State: %s", tb_test_case,
                 get_interface_state_name(interface_state_sig));
      end

      // De-assert output_acknowledge
      output_acknowledge_sig = 1'b0;
      @(negedge tb_clk);
      output_holder_state_sig = O_EMPTY;  // Reset output holder state
    end
  endtask

  task automatic test_power_on_reset();
    begin
      tb_test_case = "Power on Reset";
      tb_test_num++;

      reset_dut();
      @(negedge tb_clk);
      if (interface_state_sig == I_IDLE && pulse_sig == 1'b0) begin
        $display("  [PASS] %s: Initial state is IDLE, pulse is 0.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Initial state is %s, pulse is %b.", tb_test_case,
                 get_interface_state_name(interface_state_sig), pulse_sig);
      end
    end
  endtask

  task automatic test_single_handshake_cycle();
    begin
      tb_test_case = "Single Four-Phase Handshake Cycle";
      tb_test_num++;
      four_phase_handshake_cycle_subtask(8'hAB, 1'b1);  // Example data and command
    end
  endtask

  task automatic test_multiple_handshake_cycles();
    begin
      tb_test_case = "Multiple Four-Phase Handshake Cycles";
      tb_test_num++;
      four_phase_handshake_cycle_subtask(8'hCD, 1'b0);  // Example data and command
      four_phase_handshake_cycle_subtask(8'h12, 1'b1);  // Another example
      four_phase_handshake_cycle_subtask(8'h34, 1'b0);  // Another example
    end
  endtask

  task automatic test_input_request_without_output_ready();
    begin
      tb_test_case = "Input Request without Output Ready";
      tb_test_num++;

      input_byte_sig = 8'hEF;
      command_sig = 1'b1;
      input_request_sig = 1'b1;
      output_acknowledge_sig = 1'b0;
      output_holder_state_sig = O_EMPTY;

      @(negedge tb_clk);
      if (interface_state_sig == I_PROCESSING && pulse_sig == 1'b1) begin
        $display("  [PASS] %s: Input request processed. State: %s, Pulse: %b", tb_test_case,
                 get_interface_state_name(interface_state_sig), pulse_sig);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Input request failed. State: %s, Pulse: %b", tb_test_case,
                 get_interface_state_name(interface_state_sig), pulse_sig);
      end

      input_request_sig = 1'b0;
      @(negedge tb_clk);
      if (pulse_sig == 1'b0) begin
        $display("  [PASS] %s: Pulse de-asserted.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Pulse not de-asserted.", tb_test_case);
      end

      repeat (5) @(negedge tb_clk);  // Wait for some cycles, FSM should remain in PROCESSING
      if (interface_state_sig == I_PROCESSING) begin
        $display("  [PASS] %s: FSM remains in PROCESSING.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: FSM is in %s, expected PROCESSING.", tb_test_case,
                 get_interface_state_name(interface_state_sig));
      end

      // Now complete the handshake
      output_holder_state_sig = O_READY;
      @(negedge tb_clk);
      if (interface_state_sig == I_DONE) begin
        $display("  [PASS] %s: Output holder ready. State: %s", tb_test_case,
                 get_interface_state_name(interface_state_sig));
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Output holder ready failed. State: %s", tb_test_case,
                 get_interface_state_name(interface_state_sig));
      end

      output_acknowledge_sig = 1'b1;
      @(negedge tb_clk);
      if (interface_state_sig == I_IDLE) begin
        $display("  [PASS] %s: Output acknowledged. State: %s", tb_test_case,
                 get_interface_state_name(interface_state_sig));
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Output acknowledged failed. State: %s", tb_test_case,
                 get_interface_state_name(interface_state_sig));
      end

      output_acknowledge_sig  = 1'b0;
      output_holder_state_sig = O_EMPTY;
      @(negedge tb_clk);
    end
  endtask


  // Clock generation block
  always begin
    #(CLK_PERIOD / 2.0);
    tb_clk++;
  end

  // Signal dump
  initial begin
    $dumpfile("support/waves/stream_cipher/interface_reader.vcd");
    $dumpvars;
  end

  // DUT Port map - interface_fsm
  interface_fsm FSM (
      .clk(tb_clk),
      .nrst(tb_nrst),
      .input_request_in(input_request_sig),
      .output_acknowledge_in(output_acknowledge_sig),
      .output_holder_state_in(output_holder_state_sig),
      .interface_state_out(interface_state_sig)
  );

  // DUT Port map - reader
  reader READER (
      .clk(tb_clk),
      .nrst(tb_nrst),
      .input_byte_in(input_byte_sig),
      .command_in(command_sig),
      .input_request(input_request_sig),  // Connect to the same input request as FSM
      .interface_fsm_state_in(interface_state_sig),  // Connect FSM output to reader input
      .input_byte_pulsed_out(input_byte_pulsed_sig),
      .command_pulsed_out(command_pulsed_sig),
      .pulse_out(pulse_sig)
  );

  // Test bench main process
  initial begin
    // Initialize all of the test inputs here
    tb_clk = 0;
    tb_nrst = 1;
    input_request_sig = 0;
    output_acknowledge_sig = 0;
    output_holder_state_sig = O_EMPTY;
    input_byte_sig = '0;
    command_sig = '0;

    tb_test_num = 0;
    tb_passed = 0;

    test_power_on_reset();
    test_single_handshake_cycle();
    test_multiple_handshake_cycles();
    test_input_request_without_output_ready();

    $display("\nTotal Test Cases: %1d, Total Checks Passed: %1d\n", tb_test_num, tb_passed);
    $finish;

  end

endmodule
