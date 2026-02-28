// Note: The purpose of this block is to hold the pulsed output of the chip
// for a long duration (until the user of the chip has specified that the
// output has been read).

// import types_pkg::output_holder_state_t;
// import types_pkg::interface_state_t;

typedef types_pkg::output_holder_state_t output_holder_state_t;
typedef types_pkg::interface_state_t interface_state_t;

module output_holder (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Inputs from encryption block
    input logic [7:0] data_in,
    input logic data_in_pulse,

    // Inputs from interface fsm
    input interface_state_t interface_state,

    // Output sent to interface fsm
    output output_holder_state_t output_holder_state_out,

    // Output sent to output mux
    output logic [7:0] data_out
);
  logic [7:0] data_buffer;
  assign data_out = data_buffer;

  output_holder_state_t output_holder_state;
  assign output_holder_state_out = output_holder_state;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      data_buffer <= '0;
      output_holder_state <= '0;

    end else begin
      if (data_in_pulse) begin
        data_buffer <= data_in;
        output_holder_state <= types_pkg::O_READY;

      end else if (interface_state == types_pkg::I_IDLE) begin
        output_holder_state <= types_pkg::O_EMPTY;
      end
    end
  end

endmodule
