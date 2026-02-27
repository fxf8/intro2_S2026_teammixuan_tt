// XTEA Algorithm: https://en.wikipedia.org/wiki/XTEA
// Note, the values of `v` in the document mentioned above will be computed
// using v[0] = previous v[0] (initial value is currently planned to be the
// XTEA Delta derived from the golden ratio: 32'h9e3779b9)
// v[1] = 32 bit counted value

typedef enum {
  EMPTY,  // The initial ground state when no hash is computed
  READY,  // When the hash is computed and the marker is not at the end of the buffer
  QUERRIED,  // When a hashed byte has been requested
  EXHAUSTED,  // When the marker has reached the end of the buffer

  // When the marker has reached the end of the buffer *AND* a hashed byte has been requested
  QUERRIED_EXHAUSTED
} hash_generator_state_t;

typedef enum {
  EMPTY,  // The starting initial state when no hash is computed
  READY,  // When the hash is computed and the marker is within the hashed bounds
  CALCULATING  // When the hash is being computed
} next_hash_state_t;

module hash_generator #(
    parameter int HASH_ITERATIONS = 8
) (
    input logic clk,
    nrst,  //clock and negative-edge reset
    //other signals here

    // Input receivd from key storage
    input logic [127:0] key_memory,

    // Input received from encryption block
    input logic request_hash_byte_pulse,

    // Signals sent to encryption block
    output logic [7:0] hash_byte_out,
    output logic hash_byte_pulse_out,
    output hash_generator_state_t generator_current_state_out
);
  localparam int HashByteCount = 64 / 8;  // 64 / 8 = 8
  localparam int XTEADelta = 32'H9E3779B9;

  // Current hash served to the user ----
  hash_generator_state_t generator_current_state;
  assign generator_current_state_out = generator_current_state;

  hash_generator_state_t generator_next_state;

  logic hash_byte_pulse;
  assign hash_byte_pulse_out = hash_byte_pulse;

  logic [ 2:0] hash_byte_out_index;  // This is used to index for providing the correct output.
  // Hash has 64 bits (8 bytes). 8 possible states requires 3 bits. Therefore,
  // `hash_byte_index` needs 3 bits. If hash_byte_index is 3'b111, then the
  // current state is EXHAUSTED and the hash must be recomputed.

  logic [63:0] hash;

  assign hash_byte_out = hash[hash_byte_out_index*8+:8];

  // Values used to compute the next hash ----
  next_hash_state_t next_hash_current_state;
  next_hash_state_t next_hash_next_state;

  logic [63:0] next_hash;

  wire v0_next = next_hash[63:32];
  wire v1_next = next_hash[31:0];

  logic [31:0] sum;
  // Total amount of hashes computed. This is assigned to the initial v0 when
  // computing next_hash
  logic [31:0] hashed_count;

  // Start of 3-Block FSM for the hash generator

  // State transition setter for the hash generator
  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      generator_current_state <= EMPTY;

    end else begin
      generator_current_state <= generator_next_state;
    end
  end

  // State transition logic for the hash generator
  always_comb begin
    // Default case
    generator_next_state = generator_current_state;

    unique case (generator_current_state)
      EMPTY: begin
        if (next_hash_current_state == READY) begin
          // In this scenario, the next hash is ready and will be assigned
          // to the current hash
          generator_next_state = READY;
        end
      end

      READY: begin
        if (request_hash_byte_pulse) begin
          if (hash_byte_out_index < HashByteCount - 1) begin
            generator_next_state = QUERRIED;

          end else begin
            generator_next_state = QUERRIED_EXHAUSTED;
          end
        end
      end

      QUERRIED: begin
        generator_next_state = READY;
      end

      // Since this state is reached when the index is at the last point, the
      // last byte will be pulsed and the state will be transitioned to
      // EXHAUSTED wherein the next hash will be computed
      QUERRIED_EXHAUSTED: begin
        if (next_hash_current_state == READY) begin
          generator_next_state = EXHAUSTED;
        end
      end

      EXHAUSTED: begin
        if (next_hash_current_state == READY) begin
          generator_next_state = READY;
        end
      end
    endcase
  end

  // Action block for the generator
  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      hash_byte_pulse <= 0;
      hash_byte_out_index <= '0;
      hash <= '0;
      hashed_count <= 0;
    end

    hash_byte_pulse <= 0;

    unique case (generator_current_state)
      EMPTY, EXHAUSTED: begin
        if (next_hash_current_state == READY) begin
          hash <= next_hash;
          hash_byte_out_index <= 0;
        end
      end

      QUERRIED, QUERRIED_EXHAUSTED: begin
      end
    endcase
  end

  // Start of 3-Block FSM for the next hash

  // State transition setter for the next hash
  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      next_hash_current_state <= EMPTY;
    end else begin
      next_hash_current_state <= next_hash_next_state;
    end
  end

  // State transition logic for the next hash
  always_comb begin
    // Default case
    next_hash_next_state = next_hash_current_state;

    unique case (next_hash_current_state)
      EMPTY: begin
      end

      READY: begin
      end

      CALCULATING: begin
      end
    endcase
  end

  // Action block for the next hash
  always_ff @(posedge clk or negedge nrst) begin
    unique case (next_hash_current_state)
      EMPTY: begin
      end

      READY: begin
      end

      CALCULATING: begin
      end
    endcase
  end

endmodule
