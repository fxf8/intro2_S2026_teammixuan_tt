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
  always_comb begin
    // First, ensure that pulses are default to low
    key_byte_pulse = 1'b0;
    byte_pulse = 1'b0;

    // Ensure that the outputs are default to low
    key_byte = 8'b0;
    byte_pulsed = 8'b0;

    // Direct the data to the correct module when data is received
    if (input_pulse) begin
      if (is_key_pulsed) begin
        key_byte = input_byte_pulsed;
        key_byte_pulse = 1'b1;
      end else begin
        byte_pulsed = input_byte_pulsed;
        byte_pulse  = 1'b1;
      end
    end
  end
endmodule
