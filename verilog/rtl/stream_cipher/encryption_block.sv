module encryption_block #(
    //parameters here
) (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Inputs received from the data router
    input logic [7:0] byte_in,
    input logic byte_in_pulse,

    // Hash generator pins
    output logic request_byte_pulse,
    input logic [7:0] hash_byte,
    input logic hash_byte_pulse,

    // Pulsed output sent to output holder
    output logic [7:0] encrypted_byte,
    output logic encrypted_byte_pulse
);
  //module code here
  // assign a = clk && nrst;

endmodule
