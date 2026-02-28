// XTEA Algorithm: https://en.wikipedia.org/wiki/XTEA
// Note, the values of `v` in the document mentioned above will be computed
// using v[0] = previous v[0] (initial value is currently planned to be the
// XTEA Delta derived from the golden ratio: 32'h9e3779b9)
// v[1] = 32 bit counted value

import types_pkg::hash_generator_state_t;

module hash_generator #(
    parameter int HASH_ITERATIONS = 8
) (
    input logic clk,
    nrst,  //clock and negative-edge reset
    //other signals here

    input logic reset_hash,

    // Input receivd from key storage
    input logic [127:0] key_memory,

    // Input received from encryption block
    input logic request_hash_byte_pulse,

    // Signals sent to encryption block
    output logic [7:0] hash_byte_out,
    output logic hash_byte_pulse_out,
    output hash_generator_state_t generator_current_state_out
);
  typedef enum {
    IDLE,  // The starting initial state when no hash is computed
    READY,  // When the hash is computed and the marker is within the hashed bounds
    CALCULATING  // When the hash is being computed
  } computed_hash_state_t;

  // This is the amount of bytes in the hash
  localparam int HashByteCount = 64 / 8;  // 64 / 8 = 8
  // Magic number for the XTEA algorithm
  localparam int XTEADelta = 32'H9E3779B9;

  // Current hash served to the user ----
  hash_generator_state_t generator_current_state;
  assign generator_current_state_out = generator_current_state;

  hash_generator_state_t generator_next_state;

  logic hash_byte_pulse;
  logic next_hash_byte_pulse;
  assign hash_byte_pulse_out = hash_byte_pulse;

  logic [ 2:0] hash_byte_out_index;  // This is used to index for providing the correct output.
  // Hash has 64 bits (8 bytes). 8 possible states requires 3 bits. Therefore,
  // `hash_byte_index` needs 3 bits. If hash_byte_index is 3'b111, then the
  // current state is EXHAUSTED and the hash must be recomputed.
  logic [ 2:0] next_hash_byte_out_index;

  // This is the hash that is outputted
  logic [63:0] served_hash;
  logic [63:0] next_served_hash;

  assign hash_byte_out = served_hash[hash_byte_out_index*8+:8];

  // This is the number hash that is currently being served
  logic [31:0] hash_number;
  logic [31:0] next_hash_number;

  // Values used to compute the next hash ----
  computed_hash_state_t computed_hash_state;
  computed_hash_state_t next_computed_hash_state;

  logic [31:0] v0;
  logic [31:0] v1;

  logic [31:0] next_v0;
  logic [31:0] next_v1;

  // Essentially, this is the hash that is in progress of being computed
  logic [63:0] computed_hash;
  assign computed_hash = {v0, v1};

  logic [31:0] sum;
  logic [31:0] next_sum;

  localparam int IterationCountWidth = $clog2(HASH_ITERATIONS);

  logic [IterationCountWidth-1:0] iteration_count;
  logic [IterationCountWidth-1:0] next_iteration_count;

  // Total amount of hashes computed. This is assigned to the initial v0 when
  // computing next_hash
  logic [31:0] hash_computations_count;
  logic [31:0] next_hash_computations_count;

  // Start of 3-Block FSM for the hash generator

  // State setter for the hash generator
  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst || reset_hash) begin
      generator_current_state <= hash_generator_state_t::GROUND;
      hash_byte_pulse <= 0;
      hash_byte_out_index <= '0;
      served_hash <= '0;
      hash_number <= '0;

    end else begin
      generator_current_state <= generator_next_state;
      hash_byte_pulse <= next_hash_byte_pulse;
      hash_byte_out_index <= next_hash_byte_out_index;
      served_hash <= next_served_hash;
      hash_number <= next_hash_number;
    end
  end

  // State transition logic for the hash generator
  always_comb begin
    // Default values
    generator_next_state = generator_current_state;

    unique case (generator_current_state)
      hash_generator_state_t::GROUND: begin
        if (request_hash_byte_pulse) begin
          generator_next_state = hash_generator_state_t::FIRST_QUERRY;
        end
      end

      hash_generator_state_t::FIRST_QUERRY: begin
        if (computed_hash_state == computed_hash_state::READY) begin
          generator_next_state = hash_generator_state_t::QUERRIED;
        end
      end

      hash_generator_state_t::READY: begin
        if (request_hash_byte_pulse) begin
          generator_next_state = hash_generator_state_t::QUERRIED;
        end
      end

      hash_generator_state_t::QUERRIED: begin
        generator_next_state = hash_generator_state_t::PULSE_OUT;
      end

      hash_generator_state_t::PULSE_OUT: begin
        if (hash_byte_out_index < HashByteCount) begin
          generator_next_state = hash_generator_state_t::READY;

        end else begin
          generator_next_state = hash_generator_state_t::EXHAUSTED;
        end
      end

      hash_generator_state_t::EXHAUSTED: begin
        if (computed_hash_state == computed_hash_state::READY) begin
          generator_next_state = hash_generator_state_t::READY;
        end
      end

      default: begin
      end
    endcase
  end

  // Logic for next_hash_byte_pulse and next_hash_byte_out_index
  always_comb begin
    next_hash_byte_pulse = 0;
    next_hash_byte_out_index = hash_byte_out_index;

    case (generator_current_state)
      hash_generator_state_t::QUERRIED: begin
        next_hash_byte_pulse = 1;
      end

      hash_generator_state_t::PULSE_OUT: begin
        // At this point, hash_byte_pulse should be 1, then by the next clock
        // cycle, it will be zero

        next_hash_byte_out_index = hash_byte_out_index + 1;
      end

      hash_generator_state_t::EXHAUSTED: begin
        if (computed_hash_state == computed_hash_state::READY) begin
          next_hash_byte_out_index = '0;
        end
      end

      default: begin
      end
    endcase
  end

  // Logic for next_hash and next_hash_number
  always_comb begin
    next_served_hash = served_hash;
    next_hash_number = hash_number;

    if (
        generator_current_state == hash_generator_state_t::EXHAUSTED &&
        computed_hash_state == computed_hash_state::READY
    ) begin
      next_served_hash = computed_hash;
      next_hash_number = hash_number + 1;
    end
  end

  // Start of 3-Block FSM for the next hash

  // State transition setter for the next hash
  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst || reset_hash) begin
      computed_hash_state <= computed_hash_state::IDLE;
      v0 <= '0;
      v1 <= '0;
      sum <= '0;
      iteration_count <= '0;
      hash_computations_count <= '0;

    end else begin
      computed_hash <= next_computed_hash;
      computed_hash_state <= next_computed_hash_state;
      v0 <= next_v0;
      v1 <= next_v1;
      sum <= next_sum;
      iteration_count <= next_iteration_count;
      hash_computations_count <= next_hash_computations_count;
    end
  end

  // State transition logic for the next computed hash state
  always_comb begin
    // Default case
    next_computed_hash_state = computed_hash_state;

    unique case (computed_hash_state)
      computed_hash_state::IDLE: begin
        if (generator_current_state == hash_generator_state_t::FIRST_QUERRY) begin
          next_computed_hash_state = computed_hash_state::CALCULATING;
        end
      end

      computed_hash_state::CALCULATING: begin
        if (iteration_count >= HASH_ITERATIONS) begin
          next_computed_hash_state = computed_hash_state::READY;
        end
      end

      computed_hash_state::READY: begin
        if (hash_number >= hash_computations_count) begin
          // If the hash_number is equal to the amount of hashes computed,
          // that means we can start computing the next hash since it means
          // that the generator has already coped the computed hash to the
          // served hash. Similarily, if the hash_computations_count is more
          // than hash_number, we cannot compute the next hash since some
          // some hashes would be skipped
          next_computed_hash_state = computed_hash_state::CALCULATING;
        end
      end

      default: begin
      end
    endcase
  end

  // This block is the combinational circuit to compute a round of the XTEA
  // hash. This is the logic for next_v0, next_v1, and next_sum
  always_comb begin
    next_v0  = v0;
    next_v1  = v1;
    next_sum = sum;

    if (computed_hash_state == computed_hash_state::CALCULATING) begin
      if (iteration_count == 0) begin
        if (hash_computations_count == 0) begin
          // Initialize values for hash here for the first hash computation

          next_v0 = XTEADelta;
          next_v1 = hash_computations_count;
          sum = '0;

        end else begin
          // Initialize values for hash here for the rest of the hash
          // computations

          next_v0 = v0 ^ v1;
          next_v1 = hash_computations_count;
          sum = '0;
        end
      end

      next_v0 = v0 + ((((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + key_memory[(sum&2'b11)*32+:32]));

      // Step 2: Update sum (XTEA updates sum between v0 and v1)
      next_sum = sum + XTEADelta;

      // Step 3: Update v1 using the NEW v0 and NEW sum
      next_v1 = v1 + (
          (((next_v0 << 4) ^ (next_v0 >> 5)) + next_v0) ^
          (next_sum + key_memory[((next_sum >> 11) & 2'b11) * 32+:32])
        );
    end
  end

  // Logic for iteration_count, next_hash_computations_count
  always_comb begin
    case (computed_hash_state)
      computed_hash_state::CALCULATING: begin
        // Apply one round of the XTEA algorithm here

        // Note: this is the complement of the condition to transition from
        // CALCULATING to READY
        if (iteration_count < HASH_ITERATIONS) begin
          next_iteration_count = iteration_count + 1;

        end else begin
          next_iteration_count = '0;
          next_hash_computations_count = hash_computations_count + 1;
        end
      end

      default: begin
      end
    endcase
  end

endmodule

