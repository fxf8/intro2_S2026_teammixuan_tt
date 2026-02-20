module output_mux #(
    //parameters here
) (
    /*
    input  logic clk,
    nrst,  //clock and negative-edge reset
    */

    // Inputs from output holder
    input logic [7:0] data_in,

    // Inputs from interface fsm
    input interface_state_t interface_state,

    // Outputs sent to the output of the chip
    output logic [7:0] data_out,
    output logic output_byte_is_ready
    // Note: `output_bte_is_rady` stays high until the chip user specifies the output has been read (using the output_acknowledge pin)
);
  //module code here
  assign a = clk && nrst;

endmodule
