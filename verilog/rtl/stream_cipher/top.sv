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
      .fsm_state(),

      // Signals sent to the data router
      .input_byte_pulsed(),
      .is_key_pulsed(),
      .input_byte_pulse(),

      // Signal sent to the hash generator
      .reset_hash_pulse()
  );

  interface_fsm interface_fsm_inst (
      .clk (clk),
      .nrst(nrst),

      // Handshake signals
      .input_request(input_request),
      .output_acknowledge(output_acknowledge),
      .output_is_ready(output_byte_is_ready),

      .interface_state_out()
  );

  data_router data_router_inst (
      .clk (clk),
      .nrst(nrst),

      // Inputs received from reader
      .input_byte_pulsed(),
      .is_key_pulsed(),
      .input_pulse(),

      // Signals sent to the key storage
      .key_byte(),
      .key_byte_pulse(),

      // Signals sent to the encryption block
      .byte_pulsed(),
      .byte_pulse ()
  );

  key_storage key_storage_inst (
      .clk (clk),
      .nrst(nrst),

      // Inputs received from the data router
      .key_byte(),
      .key_byte_pulse(),

      // Output sent to the hash generator
      .key_memory_out()
  );

  hash_generator hash_generator_inst (
      .clk (clk),
      .nrst(nrst),

      .reset_hash(),

      // Input received from key storage
      .key_memory(),

      // Input received from encryption block
      .request_hash_byte_pulse(),

      // Signals sent to encryption block
      .hash_byte_out(),
      .hash_byte_pulse_out(),
      .generator_current_state_out()
  );

  encryption_block encryption_block_inst (
      .clk (clk),
      .nrst(nrst),

      // Inputs received from the data router
      .byte_in(),
      .byte_in_pulse(),

      // Hash generator pins:

      // This pin allows us to know when this block can request a hashed byte
      .hash_generator_state(),

      .request_byte_pulse_out(),

      .hash_byte(),
      .hash_byte_pulse(),

      // Pulsed output sent to output holder
      .encrypted_byte_out(),
      .encrypted_byte_pulse_out(),

      // General purpose output state
      .encryption_block_state_out()
  );

  output_holder output_holder_inst (
      .clk (clk),
      .nrst(nrst),

      // Inputs received from encryption block
      .data_in(),
      .data_in_pulse(),

      // Inputs received from interface fsm
      .interface_state(),

      // Output sent to interface fsm
      .output_holder_state_out(),

      // Output sent to output mux
      .data_out()
  );

  output_mux output_mux_inst (
      .data_in(),
      .output_holder_state(),

      // Inputs received from interface fsm
      .interface_state(),

      // Outputs sent to the output of the chip
      .data_out(output_byte),
      .output_byte_is_ready(output_byte_is_ready),
      // Note: `output_bte_is_rady` stays high until the chip user specifies the output has been read (using the output_acknowledge pin)

      .input_acknowledged(input_acknowledged)
  );

endmodule

