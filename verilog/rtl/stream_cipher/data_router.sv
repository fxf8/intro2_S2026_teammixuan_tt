module data_router #(
    //parameters here
) (
    input logic clk,
    nrst,  //clock and negative-edge reset
    //other signals here

    // Inputs received from reader
    input logic [7:0] input_byte_pulsed,
    input logic is_key_pulsed,
    input logic input_pulse,

    // Signals sent to the key storage
    output logic [7:0] key_byte,
    output logic key_byte_pulse,

    // Signals sent to the encryption block
    output logic [7:0] byte_pulsed,
    output logic byte_pulse

);
  //module code here
  // assign a = clk && nrst;

endmodule
