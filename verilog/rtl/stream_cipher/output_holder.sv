module output_holder (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Inputs from interface fsm
    input types_pkg::interface_state_t interface_state,

    // Inputs from Encryption Block
    input logic encrypted_byte_pulse_in,
    input logic [7:0] encrypted_byte_in,
    input logic read_iv_standard_pulse_in,
    input types_pkg::chacha_setup_standard_t iv_standard_in,
    input logic read_hash_iterations_pulse_in,
    input types_pkg::chacha_iterations_t hash_iterations_in,
    input logic read_hash_state_address_pulse_in,
    input types_pkg::chacha_hash_state_addr_t hash_state_address_in,
    input logic read_hash_state_at_address_pulse_in,
    input logic [7:0] hash_state_at_address_in,

    // Inputs from Key Memory
    input logic key_read_byte_at_address_pulse_in,
    input logic [7:0] key_memory_at_address_in,
    input logic key_read_address_pulse_in,
    input logic [4:0] key_address_in,  // KeyAddressWidth = 5

    // Inputs from Nonce Memory
    input logic nonce_read_byte_at_address_pulse_in,
    input logic [7:0] nonce_memory_at_address_in,
    input logic nonce_read_address_pulse_in,
    input logic [3:0] nonce_address_in,  // NonceAddressWidth = 4

    // Inputs from Block Counter
    input logic block_counter_read_byte_at_address_pulse_in,
    input logic [7:0] block_counter_memory_at_address_in,
    input logic block_counter_read_address_pulse_in,
    input logic [2:0] block_counter_address_in,  // BlockCounterAddressWidth = 3

    // Inputs from Command Center
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
  assign combined_pulse = encrypted_byte_pulse_in |
                          read_iv_standard_pulse_in |
                          read_hash_iterations_pulse_in |
                          read_hash_state_address_pulse_in |
                          read_hash_state_at_address_pulse_in |
                          key_read_byte_at_address_pulse_in |
                          key_read_address_pulse_in |
                          nonce_read_byte_at_address_pulse_in |
                          nonce_read_address_pulse_in |
                          block_counter_read_byte_at_address_pulse_in |
                          block_counter_read_address_pulse_in |
                          command_center_read_mode_pulse_in;

  // Chained ternary for data_out
  logic [7:0] selected_data;

  assign selected_data = (
    (encrypted_byte_pulse_in ? encrypted_byte_in : 8'h00) |
    (read_iv_standard_pulse_in ? 8'h00 + iv_standard_in : 8'h00) | // Cast enum to 8-bit
      (read_hash_iterations_pulse_in ? 8'h00 + hash_iterations_in : 8'h00) |  // Cast to 8-bit
      (read_hash_state_address_pulse_in ? 8'h00 + hash_state_address_in : 8'h00) |  // Cast to 8-bit
      (read_hash_state_at_address_pulse_in ? hash_state_at_address_in : 8'h00) |
    (key_read_byte_at_address_pulse_in ? key_memory_at_address_in : 8'h00) |
    (key_read_address_pulse_in ? 8'h00 + key_address_in : 8'h00) | // Cast to 8-bit
      (nonce_read_byte_at_address_pulse_in ? nonce_memory_at_address_in : 8'h00) |
    (nonce_read_address_pulse_in ? 8'h00 + nonce_address_in : 8'h00) | // Cast to 8-bit
      (block_counter_read_byte_at_address_pulse_in ? block_counter_memory_at_address_in : 8'h00) |
    (block_counter_read_address_pulse_in ? 8'h00 + block_counter_address_in : 8'h00) | // Cast to 8-
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
