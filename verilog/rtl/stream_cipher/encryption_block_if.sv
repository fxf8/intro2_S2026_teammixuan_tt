package encryption_block_pkg;

  logic                                     message_byte_pulse_in;
  logic                               [7:0] message_byte_in;

  logic                                     read_iv_standard_pulse;
  logic                                     write_iv_standard_pulse_in;
  types_pkg::chacha_setup_standard_t        write_iv_standard_in;

  logic                                     read_hash_iterations_pulse;
  logic                                     write_hash_iterations_pulse_in;
  types_pkg::chacha_iterations_t            write_hash_iterations_in;

  logic                                     read_hash_state_address_pulse;
  logic                                     write_hash_state_address_pulse_in;
  types_pkg::chacha_hash_state_addr_t       write_hash_state_address_in;

  logic                                     read_hash_state_at_address_pulse;
  logic                                     reset_hash_pulse_in;

  // Outputs from Encryption Block
  logic                                     encrypted_byte_pulse_out;
  logic                               [7:0] encrypted_byte_out;

  types_pkg::chacha_setup_standard_t        iv_standard_out;
  types_pkg::chacha_iterations_t            hash_iterations_out;
  types_pkg::chacha_hash_state_addr_t       hash_state_address_out;
  logic                               [7:0] hash_state_at_address_out;

endpackage