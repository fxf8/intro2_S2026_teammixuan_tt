// Import the package for types and enums
import encryption_block_pkg::*;

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
  typedef types_pkg::output_holder_state_t output_holder_state_t;

  // Internal Signals
  interface_state_t interface_state;
  output_holder_state_t output_holder_state;

  logic [7:0] reader_input_byte_pulsed;
  logic reader_command_pulsed;
  logic reader_pulse;

  logic [7:0] output_holder_data_out;

  // Instantiate Interfaces
  memory_block_if #(
      .MEMORY_WIDTH_BYTES(12)  // Nonce is 12 bytes (chacha_nonce_t [11:0])
  ) nonce_memory_if ();

  memory_block_if #(
      .MEMORY_WIDTH_BYTES(32)  // Key is 32 bytes (chacha_key_t [31:0])
  ) key_memory_if ();

  block_counter_if #(
      .MEMORY_WIDTH_BYTES(8)  // Block counter is 8 bytes (chacha_block_counter_t [63:0])
  ) block_counter_if_inst ();

  // Module Instantiations

  // Interface FSM
  interface_fsm interface_fsm_inst (
      .clk(clk),
      .nrst(nrst),
      .input_request_in(input_request_in),
      .output_acknowledge_in(output_acknowledge_in),
      .output_holder_state_in(output_holder_state),
      .interface_state_out(interface_state)
  );

  // Reader
  reader reader_inst (
      .clk(clk),
      .nrst(nrst),
      .input_byte_in(input_byte_in),
      .command_in(command_in),
      .input_request(input_request_in),
      .interface_fsm_state_in(interface_state),
      .input_byte_pulsed_out(reader_input_byte_pulsed),
      .command_pulsed_out(reader_command_pulsed),
      .pulse_out(reader_pulse)
  );

  // Nonce Memory Block
  memory_block #(
      .MEMORY_WIDTH_BYTES(12)
  ) nonce_memory_inst (
      .clk(clk),
      .nrst(nrst),
      .memory_block_port(nonce_memory_if)
  );

  // Key Memory Block
  memory_block #(
      .MEMORY_WIDTH_BYTES(32)
  ) key_memory_inst (
      .clk(clk),
      .nrst(nrst),
      .memory_block_port(key_memory_if)
  );

  // Block Counter
  block_counter #(
      .MEMORY_WIDTH_BYTES(8)
  ) block_counter_inst (
      .clk(clk),
      .nrst(nrst),
      .block_counter_port(block_counter_if_inst)
  );

  typedef types_pkg::cmd_mode_t cmd_mode_t;

  logic command_center_read_mode_pulse;
  cmd_mode_t command_center_current_mode;

  // Command Center
  command_center command_center_inst (
      .clk(clk),
      .nrst(nrst),
      .pulse_in(reader_pulse),
      .command_in(reader_command_pulsed),
      .input_byte_in(reader_input_byte_pulsed),

      .read_nonce_byte_at_address_port(nonce_memory_if),
      .write_nonce_byte_port(nonce_memory_if),
      .read_nonce_address_port(nonce_memory_if),
      .write_nonce_address_port(nonce_memory_if),
      .reset_nonce_memory_port(nonce_memory_if),

      .read_key_byte_at_address_port(key_memory_if),
      .write_key_byte_port(key_memory_if),
      .read_key_address_port(key_memory_if),
      .write_key_address_port(key_memory_if),
      .reset_key_memory_port(key_memory_if),

      .read_block_counter_byte_at_address_port(
          block_counter_if_inst
        ),
      .write_block_counter_port(block_counter_if_inst),
      .read_block_counter_address_port(block_counter_if_inst),
      .write_block_counter_address_port(block_counter_if_inst),
      .reset_block_counter_port(block_counter_if_inst),

      // .command_center_port(encryption_block_if_inst), // Removed interface connection
      .message_byte_pulse_in(encryption_block_pkg::message_byte_pulse_in),
      .message_byte_in(encryption_block_pkg::message_byte_in),
      .write_iv_standard_pulse_in(encryption_block_pkg::write_iv_standard_pulse_in),
      .write_iv_standard_in(encryption_block_pkg::write_iv_standard_in),
      .write_hash_iterations_pulse_in(encryption_block_pkg::write_hash_iterations_pulse_in),
      .write_hash_iterations_in(encryption_block_pkg::write_hash_iterations_in),
      .write_hash_state_address_pulse_in(encryption_block_pkg::write_hash_state_address_pulse_in),
      .write_hash_state_address_in(encryption_block_pkg::write_hash_state_address_in),
      .read_iv_standard_pulse(encryption_block_pkg::read_iv_standard_pulse),
      .read_hash_iterations_pulse(encryption_block_pkg::read_hash_iterations_pulse),
      .read_hash_state_address_pulse(encryption_block_pkg::read_hash_state_address_pulse),
      .read_hash_state_at_address_pulse(encryption_block_pkg::read_hash_state_at_address_pulse),
      .reset_hash_pulse_in(encryption_block_pkg::reset_hash_pulse_in),

      .read_mode_pulse_out(command_center_read_mode_pulse),
      .current_mode_out(command_center_current_mode)
  );

  // Encryption Block
  encryption_block encryption_block_inst (
      .clk(clk),
      .nrst(nrst),
      .key_memory_port(key_memory_if),
      .nonce_memory_port(nonce_memory_if),
      .block_counter_memory_port(block_counter_if_inst),
      .increment_block_counter_port(block_counter_if_inst),
      .message_byte_pulse_in(encryption_block_pkg::message_byte_pulse_in),
      .message_byte_in(encryption_block_pkg::message_byte_in),
      .write_iv_standard_pulse_in(encryption_block_pkg::write_iv_standard_pulse_in),
      .write_iv_standard_in(encryption_block_pkg::write_iv_standard_in),
      .write_hash_iterations_pulse_in(encryption_block_pkg::write_hash_iterations_pulse_in),
      .write_hash_iterations_in(encryption_block_pkg::write_hash_iterations_in),
      .write_hash_state_address_pulse_in(encryption_block_pkg::write_hash_state_address_pulse_in),
      .write_hash_state_address_in(encryption_block_pkg::write_hash_state_address_in),
      .reset_hash_pulse_in(encryption_block_pkg::reset_hash_pulse_in),
      .encrypted_byte_pulse_out(encryption_block_pkg::encrypted_byte_pulse_out),
      .encrypted_byte_out(encryption_block_pkg::encrypted_byte_out),
      .iv_standard_out(encryption_block_pkg::iv_standard_out),
      .hash_iterations_out(encryption_block_pkg::hash_iterations_out),
      .hash_state_address_out(encryption_block_pkg::hash_state_address_out),
      .hash_state_at_address_out(encryption_block_pkg::hash_state_at_address_out)
  );

  // Output Holder
  output_holder output_holder_inst (
      .clk(clk),
      .nrst(nrst),
      .interface_state(interface_state),

      // Interfaces
      // .encryption_block_port(encryption_block_if_inst), // Removed interface connection
      .encrypted_byte_pulse_in(encryption_block_pkg::encrypted_byte_pulse_out),
      .encrypted_byte_in(encryption_block_pkg::encrypted_byte_out),
      .read_iv_standard_pulse_in(encryption_block_pkg::read_iv_standard_pulse),
      .iv_standard_in(encryption_block_pkg::iv_standard_out),
      .read_hash_iterations_pulse_in(encryption_block_pkg::read_hash_iterations_pulse),
      .hash_iterations_in(encryption_block_pkg::hash_iterations_out),
      .read_hash_state_address_pulse_in(encryption_block_pkg::read_hash_state_address_pulse),
      .hash_state_address_in(encryption_block_pkg::hash_state_address_out),
      .read_hash_state_at_address_pulse_in(encryption_block_pkg::read_hash_state_at_address_pulse),
      .hash_state_at_address_in(encryption_block_pkg::hash_state_at_address_out),

      .key_memory_read_byte_port(key_memory_if),
      .key_memory_read_address_port(key_memory_if),
      .nonce_memory_read_byte_port(nonce_memory_if),
      .nonce_memory_read_address_port(nonce_memory_if),
      .block_counter_read_byte_port(block_counter_if_inst),
      .block_counter_read_address_port(block_counter_if_inst),

      // From Command Center
      .command_center_read_mode_pulse_in(command_center_read_mode_pulse),
      .command_mode_in(command_center_current_mode),

      // Outputs
      .output_holder_state_out(output_holder_state),
      .data_out(output_holder_data_out)
  );

  // Output Mux
  output_mux output_mux_inst (
      .data_in(output_holder_data_out),
      .output_holder_state(output_holder_state),
      .interface_state(interface_state),
      .data_out(output_byte),
      .output_byte_is_ready(output_byte_is_ready_out),
      .input_acknowledged(input_acknowledged_out)
  );

endmodule
