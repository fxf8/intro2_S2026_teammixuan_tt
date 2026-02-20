module hash_generator #(
    //parameters here
) (
    input logic clk,
    nrst,  //clock and negative-edge reset
    //other signals here

    // Input receivd from key storage
    input logic [127:0] key_memory,

    // Input received from encryption block
    input logic request_hash_byte_pulse,

    // Signals sent to encryption block
    output logic [7:0] hash_byte,
    output logic hash_byte_pulse
);
  //module code here
  // assign a = clk && nrst;

endmodule
