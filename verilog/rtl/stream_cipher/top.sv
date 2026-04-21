// List of commands
//  1. Switch to Encrypt Byte Mode (code: 0) (each later byte input is encrypted)
//  2. IV Setup Standard (ivsetup, itef_ivsetup) (types_pkg::chacha_setup_standard_t)
//      a. Read (code: 1)
//      b. Write Mode (code: 10)
//  3. Hash Iterations (8 bits) (types_pkg::chacha_iterations_t)
//      a. Read (code: 11)
//      b. Write Mode (code: 100) (on next input)
//  4. Nonce Bytes (96 bits) (types_pkg::chacha_nonce_t)
//      a. Read at Address (code: 101)
//      b. Write at Address Mode (code: 110) (on next input). Successive byte inputs increment address
//  5. Nonce Bytes Address (types_pkg::chacha_nonce_addr_t)
//      a. Read (code: 111)
//      b. Write Mode (code: 1000) (on next input).
//  6. Key Bytes (256 bits) (types_pkg::chacha_key_t)
//      a. Read at Address (code: 1001)
//      b. Write at Address (code: 1010) (on next input). Successive byte inputs increment address
//  7. Key Bytes Address (5 bits) (types_pkg::chacha_key_addr_t)
//      a. Read (code: 1011)
//      b. Write Mode (code: 1100) (on next inputs)
//  8. Block Counter (64 bits)
//      a. Read (code: 1101)
//      b. Write at Address (code: 1110) (on next input) (Note: This writes
//      from LSB to MSB)
//  9. Block Counter Address (3 bits)
//      a. Read (code: 1111)
//      b. Write Mode (code: 1'0000) (on next input). Successive byte inputs increment address
//  10. Hash State Address (6 bits) (types_pkg::chacha_hash_state_address_t)
//      a. Read (code: 1'0001)
//      b. Write Mode (code: 1'0010) (on next input). Successive byte inputs increment address
//  11. Read Hash Byte in State at Address (code: 1'0011)
//  12. Start Hashing (code: 1'0100)
//  13. Reset Hash (code: 1'0101)
//  14. Read if Hash has Started (code: 1'0110)
//  15. Read Mode (code: 1'0111) (Read Mode literally means read what the
//  current mode is)

// List of modes
// 1. Encrypt Mode (each non-command input is encrypted)
// 2. IV Standard Setup Mode (each non-command sets the IV setup standard. Either DJB or RFC 7539 (ITEF))
// 3. Hash Iterations Setup Mode
// 4. Nonce Bytes Input Mode
// 5. Nonce Bytes Address Setup Mode
// 6. Key Bytes Input Mode
// 7. Key Bytes Address Setup Mode
// 8. Block Counter Input Mode
// 9. Block Counter Address Setup Mode

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

