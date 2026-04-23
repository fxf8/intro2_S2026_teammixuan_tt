// Note about pulse signals: A pulse will never be sent during an ongoing
// operation
import encryption_block_pkg::*;

module encryption_block #(
    parameter types_pkg::chacha_iterations_t DEFAULT_HASH_ITERATIONS = 20,
    parameter types_pkg::chacha_setup_standard_t DEFAULT_IV_STANDARD = types_pkg::S_DJB
) (
    input logic clk,
    nrst,  //clock and negative-edge reset
    //other signals here

    memory_block_if.memory_block_port key_memory_port,
    memory_block_if.memory_block_port nonce_memory_port,
    block_counter_if.memory_out_port block_counter_memory_port,
    block_counter_if.increment_counter_port increment_block_counter_port,

    // encryption_block_if.encryption_block_port encryption_block_port // Removed interface connection
    input logic message_byte_pulse_in,
    input logic [7:0] message_byte_in,
    input logic write_iv_standard_pulse_in,
    input types_pkg::chacha_setup_standard_t write_iv_standard_in,
    input logic write_hash_iterations_pulse_in,
    input types_pkg::chacha_iterations_t write_hash_iterations_in,
    input logic write_hash_state_address_pulse_in,
    input types_pkg::chacha_hash_state_addr_t write_hash_state_address_in,
    input logic reset_hash_pulse_in,

    output logic encrypted_byte_pulse_out,
    output logic [7:0] encrypted_byte_out,
    output types_pkg::chacha_setup_standard_t iv_standard_out,
    output types_pkg::chacha_iterations_t hash_iterations_out,
    output types_pkg::chacha_hash_state_addr_t hash_state_address_out,
    output logic [7:0] hash_state_at_address_out
);
  // Control types
  typedef types_pkg::hash_generator_state_t hash_generator_state_t;
  typedef types_pkg::hash_unit_state_t hash_unit_state_t;

  // Algorithm Types
  typedef types_pkg::chacha_ctx_t chacha_ctx_t;
  typedef types_pkg::chacha_setup_standard_t chacha_setup_standard_t;
  typedef types_pkg::chacha_iterations_t chacha_iterations_t;
  typedef types_pkg::chacha_hash_state_addr_t chacha_hash_state_addr_t;
  typedef types_pkg::chacha_ctx_raw_t chacha_ctx_raw_t;

  // Removed local signal declarations and assignments
  // logic message_byte_pulse_in;
  // logic [7:0] message_byte_in;
  // logic write_iv_standard_pulse_in;
  // chacha_setup_standard_t write_iv_standard_in;
  // logic write_hash_iterations_pulse_in;
  // chacha_iterations_t write_hash_iterations_in;
  // logic write_hash_state_address_pulse_in;
  // chacha_hash_state_addr_t write_hash_state_address_in;
  // logic reset_hash_pulse_in;

  // assign message_byte_pulse_in = encryption_block_port.message_byte_pulse_in;
  // assign message_byte_in = encryption_block_port.message_byte_in;
  // assign write_iv_standard_pulse_in = encryption_block_port.write_iv_standard_pulse_in;
  // assign write_iv_standard_in = encryption_block_port.write_iv_standard_in;
  // assign write_hash_iterations_pulse_in = encryption_block_port.write_hash_iterations_pulse_in;
  // assign write_hash_iterations_in = encryption_block_port.write_hash_iterations_in;
  // assign write_hash_state_address_pulse_in =
  //     encryption_block_port.write_hash_state_address_pulse_in;
  // assign write_hash_state_address_in = encryption_block_port.write_hash_state_address_in;
  // assign reset_hash_pulse_in = encryption_block_port.reset_hash_pulse_in;

  // logic encrypted_byte_pulse_out;
  // logic [7:0] encrypted_byte_out;
  // chacha_setup_standard_t iv_standard_out;
  // chacha_iterations_t hash_iterations_out;
  // chacha_hash_state_addr_t hash_state_address_out;
  // logic [7:0] hash_state_at_address_out;

  logic increment_block_counter_pulse_out;

  // Removed assignments to encryption_block_port
  // assign encryption_block_port.encrypted_byte_pulse_out = encrypted_byte_pulse_out;
  // assign encryption_block_port.encrypted_byte_out = encrypted_byte_out;
  // assign encryption_block_port.iv_standard_out = iv_standard_out;
  // assign encryption_block_port.hash_iterations_out = hash_iterations_out;
  // assign encryption_block_port.hash_state_address_out = hash_state_address_out;
  // assign encryption_block_port.hash_state_at_address_out = hash_state_at_address_out;

  assign increment_block_counter_port.increment_block_counter_pulse_in =
      increment_block_counter_pulse_out;


  // State variables
  logic [7:0] buffered_message_byte;
  logic [7:0] next_buffered_message_byte;

  logic is_buffered_message_waiting;
  logic next_is_buffered_message_waiting;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      buffered_message_byte <= 0;
      is_buffered_message_waiting <= 0;

    end else begin
      buffered_message_byte <= next_buffered_message_byte;
      is_buffered_message_waiting <= next_is_buffered_message_waiting;
    end
  end

  logic encrypted_byte_pulse;
  logic next_encrypted_byte_pulse;
  assign encrypted_byte_pulse_out = encrypted_byte_pulse;

  logic initiate_hash;
  logic next_initiate_hash;

  hash_generator_state_t hash_generator_state;
  hash_generator_state_t next_hash_generator_state;

  chacha_hash_state_addr_t hash_state_address;
  chacha_hash_state_addr_t next_hash_state_address;
  assign hash_state_address_out = hash_state_address;

  chacha_ctx_t chacha_hash_state;
  chacha_ctx_t next_chacha_hash_state;
  chacha_ctx_t computed_chacha_hash_state;
  logic [7:0] hash_state_at_address;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      chacha_hash_state <= 0;

    end else begin
      chacha_hash_state <= next_chacha_hash_state;
    end
  end

  chacha_ctx_raw_t chacha_hash_state_raw;

  assign chacha_hash_state_raw = chacha_ctx_raw_t'(chacha_hash_state);
  assign hash_state_at_address = chacha_hash_state_raw[hash_state_address*8+:8];
  assign hash_state_at_address_out = hash_state_at_address;
  assign encrypted_byte_out = buffered_message_byte ^ hash_state_at_address;

  chacha_setup_standard_t iv_standard;
  chacha_setup_standard_t next_iv_standard;
  assign iv_standard_out  = iv_standard;
  assign next_iv_standard = (write_iv_standard_pulse_in) ? write_iv_standard_in : iv_standard;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      iv_standard <= DEFAULT_IV_STANDARD;
    end else begin
      iv_standard <= next_iv_standard;
    end
  end

  chacha_iterations_t hash_iterations;
  chacha_iterations_t next_hash_iterations;
  assign hash_iterations_out = hash_iterations;
  assign next_hash_iterations =
      (write_hash_iterations_pulse_in) ? write_hash_iterations_in : hash_iterations;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      hash_iterations <= DEFAULT_HASH_ITERATIONS;
    end else begin
      hash_iterations <= next_hash_iterations;
    end
  end

  hash_unit_state_t hash_unit_state;

  chacha_unit chacha_hash_unit (
      .clk(clk),
      .nrst(nrst),
      .initiate_hash_pulse_in(initiate_hash),
      .key_in(key_memory_port.memory_out),
      .nonce_in(nonce_memory_port.memory_out),
      .block_counter_in(block_counter_memory_port.memory_out),
      .setup_standard_in(iv_standard),
      .iterations_in(hash_iterations),
      .hash_unit_state_out(hash_unit_state),
      .chacha_state_out(computed_chacha_hash_state)
  );

  always_comb begin
    next_hash_generator_state = hash_generator_state;
    next_buffered_message_byte = buffered_message_byte;
    next_is_buffered_message_waiting = is_buffered_message_waiting;
    next_hash_state_address = hash_state_address;
    next_chacha_hash_state = chacha_hash_state;
    next_initiate_hash = initiate_hash;

    next_encrypted_byte_pulse = 0;
    increment_block_counter_pulse_out = 0;

    if (message_byte_pulse_in) begin
      next_buffered_message_byte = message_byte_in;
      next_is_buffered_message_waiting = 1;
    end

    if (write_hash_state_address_pulse_in) begin
      next_hash_state_address = write_hash_state_address_in;
    end

    unique case (hash_generator_state)
      types_pkg::H_INITIAL: begin
        if (message_byte_pulse_in) begin
          next_initiate_hash = 1;
          next_hash_generator_state = types_pkg::H_COMPUTING;
        end
      end

      types_pkg::H_COMPUTING: begin
        next_initiate_hash = 0;

        if (hash_unit_state == types_pkg::U_READY && !initiate_hash) begin
          next_hash_generator_state = types_pkg::H_COPYING;
        end
      end

      types_pkg::H_COPYING: begin
        next_chacha_hash_state = computed_chacha_hash_state;
        next_hash_generator_state = types_pkg::H_FINISHED_COPYING;
      end

      types_pkg::H_FINISHED_COPYING: begin
        next_initiate_hash = 1;
        next_hash_state_address = 0;
        increment_block_counter_pulse_out = 1;
        next_hash_generator_state = types_pkg::H_READY;
      end

      types_pkg::H_READY: begin
        next_initiate_hash = 0;

        if (reset_hash_pulse_in) begin
          next_hash_state_address   = 0;
          next_hash_generator_state = types_pkg::H_INITIAL;

        end else begin
          if (is_buffered_message_waiting) begin
            next_hash_state_address = hash_state_address + 1;
            next_encrypted_byte_pulse = 1;
            next_is_buffered_message_waiting = 0;

            // Check if index is at the end
            if (hash_state_address == (2 ** 6 - 1)) begin
              next_hash_generator_state = types_pkg::H_EXHAUSTED;
            end
          end
        end
      end

      types_pkg::H_EXHAUSTED: begin
        next_hash_generator_state = types_pkg::H_COMPUTING;
      end
    endcase
  end

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      hash_generator_state <= types_pkg::H_INITIAL;
      initiate_hash <= 0;
      hash_state_address <= 0;
      encrypted_byte_pulse <= 0;

    end else begin
      hash_generator_state <= next_hash_generator_state;
      initiate_hash <= next_initiate_hash;
      hash_state_address <= next_hash_state_address;
      encrypted_byte_pulse <= next_encrypted_byte_pulse;
    end
  end
endmodule
