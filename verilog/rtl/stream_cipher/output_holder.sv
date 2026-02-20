// Note: The purpose of this block is to hold the pulsed output of the chip
// for a long duration (until the user of the chip has specified that the
// output has been read).

module output_holder #(
    //parameters here
) (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Inputs from encryption block
    input logic [7:0] data_in,
    input logic data_in_pulse,

    // Inputs from interface fsm
    input interface_state_t interface_state,

    // Output sent to interface fsm
    output logic output_is_ready,  // Note: This will likely be sent by pulse

    // Output sent to output mux
    output logic [7:0] data_out
);
  //module code here
  // assign a = clk && nrst;

endmodule
