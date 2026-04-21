// List of commands
//  1. Switch to Encrypt Byte Mode (code: 0) (each later byte input is encrypted)
//  2. IV Setup Standard (ivsetup, itef_ivsetup) (types_pkg::chacha_setup_standard_t)
//  a. Read (code: 1)
//      b. Write Mode (code: 10)
//  3. Hash Iterations (8 bits) (types_pkg::chacha_iterations_t)
//      a. Read (code: 11)
//      b. Write Mode (code: 100) (on next input)
//  4. Nonce Bytes (96 bits) (types_pkg::chacha_nonce_t)
//      a. Read at Address (code: 101)
//      b. Write at Address Mode (code: 110) (on next input). Successive byte inputs increment address
//  5. Nonce Bytes Address (types_pkg::chacha_nonce_addr_t)
//      a. Read (code: 111)
//      b. Write Mode (code: 1000) (on next input).
//  6. Key Bytes (256 bits) (types_pkg::chacha_key_t)
//      a. Read at Address (code: 1001)
//      b. Write at Address (code: 1010) (on next input). Successive byte inputs increment address
//  7. Key Bytes Address (5 bits) (types_pkg::chacha_key_addr_t)
//      a. Read (code: 1011)
//      b. Write Mode (code: 1100) (on next inputs)
//  8. Block Counter (64 bits)
//      a. Read (code: 1101)
//      b. Write at Address (code: 1110) (on next input) (Note: This writes
//      from LSB to MSB)
//  9. Block Counter Address (3 bits)
//      a. Read (code: 1111)
//      b. Write Mode (code: 1'0000) (on next input). Successive byte inputs increment address
//  10. Hash State Address (6 bits) (types_pkg::chacha_hash_state_address_t)
//      a. Read (code: 1'0001)
//      b. Write Mode (code: 1'0010) (on next input). Successive byte inputs increment address
//  11. Read Hash Byte in State at Address (code: 1'0011)
//  12. Start Hashing (code: 1'0100)
//  13. Reset Hash (code: 1'0101)
//  14. Read if Hash has Started (code: 1'0110)
//  15. Read Mode (code: 1'0111) (Read Mode literally means read what the
//  current mode is)

// List of modes
// 1. Encrypt Mode (each non-command input is encrypted)
// 2. IV Standard Setup Mode (each non-command sets the IV setup standard. Either DJB or RFC 7539 (ITEF))
// 3. Hash Iterations Setup Mode
// 4. Nonce Bytes Input Mode
// 5. Nonce Bytes Address Setup Mode
// 6. Key Bytes Input Mode
// 7. Key Bytes Address Setup Mode
// 8. Block Counter Input Mode
// 9. Block Counter Address Setup Mode

module top (
    input logic clk,
    nrst,  // clock and negative-edge reset
    //other signals here

    // General Data Pins
    input logic [7:0] input_byte_in,
    input logic command_in,

    // 4-Phase-Handshake Interfacing pins in order of change
    input  logic input_request_in,
    output logic input_acknowledged_out,
    output logic output_byte_is_ready_out,
    input  logic output_acknowledge_in,

    // Output Byte
    output logic [7:0] output_byte
);
  // State Enums
  typedef types_pkg::interface_state_t interface_state_t;
  typedef types_pkg::output_holder_state_t output_holder_state_t;

  // Configuration Enum
  typedef types_pkg::chacha_setup_standard_t chacha_setup_standard_t;

  // Data Denominations
  typedef types_pkg::chacha_iterations_t chacha_iterations_t;
  typedef types_pkg::chacha_byte_t chacha_byte_t;

  // Addresses
  typedef types_pkg::chacha_nonce_addr_t chacha_nonce_addr_t;
  typedef types_pkg::chacha_key_addr_t chacha_key_addr_t;
  typedef types_pkg::chacha_block_counter_addr_t chacha_block_counter_addr_t;
  typedef types_pkg::chacha_hash_state_addr_t chacha_hash_state_addr_t;

  // Commands and Modes
  typedef types_pkg::cmd_t cmd_t;
  typedef types_pkg::cmd_mode_t cmd_mode_t;

  // Interface FSM driven nets ----- "i_"
  interface_state_t i_interface_state;

  // Reader driven nets ----- "r_"
  logic [7:0] r_input_byte_pulsed;
  logic r_command_pulsed;
  logic r_pulse;

  // Command center driven nets ----- "c_"
  // Sent to Hash Generator
  logic c_message_byte_pulse;
  logic [7:0] c_message_byte;

  // Sent to Hash Generator
  logic c_read_iv_standard_pulse;

  // Sent to Hash Generator
  logic c_write_iv_standard_pulse;
  chacha_setup_standard_t c_write_iv_standard;

  // Sent to Hash Generator
  logic c_read_hash_iterations_pulse;

  // Sent to Hash Generator
  logic c_write_hash_iterations_pulse;
  chacha_iterations_t c_write_hash_iterations;

  // Sent to Nonce Storage
  logic c_read_nonce_bytes_pulse;

  // Sent to Nonce Storage
  logic c_write_nonce_byte_pulse;
  chacha_byte_t c_write_nonce_byte;

  // Sent to Nonce Storage
  logic c_read_nonce_address_pulse;

  // Sent to Nonce Storage
  logic c_write_nonce_address_pulse;
  chacha_nonce_addr_t c_write_nonce_address;

  // Sent to Key Storage
  logic c_read_key_byte_pulse;

  // Sent to Key Storage
  logic c_write_key_byte_pulse;
  chacha_byte_t c_write_key_byte;

  // Sent to Key Storage
  logic c_read_key_address_pulse;

  // Sent to Key Storage
  logic c_write_key_address_pulse;
  chacha_key_addr_t c_write_key_address;

  // Sent to Hash Generator
  logic c_read_block_counter_pulse;

  // Sent to Hash Generator
  logic c_write_block_counter_pulse;
  chacha_byte_t c_write_block_counter;

  // Sent to Block Counter
  logic c_read_block_counter_address_pulse;

  // Sent to Block Counter
  logic c_write_block_counter_address_pulse;
  chacha_block_counter_addr_t c_write_block_counter_address;

  // Sent to Hash Generator
  logic c_read_hash_state_address_pulse;

  // Sent to Hash Generator
  logic c_write_hash_state_address_pulse;
  chacha_hash_state_addr_t c_write_hash_state_address;

  // Sent to Hash Generator
  logic c_read_hash_state_at_address_pulse;

  // Sent to Hash Generator
  logic c_reset_hash_pulse;

  // Sent to Hash Generator
  logic c_read_hash_status_pulse;

  // Sent to Output Mux
  logic c_read_mode_pulse;
  // Sent to Output Mux
  cmd_mode_t c_current_mode;

  // Key Memory Driven Nets ----- "k_"
  localparam int KeyMemoryWidthBytes = 32;  // 32 bytes * (8 bits/byte) = 256 bits
  localparam int KeyMemoryAddressWidth = $clog2(KeyMemoryWidthBytes);

  logic [KeyMemoryWidthBytes * 8 - 1:0] k_key_memory;
  logic [7:0] k_key_memory_at_address;

  logic k_received_byte_pulse;
  logic k_received_address_pulse;

  logic [KeyMemoryAddressWidth - 1:0] k_address;

  // Nonce Memory Driven Nets ----- "n_"
  localparam int NonceMemoryWidthBytes = 12;  // 12 bytes * (8 bits/byte) = 96 bits
  localparam int NonceMemoryAddressWidth = $clog2(NonceMemoryWidthBytes);

  /********

  memory_block nonce_memory_inst (
      .clk (clk),
      .nrst(nrst),

      .store_byte_in(c_write_nonce_byte),
      .store_byte_pulse_in(c_write_nonce_byte_pulse),

      .set_address_in(c_write_nonce_address),
      .set_address_pulse_in(c_write_nonce_address_pulse),

      .reset_memory_pulse_in(),

      .memory_out(n_nonce_memory),
      .memory_at_address_out(n_nonce_memory_at_address_out),

      .received_byte_pulse_out(n_received_byte_pulse),
      .received_address_pulse_out(n_received_address_pulse),

      .address_out(n_address)
  );
  */

  logic [NonceMemoryWidthBytes * 8 - 1:0] n_nonce_memory;
  logic [7:0] n_nonce_memory_at_address;

  logic n_received_byte_pulse;
  logic n_received_address_pulse;

  logic [NonceMemoryAddressWidth - 1:0] n_address;

  // Block Counter Driven Nets ----- "b_"
  localparam BlockCounterMemoryWidthBytes = 8;  // 8 bytes * (8 bits/byte) = 64 bits
  localparam BlockCounterMemoryAddressWidth = $clog2(BlockCounterMemoryWidthBytes);

  /*

  block_counter #(
      .MEMORY_WIDTH_BYTES(NonceMemoryWidthBytes),
      .AUTO_INCREMENT_ADDRESS(1)
  ) block_counter_inst (
      .clk (clk),
      .nrst(nrst),

      .store_byte_in(c_write_block_counter),
      .store_byte_pulse_in(c_write_block_counter_pulse),

      .set_address_in(c_write_block_counter_address),
      .set_address_pulse_in(c_write_block_counter_address_pulse),

      .reset_memory_pulse_in(e_reset_block_counter_pulse),

      .increment_block_counter_pulse_in(e_increment_block_counter_pulse),

      .memory_out(b_block_counter_memory),
      .memory_at_address_out(b_block_counter_memory_at_address),

      .received_byte_pulse_out(b_received_block_counter_byte_pulse),
      .received_address_pulse_out(b_received_block_counter_address_pulse),

      .address_out(b_block_counter_address)
  );
  */

  logic [BlockCounterMemoryWidthBytes * 8 - 1:0] b_block_counter_memory;
  logic [7:0] b_block_counter_memory_at_address;

  logic b_received_byte_pulse;
  logic b_received_address_pulse;

  logic [BlockCounterMemoryAddressWidth - 1:0] b_address;

  // Encryption Block Driven Nets ----- "e_"
  logic [7:0] e_encrypted_byte;
  logic e_encrypted_byte_pulse;

  chacha_setup_standard_t e_iv_standard;

  chacha_setup_standard_t e_write_iv_standard_confirmation_pulse;

  logic e_write_hash_iterations_confirmation_pulse;

  chacha_iterations_t e_hash_iterations;
  logic e_read_hash_iterations_pulse;

  logic e_write_hash_state_address_confirmation_pulse;

  logic [7:0] e_hash_state_at_address;
  logic e_read_hash_state_at_address_pulse;

  logic e_increment_block_counter_pulse;
  logic e_reset_block_counter_pulse;

  // Output Holder Driven Nets ----- "o_"
  output_holder_state_t o_output_holder_state;
  interface_state_t o_interface_state;

  interface_fsm interface_fsm_inst (
      .clk (clk),
      .nrst(nrst),

      .input_request_in(input_request_in),
      .output_acknowledge_in(output_acknowledge_in),
      .output_holder_state_in(o_output_holder_state),
      .interface_state_out(i_interface_state)
  );

  reader reader_inst (
      .clk (clk),
      .nrst(nrst),

      .input_byte_in(input_byte_in),
      .command_in(command_in),
      .input_request(input_request_in),

      .interface_fsm_state_in(i_interface_state),

      .input_byte_pulsed_out(r_input_byte_pulsed),
      .command_pulsed_out(r_command_pulsed),
      .pulse_out(r_pulse)
  );

  command_center command_center_inst (
      .clk (clk),
      .nrst(nrst),

      .pulse_in(r_pulse),
      .command_in(r_command_pulsed),
      .input_byte_in(r_input_byte_pulsed),

      .message_byte_pulse_out(c_message_byte_pulse),
      .message_byte_out(c_message_byte),

      .read_iv_standard_pulse_out(c_read_iv_standard_pulse),
      .write_iv_standard_pulse_out(c_write_iv_standard_pulse),
      .write_iv_standard_out(c_write_iv_standard),

      .read_hash_iterations_pulse_out(c_read_hash_iterations_pulse),
      .write_hash_iterations_pulse_out(c_write_hash_iterations_pulse),
      .write_hash_iterations_out(c_write_hash_iterations),

      .read_nonce_bytes_pulse_out(c_read_nonce_bytes_pulse),
      .write_nonce_byte_pulse_out(c_write_nonce_byte_pulse),
      .write_nonce_byte_out(c_write_nonce_byte),

      .read_nonce_address_pulse_out(c_read_nonce_address_pulse),
      .write_nonce_address_pulse_out(c_write_nonce_address_pulse),
      .write_nonce_address_out(c_write_nonce_address),

      .read_key_byte_pulse_out(c_read_key_byte_pulse),
      .write_key_byte_pulse_out(c_write_key_byte_pulse),
      .write_key_byte_out(c_write_key_byte),

      .read_key_address_pulse_out(c_read_key_address_pulse),
      .write_key_address_pulse_out(c_write_key_address_pulse),
      .write_key_address_out(c_write_key_address),

      .read_block_counter_pulse_out(c_read_block_counter_pulse),
      .write_block_counter_pulse_out(c_write_block_counter_pulse),
      .write_block_counter_out(c_write_block_counter),

      .read_block_counter_address_pulse_out(c_read_block_counter_address_pulse),
      .write_block_counter_address_pulse_out(c_write_block_counter_address_pulse),
      .write_block_counter_address_out(c_write_block_counter_address),

      .read_hash_state_address_pulse_out(c_read_hash_state_address_pulse),
      .write_hash_state_address_pulse_out(c_write_hash_state_address_pulse),
      .write_hash_state_at_address_out(c_write_hash_state_address),

      .read_hash_state_at_address_pulse_out(c_read_hash_state_at_address_pulse),

      .reset_hash_pulse_out(c_reset_hash_pulse),
      .read_hash_status_pulse_out(c_read_hash_status_pulse),

      .read_mode_pulse_out(c_read_mode_pulse),
      .current_mode_out(c_current_mode)
  );

  memory_block #(
      .MEMORY_WIDTH_BYTES(KeyMemoryWidthBytes),
      .AUTO_INCREMENT_ADDRESS(1)
  ) key_memory_inst (
      .clk (clk),
      .nrst(nrst),

      .store_byte_in(c_write_key_byte),
      .store_byte_pulse_in(c_write_key_byte_pulse),

      .set_address_in(c_write_key_address),
      .set_address_pulse_in(c_write_key_address_pulse),

      .reset_memory_pulse_in(),

      .memory_out(k_key_memory),
      .memory_at_address_out(k_key_memory_at_address_out),

      .received_byte_pulse_out(k_received_byte_pulse),
      .received_address_pulse_out(k_received_address_pulse),

      .address_out(k_address)
  );

  memory_block #(
      .MEMORY_WIDTH_BYTES(NonceMemoryWidthBytes),
      .AUTO_INCREMENT_ADDRESS(1)
  ) nonce_memory_inst (
      .clk (clk),
      .nrst(nrst),

      .store_byte_in(c_write_nonce_byte),
      .store_byte_pulse_in(c_write_nonce_byte_pulse),

      .set_address_in(c_write_nonce_address),
      .set_address_pulse_in(c_write_nonce_address_pulse),

      .reset_memory_pulse_in(),

      .memory_out(n_nonce_memory),
      .memory_at_address_out(n_nonce_memory_at_address),

      .received_byte_pulse_out(n_received_byte_pulse),
      .received_address_pulse_out(n_received_address_pulse),

      .address_out(n_address)
  );

  block_counter #(
      .MEMORY_WIDTH_BYTES(BlockCounterMemoryWidthBytes),
      .AUTO_INCREMENT_ADDRESS(1)
  ) block_counter_inst (
      .clk (clk),
      .nrst(nrst),

      .store_byte_in(c_write_block_counter),
      .store_byte_pulse_in(c_write_block_counter_pulse),

      .set_address_in(c_write_block_counter_address),
      .set_address_pulse_in(c_write_block_counter_address_pulse),

      .reset_memory_pulse_in(e_reset_block_counter_pulse),

      .increment_block_counter_pulse_in(e_increment_block_counter_pulse),

      .memory_out(b_block_counter_memory),
      .memory_at_address_out(b_block_counter_memory_at_address),

      .received_byte_pulse_out(b_received_byte_pulse),
      .received_address_pulse_out(b_received_address_pulse),

      .address_out(b_address)
  );

  encryption_block encryption_block_inst (
      .clk (clk),
      .nrst(nrst),

      .message_byte_pulse_in(c_message_byte_pulse),
      .message_byte_in(c_message_byte),

      .encrypted_byte_out(e_encrypted_byte),
      .encrypted_byte_pulse_out(e_encrypted_byte_pulse),

      .key_in(k_key_memory),
      .nonce_in(n_nonce_memory),
      .block_counter_in(b_block_counter_memory),

      .iv_standard_out(e_iv_standard_out),

      .write_iv_standard_pulse_in(c_write_iv_standard_pulse),
      .write_iv_standard_in(c_write_iv_standard),

      .write_iv_standard_pulse_out(e_write_iv_standard_pulse),

      .write_hash_iterations_pulse_in(c_write_hash_iterations_pulse),
      .write_hash_iterations_in(c_write_hash_iterations),

      .write_hash_iterations_pulse_out(e_write_hash_iterations_pulse),

      .read_hash_iterations_pulse_in(c_read_hash_iterations_pulse),

      .hash_iterations_out(e_hash_iterations_out),
      .read_hash_iterations_pulse_out(e_read_hash_iterations_pulse),

      .write_hash_state_address_pulse_in(c_write_hash_state_address_pulse),
      .write_hash_state_address_in(c_write_hash_state_address),

      .write_hash_state_address_pulse_out(e_write_hash_state_address_pulse),

      .read_hash_state_at_address_pulse_in(c_read_hash_state_at_address_pulse),

      .hash_state_at_address_out(e_hash_state_at_address_out),
      .read_hash_state_at_address_pulse_out(e_read_hash_state_at_address_pulse),

      .reset_hash_pulse_in(c_reset_hash_pulse),

      .increment_block_counter_pulse_out(e_increment_block_counter_pulse),
      .reset_block_counter_pulse_out(e_reset_block_counter_pulse),
  );

  output_holder output_holder_inst ();
endmodule

