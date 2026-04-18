// Note: The purpose of this module is to convert the edge-sensitive 4 phase
// handshake input to a single-cycle pulse

module reader (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Data inputs (received from chip pins)
    input logic [7:0] input_byte_in,
    input logic command_in,

    // Handshake Management Inputs (received from chip pins)
    input logic input_request,

    // FSM State (received from fsm state block)
    input types_pkg::interface_state_t interface_fsm_state_in,

    // Signals sent to the command center
    output logic [7:0] input_byte_pulsed_out,  // This is the input byte that *gets pulsed*
    output logic command_pulsed_out,
    output logic pulse_out
);
  typedef types_pkg::interface_state_t interface_state_t;

  assign input_byte_pulsed_out = input_byte_in;
  assign command_pulsed_out = command_in;

  logic pulse;
  assign pulse_out = pulse;
  logic next_pulse;

  always_comb begin
    next_pulse = 0;

    if (interface_fsm_state_in == types_pkg::I_IDLE && input_request) begin
      next_pulse = 1;
    end
  end

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin

    end else begin
      pulse <= next_pulse;
    end
  end
endmodule
