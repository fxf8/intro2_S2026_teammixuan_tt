import types_pkg::*;

module top #(
    //parameters here
) (
    input logic clk,
    nrst,  // clock and negative-edge reset
    //other signals here

    // General Data Pins
    input logic [7:0] input_byte,
    input logic is_key,
    input logic reset_hash,

    // 4-Phase-Handshake Interfacing pins in order of change
    input  logic input_request,
    output logic input_acknowledged,
    output logic output_byte_is_ready,
    input  logic output_acknowledge,

    // Output Byte
    input logic [7:0] output_byte
);
  // Outputs from the reader module
  logic [7:0] reader_input_byte_pulsed;
  logic reader_is_key_pulsed;
  logic reader_input_byte_pulse;
  logic reader_reset_hash_pulse;

  // Output from the interface FSM
  interface_state_t interface_state;

  // Output pins from the data router
  logic [7:0] data_router_key_byte;
  logic data_router_key_byte_pulse;
  logic [7:0] data_router_byte_pulsed;
  logic data_router_byte_pulse;

  // Output from the key storage
  logic [127:0] key_memory;

  // Outputs from the hash generator
  logic [7:0] hash_byte;
  logic hash_byte_pulse;
  hash_generator_state_t hash_generator_state;

  // Outputs from the encryption block
  logic request_byte_pulse;
  logic [7:0] encrypted_byte;
  logic encrypted_byte_pulse;
  encryption_block_state_t encryption_block_state;

  // Outputs from the output holder
  output_holder_state_t output_holder_state;
  output logic [7:0] output_holder_data_out;

  // Hardware block instantiations

  reader reader_inst (
      .clk (clk),
      .nrst(nrst),

      // Data inputs
      .input_byte(input_byte),
      .is_key(is_key),
      .reset_hash(reset_hash),

      // Handshake Management Inputs
      .input_request(input_request),

      // FSM State (received from fsm state block)
      .fsm_state(interface_state),

      // Signals sent to the data router
      .input_byte_pulsed(reader_input_byte_pulsed),
      .is_key_pulsed(reader_is_key_pulsed),
      .input_byte_pulse(reader_input_byte_pulse),

      // Signal sent to the hash generator
      .reset_hash_pulse(reader_reset_hash_pulse)
  );

  interface_fsm interface_fsm_inst (
      .clk (clk),
      .nrst(nrst),

      // Handshake signals
      .input_request(input_request),
      .output_acknowledge(output_acknowledge),
      .output_is_ready(),  // Note: This is received from `output_holder`

      .interface_state_out(interface_state)
  );

  data_router data_router_inst (
      .clk (clk),
      .nrst(nrst),

      // Inputs received from reader
      .input_byte_pulsed(reader_input_byte_pulsed),
      .is_key_pulsed(reader_is_key_pulsed),
      .input_pulse(reader_input_byte_pulse),

      // Signals sent to the key storage
      .key_byte(data_router_key_byte),
      .key_byte_pulse(data_router_key_byte_pulse),

      // Signals sent to the encryption block
      .byte_pulsed(data_router_byte_pulsed),
      .byte_pulse (data_router_byte_pulse)
  );

  key_storage #(16) key_storage_inst (
      .clk (clk),
      .nrst(nrst),

      // Inputs received from the data router
      .key_byte(data_router_key_byte),
      .key_byte_pulse(data_router_key_byte_pulse),

      // Output sent to the hash generator
      .key_memory_out(key_memory)
  );


  hash_generator hash_generator_inst (
      .clk (clk),
      .nrst(nrst),

      .reset_hash(reader_reset_hash_pulse),

      // Input received from key storage
      .key_memory(key_memory),

      // Input received from encryption block
      .request_hash_byte_pulse(),

      // Signals sent to encryption block
      .hash_byte_out(hash_byte),
      .hash_byte_pulse_out(hash_byte_pulse),
      .generator_current_state_out(hash_generator_state)
  );

  encryption_block encryption_block_inst (
      .clk (clk),
      .nrst(nrst),

      // Inputs received from the data router
      .byte_in(data_router_byte_pulsed),
      .byte_in_pulse(data_router_byte_pulse),

      // Hash generator pins:

      // This pin allows us to know when this block can request a hashed byte
      .hash_generator_state(hash_generator_state),

      .request_byte_pulse_out(request_byte_pulse),

      .hash_byte(hash_byte),
      .hash_byte_pulse(hash_byte_pulse),

      // Pulsed output sent to output holder
      .encrypted_byte_out(encrypted_byte),
      .encrypted_byte_pulse_out(encrypted_byte_pulse),

      // General purpose output state
      .encryption_block_state_out(encryption_block_state)
  );

  output_holder output_holder_inst (
      .clk (clk),
      .nrst(nrst),

      // Inputs received from encryption block
      .data_in(encrypted_byte),
      .data_in_pulse(encrypted_byte_pulse),

      // Inputs received from interface fsm
      .interface_state(interface_state),

      // Output sent to interface fsm
      .output_holder_state_out(output_holder_state),

      // Output sent to output mux
      .data_out(output_holder_data_out)
  );

  output_mux output_mux_inst (
      .data_in(output_holder_data_out),
      .output_holder_state(output_holder_state),

      // Inputs received from interface fsm
      .interface_state(interface_state),

      // Outputs sent to the output of the chip
      .data_out(output_byte),
      .output_byte_is_ready(output_byte_is_ready),
      // Note: `output_bte_is_rady` stays high until the chip user specifies the output has been read (using the output_acknowledge pin)

      .input_acknowledged(input_acknowledged)
  );

endmodule

