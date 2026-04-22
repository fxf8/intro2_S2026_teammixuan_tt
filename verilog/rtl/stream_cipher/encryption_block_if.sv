interface encryption_block_if;
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

  // --- Modports ---

  // Command Center
  modport command_center_port(
      output message_byte_pulse_in,
      output message_byte_in,
      output write_iv_standard_pulse_in,
      output write_iv_standard_in,
      output write_hash_iterations_pulse_in,
      output write_hash_iterations_in,
      output write_hash_state_address_pulse_in,
      output write_hash_state_address_in,
      output read_iv_standard_pulse,
      output read_hash_iterations_pulse,
      output read_hash_state_address_pulse,
      output read_hash_state_at_address_pulse,
      output reset_hash_pulse_in
  );

  // Encryption Block
  modport encryption_block_port(
      input message_byte_pulse_in,
      input message_byte_in,
      input write_iv_standard_pulse_in,
      input write_iv_standard_in,
      input write_hash_iterations_pulse_in,
      input write_hash_iterations_in,
      input write_hash_state_address_pulse_in,
      input write_hash_state_address_in,
      input reset_hash_pulse_in,
      output encrypted_byte_pulse_out,
      output encrypted_byte_out,
      output iv_standard_out,
      output hash_iterations_out,
      output hash_state_address_out,
      output hash_state_at_address_out
  );

  // Output Holder
  modport output_holder_port(
      input encrypted_byte_pulse_out,
      input encrypted_byte_out,
      input iv_standard_out,
      input hash_iterations_out,
      input hash_state_address_out,
      input hash_state_at_address_out,
      input read_iv_standard_pulse,
      input read_hash_iterations_pulse,
      input read_hash_state_address_pulse,
      input read_hash_state_at_address_pulse
  );
endinterface
