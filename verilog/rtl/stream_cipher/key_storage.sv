module key_storage #(
    //parameters here
) (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Inputs received from the data router
    input logic [7:0] key_byte,
    input logic key_byte_pulse,

    // Output sent to the hash generator
    output logic [127:0] key_memory
);
  //module code here
  // assign a = clk && nrst;

endmodule
