// List of commands
// 1. Switch to Encrypt Byte Mode (code: 0) (each later byte input is encrypted)
// 2. Default setup standard (ivsetup, itef_ivsetup) (types_pkg::chacha_setup_standard_t)
//  a. Read (code: 1)
//  b. Write (code: 10) (on next input)
// 3. Hash Iterations (8 bits) (types_pkg::chacha_iterations_t)
//  a. Read (code: 11)
//  b. Write (code: 100) (on next input)
// 4. Nonce Bytes (96 bits) (types_pkg::chacha_nonce_t)
//  a. Read at Index (code: 101)
//  b. Write at Index (code: 110) (on next input). Successive byte inputs increment index and write
// 5. Nonce Bytes Index (types_pkg::chacha_nonce_index_t)
//  a. Read (code: 111)
//  b. Write (code: 1000) (on next input).
// 6. Key Bytes (256 bits) (types_pkg::chacha_key_t)
//  a. Read at Index (code: 1001)
//  b. Write at Index (code: 1010) (on next input). Successive byte inputs increment index and write
// 7. Key Bytes Index (5 bits) (types_pkg::chacha_key_index_t)
//  a. Read (code: 1011)
//  b. Write (code: 1100) (on next input)
// 8. Start Hashing (code: 1101)
// 9. Reset Hash (code: 1110)
// 10. Block Counter
//  a. Read (code: 1111)
//  b. Write (code: 10000) (on next input)
// 11. Read if Hash has Started (code: 10001)

module top (
    input logic clk,
    nrst,  // clock and negative-edge reset
    //other signals here

    // General Data Pins
    input logic [7:0] input_byte,
    input logic command,

    // 4-Phase-Handshake Interfacing pins in order of change
    input  logic input_request,
    output logic input_acknowledged,
    output logic output_byte_is_ready,
    input  logic output_acknowledge,

    // Output Byte
    output logic [7:0] output_byte
);
  typedef types_pkg::interface_state_t interface_state_t;
  typedef types_pkg::output_holder_state_t output_holder_state_t;

endmodule

