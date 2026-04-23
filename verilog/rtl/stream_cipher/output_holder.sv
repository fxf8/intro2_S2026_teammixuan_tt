// Import the package for types and enums
import encryption_block_pkg::*;

module output_holder (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Inputs from interface fsm
    input types_pkg::interface_state_t interface_state,

    // Interfaces
    memory_block_if.output_holder_read_byte_at_address key_memory_read_byte_port,
    memory_block_if.output_holder_read_address key_memory_read_address_port,
    memory_block_if.output_holder_read_byte_at_address nonce_memory_read_byte_port,
    memory_block_if.output_holder_read_address nonce_memory_read_address_port,
    block_counter_if.output_holder_read_byte_at_address block_counter_read_byte_port,
    block_counter_if.output_holder_read_address block_counter_read_address_port,

    // Inputs from Command Center (no specific interface modport found)
    input logic command_center_read_mode_pulse_in,
    input types_pkg::cmd_mode_t command_mode_in,

    // Output sent to interface fsm
    output types_pkg::output_holder_state_t output_holder_state_out,

    // Output sent to output mux
    output logic [7:0] data_out
);

  typedef types_pkg::output_holder_state_t output_holder_state_t;
  typedef types_pkg::interface_state_t interface_state_t;

  logic [7:0] data_buffer;
  assign data_out = data_buffer;
  output_holder_state_t output_holder_state;

  // Combined pulse for data_in_pulse equivalent
  logic combined_pulse;
  assign combined_pulse = encrypted_byte_pulse_out |
                          read_iv_standard_pulse |
                          read_hash_iterations_pulse |
                          read_hash_state_address_pulse |
                          read_hash_state_at_address_pulse |
                          key_memory_read_byte_port.read_byte_at_address_pulse |
                          key_memory_read_address_port.read_address_pulse |
                          nonce_memory_read_byte_port.read_byte_at_address_pulse |
                          nonce_memory_read_address_port.read_address_pulse |
                          block_counter_read_byte_port.read_byte_at_address_pulse |
                          block_counter_read_address_port.read_address_pulse |
                          command_center_read_mode_pulse_in;

  // Chained ternary for data_out
  logic [7:0] selected_data;

  assign selected_data = (
    (encrypted_byte_pulse_out ? encrypted_byte_out : 8'h00) |
    (read_iv_standard_pulse ? 8'h00 + iv_standard_out : 8'h00) | // Cast enum to 8-bit
      (read_hash_iterations_pulse ? 8'h00 + hash_iterations_out : 8'h00) |  // Cast to 8-bit
      (read_hash_state_address_pulse ? 8'h00 + hash_state_address_out : 8'h00) |  // Cast to 8-bit
      (read_hash_state_at_address_pulse ? hash_state_at_address_out : 8'h00) |
    (key_memory_read_byte_port.read_byte_at_address_pulse ? key_memory_read_byte_port.memory_at_address_out : 8'h00) |
    (key_memory_read_address_port.read_address_pulse ? 8'h00 + key_memory_read_address_port.address_out : 8'h00) | // Cast to 8-bit
      (nonce_memory_read_byte_port.read_byte_at_address_pulse ? nonce_memory_read_byte_port.memory_at_address_out : 8'h00) |
    (nonce_memory_read_address_port.read_address_pulse ? 8'h00 + nonce_memory_read_address_port.address_out : 8'h00) | // Cast to 8-bit
      (block_counter_read_byte_port.read_byte_at_address_pulse ? block_counter_read_byte_port.memory_at_address_out : 8'h00) |
    (block_counter_read_address_port.read_address_pulse ? 8'h00 + block_counter_read_address_port.address_out : 8'h00) | // Cast to 8-
      (command_center_read_mode_pulse_in ? 8'h00 + command_mode_in : 8'h00));

  assign output_holder_state_out = output_holder_state;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      data_buffer <= '0;
      output_holder_state <= types_pkg::O_EMPTY;

    end else begin
      if (combined_pulse) begin  // Use combined_pulse here
        data_buffer <= selected_data;  // Buffer the selected data
        output_holder_state <= types_pkg::O_READY;

      end else if (interface_state == types_pkg::I_IDLE) begin
        output_holder_state <= types_pkg::O_EMPTY;
      end
    end
  end

endmodule
