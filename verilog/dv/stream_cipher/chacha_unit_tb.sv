// $Id: $
// File name:   chacha_unit_tb.sv
// Created:     04/18/2026
// Author:      Gemini
// Description: Test bench for the chacha_unit module

`timescale 1ns / 10ps

module chacha_unit_tb ();

  // Import package for custom types
  import types_pkg::*;

  // Define local parameters used by the test bench
  localparam int ClkPeriod = 10;

  // Parameters for memory blocks
  localparam int KeyMemoryWidthBits = 32;
  localparam int NonceMemoryWidthBytes = 12;
  localparam int BlockCounterMemoryWidthBytes = 8;
  localparam int ChachaStateMemoryWidthBytes = 16 * 4;  // 16 words * 4 bytes/word = 64 bytes

  localparam int KeyMemoryAddressWidth = $clog2(KeyMemoryWidthBits);
  localparam int NonceMemoryAddressWidth = $clog2(NonceMemoryWidthBytes);
  localparam int BlockCounterMemoryAddressWidth = $clog2(BlockCounterMemoryWidthBytes);
  localparam int ChachaStateMemoryAddressWidth = $clog2(ChachaStateMemoryWidthBytes);

  // Control types
  typedef types_pkg::hash_generator_state_t hash_generator_state_t;
  typedef types_pkg::hash_unit_state_t hash_unit_state_t;

  // Algorithm Types
  typedef types_pkg::chacha_ctx_t chacha_ctx_t;
  typedef types_pkg::chacha_key_t chacha_key_t;
  typedef types_pkg::chacha_nonce_t chacha_nonce_t;
  typedef types_pkg::chacha_word_t chacha_word_t;
  typedef types_pkg::chacha_block_counter_t chacha_block_counter_t;
  typedef types_pkg::chacha_setup_standard_t chacha_setup_standard_t;
  typedef types_pkg::chacha_iterations_t chacha_iterations_t;
  typedef types_pkg::chacha_hash_state_addr_t chacha_hash_state_addr_t;
  typedef types_pkg::chacha_ctx_raw_t chacha_ctx_raw_t;

  // Struct for chacha_unit inputs
  typedef struct packed {
    chacha_key_t key_in;
    chacha_nonce_t nonce_in;
    chacha_block_counter_t block_counter_in;
    chacha_setup_standard_t setup_standard_in;
    chacha_iterations_t iterations_in;
  } chacha_unit_inputs_t;

  // Declare DUT portmap signals
  logic tb_clk;
  logic tb_nrst;

  logic tb_initiate_hash_pulse_in;

  chacha_unit_inputs_t tb_chacha_unit_inputs;

  hash_unit_state_t tb_hash_unit_state_out;
  logic tb_chacha_state_out;

  logic tb_reset_block_counter_pulse;
  logic tb_increment_block_counter_pulse;
  logic tb_reset_memory_pulse;

  // Signals for Key Memory Block
  logic [7:0] key_mem_store_byte_in;
  logic key_mem_store_byte_pulse_in;
  logic [KeyMemoryAddressWidth - 1:0] key_mem_set_address_in;
  logic key_mem_set_address_pulse_in;
  logic [KeyMemoryWidthBits * 8 - 1:0] key_mem_out;

  // Signals for Nonce Memory Block
  logic [7:0] nonce_mem_store_byte_in;
  logic nonce_mem_store_byte_pulse_in;
  logic [NonceMemoryAddressWidth - 1:0] nonce_mem_set_address_in;
  logic nonce_mem_set_address_pulse_in;
  logic [NonceMemoryWidthBytes * 8 - 1:0] nonce_mem_out;

  // Signals for Block Counter Memory Block
  logic [7:0] block_counter_mem_store_byte_in;
  logic block_counter_mem_store_byte_pulse_in;
  logic [BlockCounterMemoryAddressWidth - 1:0] block_counter_mem_set_address_in;
  logic block_counter_mem_set_address_pulse_in;
  logic [BlockCounterMemoryWidthBytes * 8 - 1:0] block_counter_mem_out;

  // Signals for Output ChaCha State Memory Block
  logic [7:0] output_chacha_state_mem_store_byte_in;
  logic output_chacha_state_mem_store_byte_pulse_in;
  logic [ChachaStateMemoryAddressWidth - 1:0] output_chacha_state_mem_set_address_in;
  logic output_chacha_state_mem_set_address_pulse_in;
  logic [ChachaStateMemoryWidthBytes * 8 - 1:0] output_chacha_state_mem_out;


  // Declare test bench signals
  integer tb_test_num;
  integer tb_passed;
  string tb_test_case;

  // Task for standard DUT reset procedure
  task automatic reset_dut;
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

  // Helper task to write a byte to a memory block
  task automatic write_byte_to_mem(input logic [7:0] byte_val, output logic [7:0] mem_store_byte_in,
                                   output logic mem_store_byte_pulse_in);
    begin
      mem_store_byte_in = byte_val;
      mem_store_byte_pulse_in = 1'b1;
      @(negedge tb_clk);
      mem_store_byte_pulse_in = 1'b0;
      @(negedge tb_clk);
    end
  endtask

  // Helper task to set address of the Key Memory block
  task automatic set_key_mem_address(input int addr,
                                     output logic [KeyMemoryAddressWidth - 1:0] mem_set_address_in,
                                     output logic mem_set_address_pulse_in);
    begin
      mem_set_address_in = addr;
      mem_set_address_pulse_in = 1'b1;
      @(negedge tb_clk);
      mem_set_address_pulse_in = 1'b0;
      @(negedge tb_clk);
    end
  endtask

  // Helper task to set address of the Nonce Memory block
  task automatic set_nonce_mem_address(
      input int addr, output logic [NonceMemoryAddressWidth - 1:0] mem_set_address_in,
      output logic mem_set_address_pulse_in);
    begin
      mem_set_address_in = addr;
      mem_set_address_pulse_in = 1'b1;
      @(negedge tb_clk);
      mem_set_address_pulse_in = 1'b0;
      @(negedge tb_clk);
    end
  endtask

  // Helper task to set address of the Block Counter Memory block
  task automatic set_block_counter_mem_address(
      input int addr, output logic [BlockCounterMemoryAddressWidth - 1:0] mem_set_address_in,
      output logic mem_set_address_pulse_in);
    begin
      mem_set_address_in = addr;
      mem_set_address_pulse_in = 1'b1;
      @(negedge tb_clk);
      mem_set_address_pulse_in = 1'b0;
      @(negedge tb_clk);
    end
  endtask

  // Helper task to set address of the Output ChaCha State Memory block
  task automatic set_output_chacha_state_mem_address(
      input int addr, output logic [ChachaStateMemoryAddressWidth - 1:0] mem_set_address_in,
      output logic mem_set_address_pulse_in);
    begin
      mem_set_address_in = addr;
      mem_set_address_pulse_in = 1'b1;
      @(negedge tb_clk);
      mem_set_address_pulse_in = 1'b0;
      @(negedge tb_clk);
    end
  endtask

  // Task to write the key to the key_mem
  task automatic write_key(input chacha_key_t key);
    begin
      set_key_mem_address(0, key_mem_set_address_in, key_mem_set_address_pulse_in);
      for (int i = 0; i < KeyMemoryWidthBits; i++) begin
        write_byte_to_mem(key[i], key_mem_store_byte_in, key_mem_store_byte_pulse_in);
      end
    end
  endtask

  // Task to write the nonce to the nonce_mem
  task automatic write_nonce(input chacha_nonce_t nonce, input int nonce_len_bytes);
    begin
      set_nonce_mem_address(0, nonce_mem_set_address_in, nonce_mem_set_address_pulse_in);
      for (int i = 0; i < nonce_len_bytes; i++) begin
        write_byte_to_mem(nonce[i], nonce_mem_store_byte_in, nonce_mem_store_byte_pulse_in);
      end
    end
  endtask

  // Task to write the block counter to the block_counter_mem
  task automatic write_block_counter(input chacha_block_counter_t block_counter);
    begin
      set_block_counter_mem_address(0, block_counter_mem_set_address_in,
                                    block_counter_mem_set_address_pulse_in);
      for (int i = 0; i < BlockCounterMemoryWidthBytes; i++) begin
        logic [7:0] byte_to_write;
        case (i)
          0: byte_to_write = block_counter[7:0];
          1: byte_to_write = block_counter[15:8];
          2: byte_to_write = block_counter[23:16];
          3: byte_to_write = block_counter[31:24];
          4: byte_to_write = block_counter[39:32];
          5: byte_to_write = block_counter[47:40];
          6: byte_to_write = block_counter[55:48];
          7: byte_to_write = block_counter[63:56];
          default: byte_to_write = '0;  // Should not happen
        endcase
        write_byte_to_mem(byte_to_write, block_counter_mem_store_byte_in,
                          block_counter_mem_store_byte_pulse_in);
      end
    end
  endtask

  

  task automatic capture_chacha_state();
    begin
      logic [511:0] chacha_state_packed;
      set_output_chacha_state_mem_address(0, output_chacha_state_mem_set_address_in,
                                          output_chacha_state_mem_set_address_pulse_in);

      // Pack the unpacked chacha_state_out into a packed array
      for (int k = 0; k < 16; k++) begin
        chacha_state_packed[k*32+:32] = tb_chacha_state_out[k];
      end

      for (int i = 0; i < 16; i++) begin  // 16 words
        for (int j = 0; j < 4; j++) begin  // 4 bytes per word
          logic [7:0] byte_to_write;
          byte_to_write = chacha_state_packed[(i*4 + j)*8+:8]; // Access byte from packed array
          write_byte_to_mem(byte_to_write, output_chacha_state_mem_store_byte_in,
                            output_chacha_state_mem_store_byte_pulse_in);
        end
      end
    end
  endtask

  // Task to initiate hash and wait for ready state
  task automatic initiate_hash();
    begin
      tb_initiate_hash_pulse_in = 1'b1;
      @(negedge tb_clk);
      tb_initiate_hash_pulse_in = 1'b0;
      @(negedge tb_clk);
      // Wait for the unit to become ready
      while (tb_hash_unit_state_out != U_READY) begin
        @(negedge tb_clk);
      end
      @(negedge tb_clk);  // One more cycle to ensure stability
    end
  endtask

  // Test Cases
  task automatic test_power_on_reset();
    string current_state_name;
    begin
      tb_test_case = "Power on Reset";
      tb_test_num++;

      reset_dut();
      @(negedge tb_clk);
      case (tb_hash_unit_state_out)
        U_INITIAL: current_state_name = "U_INITIAL";
        U_CONTEXT_LOADING: current_state_name = "U_CONTEXT_LOADING";
        U_COLUMN_ROUND: current_state_name = "U_COLUMN_ROUND";
        U_DIAGONAL_ROUND: current_state_name = "U_DIAGONAL_ROUND";
        U_FINAL_ROUND: current_state_name = "U_FINAL_ROUND";
        U_READY: current_state_name = "U_READY";
        default: current_state_name = "UNKNOWN";
      endcase
      if (tb_hash_unit_state_out == U_INITIAL) begin
        $display("  [PASS] %s: Initial state is U_INITIAL.", tb_test_case);
        tb_passed++;
      end else begin
        $display("  [FAIL] %s: Initial state is %s, expected U_INITIAL.", tb_test_case,
                 current_state_name);
      end
    end
  endtask

  task automatic test_chacha_djb_hash();
    chacha_key_t test_key;
    chacha_nonce_t test_nonce;
    chacha_block_counter_t test_block_counter;
    chacha_ctx_t expected_chacha_state;
    string current_state_name;

    begin
      tb_test_case = "ChaCha DJB Hash";
      tb_test_num++;

      reset_dut();

      // Example values (these are placeholders, actual ChaCha outputs need to be verified)
      for (int i = 0; i < KeyMemoryWidthBits; i++) begin
        test_key[i] = i;
      end
      for (int i = 0; i < 8; i++) begin  // DJB uses 8-byte nonce
        test_nonce[i] = i;
      end
      test_block_counter = 64'h0000000000000001;  // Counter = 1

      write_key(test_key);
      write_nonce(test_nonce, 8);  // DJB uses 8-byte nonce
      write_block_counter(test_block_counter);

      tb_chacha_unit_inputs.setup_standard_in = S_DJB;
      tb_chacha_unit_inputs.iterations_in = 40;  // Standard 20 rounds (40 half-rounds)

      initiate_hash();

      case (tb_hash_unit_state_out)
        U_INITIAL: current_state_name = "U_INITIAL";
        U_CONTEXT_LOADING: current_state_name = "U_CONTEXT_LOADING";
        U_COLUMN_ROUND: current_state_name = "U_COLUMN_ROUND";
        U_DIAGONAL_ROUND: current_state_name = "U_DIAGONAL_ROUND";
        U_FINAL_ROUND: current_state_name = "U_FINAL_ROUND";
        U_READY: current_state_name = "U_READY";
        default: current_state_name = "UNKNOWN";
      endcase
      // For now, just check if it reached READY state and capture output
      if (tb_hash_unit_state_out == U_READY) begin
        $display("  [PASS] %s: ChaCha unit reached U_READY state.", tb_test_case);
        tb_passed++;
        capture_chacha_state();
        $display("  [INFO] %s: Captured ChaCha state to memory block.", tb_test_case);
      end else begin
        $display("  [FAIL] %s: ChaCha unit did not reach U_READY state. Current state: %s",
                 tb_test_case, current_state_name);
      end

      // TODO: Add actual expected_chacha_state comparison here using known test vectors
    end
  endtask

  task automatic test_chacha_ietf_hash();
    chacha_key_t test_key;
    chacha_nonce_t test_nonce;
    chacha_block_counter_t test_block_counter;
    chacha_ctx_t expected_chacha_state;
    string current_state_name;

    begin
      tb_test_case = "ChaCha IETF Hash";
      tb_test_num++;

      reset_dut();

      // Example values (these are placeholders, actual ChaCha outputs need to be verified)
      for (int i = 0; i < KeyMemoryWidthBits; i++) begin
        test_key[i] = i;
      end
      for (int i = 0; i < 12; i++) begin  // 12 bytes used for IETF
        test_nonce[i] = i;
      end
      test_block_counter = 64'h0000000100000000;  // Counter = 1

      write_key(test_key);
      write_nonce(test_nonce, 12);  // IETF uses 12-byte nonce
      write_block_counter(test_block_counter);

      tb_chacha_unit_inputs.setup_standard_in = S_ITEF;
      tb_chacha_unit_inputs.iterations_in = 40;  // Standard 20 rounds (40 half-rounds)

      initiate_hash();

      case (tb_hash_unit_state_out)
        U_INITIAL: current_state_name = "U_INITIAL";
        U_CONTEXT_LOADING: current_state_name = "U_CONTEXT_LOADING";
        U_COLUMN_ROUND: current_state_name = "U_COLUMN_ROUND";
        U_DIAGONAL_ROUND: current_state_name = "U_DIAGONAL_ROUND";
        U_FINAL_ROUND: current_state_name = "U_FINAL_ROUND";
        U_READY: current_state_name = "U_READY";
        default: current_state_name = "UNKNOWN";
      endcase
      // For now, just check if it reached READY state and capture output
      if (tb_hash_unit_state_out == U_READY) begin
        $display("  [PASS] %s: ChaCha unit reached U_READY state.", tb_test_case);
        tb_passed++;
        capture_chacha_state();
        $display("  [INFO] %s: Captured ChaCha state to memory block.", tb_test_case);
      end else begin
        $display("  [FAIL] %s: ChaCha unit did not reach U_READY state. Current state: %s",
                 tb_test_case, current_state_name);
      end

      // TODO: Add actual expected_chacha_state comparison here using known test vectors
    end
  endtask


  // Clock generation block
  always begin
    #(ClkPeriod / 2.0);
    tb_clk = !tb_clk;
  end

  // Signal dump
  initial begin
    $dumpfile("support/waves/stream_cipher/chacha_unit.vcd");
    $dumpvars;
  end

  // DUT Instantiation
  chacha_unit dut (
      .clk(tb_clk),
      .nrst(tb_nrst),
      .initiate_hash_pulse_in(tb_initiate_hash_pulse_in),
      .key_in(tb_chacha_unit_inputs.key_in),
      .nonce_in(tb_chacha_unit_inputs.nonce_in),
      .block_counter_in(tb_chacha_unit_inputs.block_counter_in),
      .setup_standard_in(tb_chacha_unit_inputs.setup_standard_in),
      .iterations_in(tb_chacha_unit_inputs.iterations_in),
      .hash_unit_state_out(tb_hash_unit_state_out),
      .chacha_state_out(tb_chacha_state_out)
  );

  // Memory Block Instantiations
  memory_block #(
      .MEMORY_WIDTH_BYTES(KeyMemoryWidthBits),
      .AUTO_INCREMENT_ADDRESS(1)
  ) key_mem (
      .clk(tb_clk),
      .nrst(tb_nrst),
      .store_byte_in(key_mem_store_byte_in),
      .store_byte_pulse_in(key_mem_store_byte_pulse_in),
      .set_address_in(key_mem_set_address_in),
      .set_address_pulse_in(key_mem_set_address_pulse_in),
      .reset_memory_pulse_in(tb_reset_memory_pulse), // New port
      .memory_out(tb_chacha_unit_inputs.key_in),  // Connect memory output to DUT input
      .memory_at_address_out(),
      .received_byte_pulse_out(),
      .received_address_pulse_out(),
      .address_out()
  );

  memory_block #(
      .MEMORY_WIDTH_BYTES(NonceMemoryWidthBytes),
      .AUTO_INCREMENT_ADDRESS(1)
  ) nonce_mem (
      .clk(tb_clk),
      .nrst(tb_nrst),
      .store_byte_in(nonce_mem_store_byte_in),
      .store_byte_pulse_in(nonce_mem_store_byte_pulse_in),
      .set_address_in(nonce_mem_set_address_in),
      .set_address_pulse_in(nonce_mem_set_address_pulse_in),
      .reset_memory_pulse_in(tb_reset_memory_pulse), // New port
      .memory_out(tb_chacha_unit_inputs.nonce_in),  // Connect memory output to DUT input
      .memory_at_address_out(),
      .received_byte_pulse_out(),
      .received_address_pulse_out(),
      .address_out()
  );

  block_counter #(
      .MEMORY_WIDTH_BYTES(BlockCounterMemoryWidthBytes),
      .AUTO_INCREMENT_ADDRESS(1)
  ) block_counter_mem (
      .clk(tb_clk),
      .nrst(tb_nrst),
      .store_byte_in(block_counter_mem_store_byte_in),
      .store_byte_pulse_in(block_counter_mem_store_byte_pulse_in),
      .set_address_in(block_counter_mem_set_address_in),
      .set_address_pulse_in(block_counter_mem_set_address_pulse_in),
      .reset_memory_pulse_in(tb_reset_block_counter_pulse),
      .increment_block_counter_pulse_in(tb_increment_block_counter_pulse),
      .memory_out(tb_chacha_unit_inputs.block_counter_in),  // Connect memory output to DUT input
      .memory_at_address_out(),
      .received_byte_pulse_out(),
      .received_address_pulse_out(),
      .address_out()
  );

  memory_block #(
      .MEMORY_WIDTH_BYTES(ChachaStateMemoryWidthBytes),
      .AUTO_INCREMENT_ADDRESS(1)
  ) output_chacha_state_mem (
      .clk(tb_clk),
      .nrst(tb_nrst),
      .store_byte_in(output_chacha_state_mem_store_byte_in),
      .store_byte_pulse_in(output_chacha_state_mem_store_byte_pulse_in),
      .set_address_in(output_chacha_state_mem_set_address_in),
      .set_address_pulse_in(output_chacha_state_mem_set_address_pulse_in),
      .reset_memory_pulse_in(tb_reset_memory_pulse), // New port
      .memory_out(),
      .memory_at_address_out(),
      .received_byte_pulse_out(),
      .received_address_pulse_out(),
      .address_out()
  );


  // Test bench main process
  initial begin
    // Initialize all of the test inputs here
    tb_clk = 0;
    tb_nrst = 1;
    tb_initiate_hash_pulse_in = 0;
    tb_chacha_unit_inputs.setup_standard_in = S_DJB;
    tb_chacha_unit_inputs.iterations_in = 0;
    tb_chacha_unit_inputs.key_in = '0; // Initialize all members
    tb_chacha_unit_inputs.nonce_in = '0;
    tb_chacha_unit_inputs.block_counter_in = '0;

    tb_reset_block_counter_pulse = 0;
    tb_increment_block_counter_pulse = 0;
    tb_reset_memory_pulse = 0;

    // Initialize memory block control signals
    key_mem_store_byte_in = '0;
    key_mem_store_byte_pulse_in = '0;
    key_mem_set_address_in = '0;
    key_mem_set_address_pulse_in = '0;

    nonce_mem_store_byte_in = '0;
    nonce_mem_store_byte_pulse_in = '0;
    nonce_mem_set_address_in = '0;
    nonce_mem_set_address_pulse_in = '0;

    block_counter_mem_store_byte_in = '0;
    block_counter_mem_store_byte_pulse_in = '0;
    block_counter_mem_set_address_in = '0;
    block_counter_mem_set_address_pulse_in = '0;

    output_chacha_state_mem_store_byte_in = '0;
    output_chacha_state_mem_store_byte_pulse_in = '0;
    output_chacha_state_mem_set_address_in = '0;
    output_chacha_state_mem_set_address_pulse_in = '0;


    tb_test_num = 0;
    tb_passed = 0;

    test_power_on_reset();
    test_chacha_djb_hash();
    test_chacha_ietf_hash();

    $display("\nTotal Test Cases: %1d, Total Checks Passed: %1d\n", tb_test_num, tb_passed);
    $finish;

  end

endmodule
