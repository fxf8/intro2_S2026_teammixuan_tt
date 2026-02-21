typedef enum {
  IDLE,
  PROCESSING,
  DONE
} interface_state_t;

module interface_fsm #(
    // parameters here
) (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Handshake signals
    input logic input_request,
    input logic output_acknowledge,
    input logic output_is_ready, // This is received by the output holder block

    output interface_state_t interface_state
);
  //module code here
  // assign a = clk && nrst;

endmodule
