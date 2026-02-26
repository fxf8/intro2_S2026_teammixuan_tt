// Note: The purpose of this module is to convert the edge-sensitive 4 phase
// handshake input to a single-cycle pulse

module reader #(
    //parameters here
) (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Data inputs (received from chip pins)
    input logic [7:0] input_byte,
    input logic is_key,
    input logic reset_hash,

    // Handshake Management Inputs (received from chip pins)
    input logic input_request,

    // FSM State (received from fsm state block)
    input interface_state_t fsm_state,

    // Signals sent to the data router
    output logic [7:0] input_byte_pulsed_out,  // This is the input byte that *gets pulsed*
    output logic is_key_pulsed_out,
    output logic input_byte_pulse_out,  // This is the pulse used to communicate the 2 outputs above

    // Signal sent to the hash generator
    output logic reset_hash_pulse_out
);
  logic [7:0] input_byte_pulsed;  // Flipflop to store the input byte that gets pulsed
  assign input_byte_pulsed_out = input_byte_pulsed;

  logic is_key_pulsed;
  assign is_key_pulsed_out = is_key_pulsed;

  logic input_byte_pulse;
  assign input_byte_pulse_out = input_byte_pulse;

  logic reset_hash_pulse;
  assign reset_hash_pulse_out = reset_hash_pulse;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      input_byte_pulsed <= 1'b0;
      is_key_pulsed <= 1'b0;
      input_byte_pulse <= 1'b0;
      reset_hash_pulse <= 1'b0;
    end else begin
      // First, ensure that pulses are reset to low
      input_byte_pulsed <= 1'b0;
      is_key_pulsed <= 1'b0;

      if (fsm_state == IDLE && input_request) begin
        // Only perform one action at a time (avoid overlapping actions).
        // Different actions will have different precedences.
        // The precedence of each actions the user can perform is as follows:
        // 1. Reset Hash
        // 2. Input Byte

        // Reset Hash Case
        if (reset_hash) begin
          reset_hash_pulse <= 1'b1;
        end  // Input Byte Case

        else begin
          input_byte_pulsed <= input_byte;
          is_key_pulsed <= is_key;
          input_byte_pulse <= 1'b1;
        end
      end
    end
  end
endmodule
