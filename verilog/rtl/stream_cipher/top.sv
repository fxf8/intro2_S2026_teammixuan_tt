// List of commands
//  1. Switch to Encrypt Byte Mode (code: 0) (each later byte input is encrypted)
//  2. IV Setup Standard (ivsetup, itef_ivsetup) (types_pkg::chacha_setup_standard_t)
//      a. Read (code: 1)
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
  typedef types_pkg::interface_state_t interface_state_t;
  typedef types_pkg::chacha_setup_standard_t chacha_setup_standard_t;
  typedef types_pkg::chacha_iterations_t chacha_iterations_t;
  typedef types_pkg::chacha_byte_t chacha_byte_t;
  typedef types_pkg::chacha_nonce_addr_t chacha_nonce_addr_t;
  typedef types_pkg::chacha_key_addr_t chacha_key_addr_t;
  typedef types_pkg::chacha_block_counter_addr_t chacha_block_counter_addr_t;
  typedef types_pkg::chacha_hash_state_addr_t chacha_hash_state_addr_t;
  typedef types_pkg::cmd_mode_t cmd_mode_t;

  // Interface FSM driven nets ----- "i_"
  interface_state_t i_interface_state;

  // Reader driven nets ----- "r_"
  logic [7:0] r_input_byte_pulsed_out;
  logic r_command_pulsed_out;
  logic r_pulse_out;

  // Command center driven nets ----- "c_"
  // Sent to Hash Generator
  logic c_message_byte_pulse_out;
  logic [7:0] c_message_byte_out;

  interface_fsm interface_fsm_inst (
      .clk(clk),
      .nrst(nrst),
      .input_request_in(),
      .output_acknowledge_in(),
      .output_holder_state_in(),
      .interface_state_out()
  );

  reader reader_inst ();

  command_center command_center_inst ();

  memory_block key_memory_inst ();
  memory_block nonce_memory_inst ();
  block_counter block_counter_inst ();

  encryption_block encryption_block_inst ();

  output_holder output_holder_inst ();
endmodule

