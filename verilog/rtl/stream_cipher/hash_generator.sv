module hash_generator #(
    parameter int DEFAULT_HASH_ITERATIONS = 20
) (
    input logic clk,
    nrst,  //clock and negative-edge reset
    //other signals here

    // Configuration (received from respective memory blocks)
    input types_pkg::chacha_key_t key_in,
    input types_pkg::chacha_nonce_t nonce_in,
    input types_pkg::chacha_block_counter_t block_counter_in,

    // Sent to output holder
    output types_pkg::chacha_setup_standard_t iv_standard_out,

    // Received from command center
    input logic write_iv_standard_pulse_in,
    input types_pkg::chacha_setup_standard_t write_iv_standard_in,

    // Sent to output holder (confirmation of writing to output holder)
    output logic write_iv_standard_pulse_out,

    // Received from command cetner
    input logic write_hash_iterations_pulse_in,
    input types_pkg::chacha_iterations_t write_hash_iterations_in,

    // Sent to output holder (confirmation of writing to output holder)
    output logic write_hash_iterations_pulse_out

    // Received from command center
);

endmodule

