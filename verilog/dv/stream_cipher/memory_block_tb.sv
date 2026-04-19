// $Id: $
// File name:   memory_block_tb.sv
// Created:     04/18/2026
// Author:      Gemini
// Description: Test bench for the memory_block module

`timescale 1ns / 10ps

module memory_block_tb ();

  // Define local parameters used by the test bench
  localparam CLK_PERIOD = 10;
  localparam int MEMORY_WIDTH_BYTES = 16;  // Example: 16 bytes
  localparam logic AUTO_INCREMENT_ADDRESS = 1;
  localparam int AddressWidth = $clog2(MEMORY_WIDTH_BYTES);

  // Declare DUT portmap signals
  logic tb_clk;
  logic tb_nrst;

  logic [7:0] tb_store_byte_in;
  logic tb_store_byte_pulse_in;

  logic [AddressWidth - 1:0] tb_set_address_in;
  logic tb_set_address_pulse_in;

  logic [MEMORY_WIDTH_BYTES * 8 - 1:0] tb_memory_out;
  logic [7:0] tb_memory_at_address_out;

  logic tb_received_byte_pulse_out;
  logic tb_received_address_pulse_out;

  logic [AddressWidth - 1:0] tb_address_out;

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

  // Task to set the address
  task automatic set_address_task(input logic [AddressWidth - 1:0] addr);
    begin
      tb_set_address_in = addr;
      tb_set_address_pulse_in = 1'b1;
      @(negedge tb_clk);
      tb_set_address_pulse_in = 1'b0;
      @(negedge tb_clk);  // Wait for one more cycle to ensure address is registered
    end
  endtask

  // Task to store a byte
  task automatic store_byte_task(input logic [7:0] byte_val);
    begin
      tb_store_byte_in = byte_val;
      tb_store_byte_pulse_in = 1'b1;
      @(negedge tb_clk);
      tb_store_byte_pulse_in = 1'b0;
      @(negedge tb_clk);  // Wait for one more cycle to ensure byte is stored
    end
  endtask

  // Task to check the full memory content
  task automatic check_memory_content(input logic [MEMORY_WIDTH_BYTES * 8 - 1:0] expected_memory);
    begin
      if (tb_memory_out == expected_memory) begin
        $display("  [PASS] %s: Memory content matches expected.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Memory content mismatch. Expected: %H, Got: %H", tb_test_case,
                 expected_memory, tb_memory_out);
      end
    end
  endtask

  // Task to check the byte at the current address
  task automatic check_memory_at_address(input logic [7:0] expected_byte);
    begin
      if (tb_memory_at_address_out == expected_byte) begin
        $display("  [PASS] %s: Byte at current address matches expected.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Byte at current address mismatch. Expected: %H, Got: %H",
                 tb_test_case, expected_byte, tb_memory_at_address_out);
      end
    end
  endtask

  // Test Cases
  task automatic test_power_on_reset();
    begin
      tb_test_case = "Power on Reset";
      tb_test_num++;

      reset_dut();
      @(negedge tb_clk);
      if (tb_address_out == '0 && tb_memory_out == '0) begin
        $display("  [PASS] %s: Initial address and memory are zero.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Initial address or memory not zero. Address: %H, Memory: %H",
                 tb_test_case, tb_address_out, tb_memory_out);
      end
    end
  endtask

  task automatic test_store_single_byte();
    begin
      tb_test_case = "Store Single Byte";
      tb_test_num++;

      reset_dut();
      store_byte_task(8'hAA);  // Store AA at address 0, address becomes 1
      // Now set address back to 0 to read the stored byte
      set_address_task(AddressWidth'('d0));
      @(negedge tb_clk);  // Wait for address to be set
      if (tb_address_out == 0 && tb_memory_at_address_out == 8'hAA) begin
        $display("  [PASS] %s: Stored byte and address incremented.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Failed to store byte or increment address. Address: %H, Byte: %H",
                 tb_test_case, tb_address_out, tb_memory_at_address_out);
      end
      check_memory_content({{(MEMORY_WIDTH_BYTES * 8 - 8) {1'b0}}, 8'hAA});  // Check full memory
    end
  endtask

  task automatic test_store_multiple_bytes_auto_increment();
    begin
      tb_test_case = "Store Multiple Bytes (Auto-Increment)";
      tb_test_num++;

      reset_dut();
      store_byte_task(8'h11);  // Addr 0
      store_byte_task(8'h22);  // Addr 1
      store_byte_task(8'h33);  // Addr 2
      @(negedge tb_clk);
      if (tb_address_out == 3) begin
        $display("  [PASS] %s: Address auto-incremented correctly.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Address auto-increment failed. Expected: 3, Got: %H", tb_test_case,
                 tb_address_out);
      end
      check_memory_content({{(MEMORY_WIDTH_BYTES * 8 - 24) {1'b0}}, 8'h33, 8'h22, 8'h11});
    end
  endtask

  task automatic test_set_address_and_store();
    begin
      tb_test_case = "Set Address and Store";
      tb_test_num++;

      reset_dut();
      store_byte_task(8'h11);  // Addr 0
      store_byte_task(8'h22);  // Addr 1
      set_address_task(AddressWidth'('d5));  // Set address to 5
      store_byte_task(8'hFF);  // Store FF at address 5
      @(negedge tb_clk);
      if (tb_address_out == 6) begin
        $display("  [PASS] %s: Address set and byte stored correctly.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Address set and store failed. Expected address: 6, Got: %H",
                 tb_test_case, tb_address_out);
      end
      // Expected memory: ...FF00002211 (FF at index 5, 22 at 1, 11 at 0)
      check_memory_content(
          {{(MEMORY_WIDTH_BYTES * 8 - 48) {1'b0}}, 8'hFF, {(3 * 8) {1'b0}}, 8'h22, 8'h11});
    end
  endtask

  task automatic test_read_at_address();
    begin
      tb_test_case = "Read at Address";
      tb_test_num++;

      reset_dut();
      store_byte_task(8'h11);  // Addr 0
      store_byte_task(8'h22);  // Addr 1
      store_byte_task(8'h33);  // Addr 2
      set_address_task(AddressWidth'('d1));  // Set address to 1
      @(negedge tb_clk);
      check_memory_at_address(8'h22);  // Should read 22
      set_address_task(AddressWidth'('d0));  // Set address to 0
      @(negedge tb_clk);
      check_memory_at_address(8'h11);  // Should read 11
    end
  endtask

  task automatic test_memory_rollover();
    begin
      tb_test_case = "Memory Rollover";
      tb_test_num++;

      reset_dut();
      // Fill memory to trigger rollover if AUTO_INCREMENT_ADDRESS is true
      for (int i = 0; i < MEMORY_WIDTH_BYTES; i++) begin
        store_byte_task(8'h00 + i);
      end
      @(negedge tb_clk);
      if (tb_address_out == 0) begin  // Should roll over to 0
        $display("  [PASS] %s: Address rolled over to 0.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Address rollover failed. Expected: 0, Got: %H", tb_test_case,
                 tb_address_out);
      end
      // Store one more byte to check if it writes to address 0
      store_byte_task(8'hFF);
      @(negedge tb_clk);
      if (tb_address_out == 1) begin
        $display("  [PASS] %s: Stored byte at rolled over address 0.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Failed to store byte at rolled over address 0. Address: %H",
                 tb_test_case, tb_address_out);
      end
      set_address_task(AddressWidth'('d0));
      @(negedge tb_clk);
      check_memory_at_address(8'hFF);  // Check if FF is at address 0
    end
  endtask


  // Clock generation block
  always begin
    #(CLK_PERIOD / 2.0);
    tb_clk = !tb_clk;
  end

  // Signal dump
  initial begin
    $dumpfile("support/waves/stream_cipher/memory_block.vcd");
    $dumpvars;
  end

  // DUT Instantiation
  memory_block #(
      .MEMORY_WIDTH_BYTES(MEMORY_WIDTH_BYTES),
      .AUTO_INCREMENT_ADDRESS(AUTO_INCREMENT_ADDRESS)
  ) dut (
      .clk(tb_clk),
      .nrst(tb_nrst),
      .store_byte_in(tb_store_byte_in),
      .store_byte_pulse_in(tb_store_byte_pulse_in),
      .set_address_in(tb_set_address_in),
      .set_address_pulse_in(tb_set_address_pulse_in),
      .memory_out(tb_memory_out),
      .memory_at_address_out(tb_memory_at_address_out),
      .received_byte_pulse_out(tb_received_byte_pulse_out),
      .received_address_pulse_out(tb_received_address_pulse_out),
      .address_out(tb_address_out)
  );

  // Test bench main process
  initial begin
    // Initialize all of the test inputs here
    tb_clk = 0;
    tb_nrst = 1;
    tb_store_byte_in = '0;
    tb_store_byte_pulse_in = '0;
    tb_set_address_in = '0;
    tb_set_address_pulse_in = '0;

    tb_test_num = 0;
    tb_passed = 0;

    test_power_on_reset();
    test_store_single_byte();
    test_store_multiple_bytes_auto_increment();
    test_set_address_and_store();
    test_read_at_address();
    test_memory_rollover();

    $display("\nTotal Test Cases: %1d, Total Checks Passed: %1d\n", tb_test_num, tb_passed);
    $finish;

  end

endmodule
