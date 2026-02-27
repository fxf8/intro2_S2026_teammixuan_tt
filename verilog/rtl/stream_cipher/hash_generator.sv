// XTEA Algorithm: https://en.wikipedia.org/wiki/XTEA
// Note, the values of `v` in the document mentioned above will be computed
// using v[0] = previous v[0] (initial value is currently planned to be the
// XTEA Delta derived from the golden ratio: 32'h9e3779b9)
// v[1] = 32 bit counted value

typedef enum {
  GROUND,  // The initial ground state when no hash is computed

  // This is used for the first time when a hashed byte is requested
  FIRST_QUERRY,

  READY,  // When the hash is computed and the marker is not at the end of the buffer
  QUERRIED,  // When a hashed byte has been requested
  EXHAUSTED,  // When the marker has reached the end of the buffer

  // When the marker has reached the end of the buffer *AND* a hashed byte has been requested
  QUERRIED_EXHAUSTED

} hash_generator_state_t;

typedef enum {
  IDLE,  // The starting initial state when no hash is computed
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

  // This is the number hash that is currently being served
  logic [31:0] hash_number;

  assign hash_byte_out = hash[hash_byte_out_index*8+:8];

  // Values used to compute the next hash ----
  next_hash_state_t next_hash_current_state;
  next_hash_state_t next_hash_next_state;

  logic [31:0] v0_next;
  logic [31:0] v1_next;

  logic [63:0] next_hash;
  assign next_hash = {v0_next, v1_next};

  logic [31:0] sum;

  localparam int IterationCountWidth = $clog2(HASH_ITERATIONS);

  logic [IterationCountWidth-1:0] iteration_count;

  // Total amount of hashes computed. This is assigned to the initial v0 when
  // computing next_hash
  logic [31:0] hash_computations_count;

  // Start of 3-Block FSM for the hash generator

  // State transition setter for the hash generator
  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      generator_current_state <= GROUND;

    end else begin
      generator_current_state <= generator_next_state;
    end
  end

  // State transition logic for the hash generator
  always_comb begin
    // Default case
    generator_next_state = generator_current_state;

    unique case (generator_current_state)
      GROUND: begin
        if (request_hash_byte_pulse) begin
          generator_next_state = FIRST_QUERRY;
        end
      end

      FIRST_QUERRY: begin
        if (next_hash_current_state == READY) begin
          generator_next_state = QUERRIED;
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
        generator_next_state = EXHAUSTED;
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
      hash_number <= '0;
    end

    hash_byte_pulse <= 0;

    unique case (generator_current_state)
      GROUND: begin
        hash_number <= '0;
      end

      FIRST_QUERRY: begin
        if (next_hash_current_state == READY) begin
          hash <= next_hash;
          hash_byte_out_index <= 0;
          hash_number <= 1;
        end
      end

      QUERRIED_EXHAUSTED: begin
        hash_byte_pulse <= 1;  // Pulse the last byte
      end

      QUERRIED: begin
        hash_byte_pulse <= 1;
        hash_byte_out_index <= hash_byte_out_index + 1;
      end

      EXHAUSTED: begin
        if (next_hash_current_state == READY) begin
          hash <= next_hash;
          hash_byte_out_index <= 0;
          hash_number <= hash_number + 1;
        end
      end
    endcase
  end

  // Start of 3-Block FSM for the next hash

  // State transition setter for the next hash
  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      next_hash_current_state <= IDLE;

    end else begin
      next_hash_current_state <= next_hash_next_state;
    end
  end

  // State transition logic for the next hash
  always_comb begin
    // Default case
    next_hash_next_state = next_hash_current_state;

    unique case (next_hash_current_state)
      IDLE: begin
        if (generator_current_state == FIRST_QUERRY) begin
          next_hash_next_state = CALCULATING;
        end
      end

      CALCULATING: begin
        if (iteration_count >= HASH_ITERATIONS) begin
          next_hash_next_state = READY;
        end
      end

      READY: begin
        if (hash_number >= hash_computations_count) begin
          // If the hash_number is equal to the amount of hashes computed,
          // that means we can start computing the next hash. Similarily, if the
          // hash_computations_count is more than hash_number, we cannot
          // compute the next hash since some some hashes would be skipped
          next_hash_next_state = CALCULATING;
        end
      end
    endcase
  end

  logic [31:0] v0_round_temp;
  logic [31:0] v1_round_temp;
  logic [31:0] sum_round_temp;

  // This block is the combinational circuit to compute a round of the XTEA
  // hash
  always_comb begin
    v0_round_temp  = v0_next;
    v1_round_temp  = v1_next;
    sum_round_temp = sum;

    if (next_hash_current_state == CALCULATING) begin
      v0_round_temp = v0_next + (
          (((v1_next << 4) ^ (v1_next >> 5)) + v1_next) ^
          (sum + key_memory[(sum & 2'b11) * 32+:32])
        );

      // Step 2: Update sum (XTEA updates sum between v0 and v1)
      sum_round_temp = sum + XTEADelta;

      // Step 3: Update v1 using the NEW v0 and NEW sum
      v1_round_temp = v1_next + (
          (((v0_round_temp << 4) ^ (v0_round_temp >> 5)) + v0_round_temp) ^
          (sum_round_temp + key_memory[((sum_round_temp >> 11) & 2'b11) * 32+:32])
        );
    end
  end

  // Action block for the next hash
  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      v0_next <= '0;
      v1_next <= '0;
      sum <= '0;
      iteration_count <= '0;
      hash_computations_count <= '0;
    end

    unique case (next_hash_current_state)
      IDLE: begin
        if (generator_current_state == FIRST_QUERRY) begin
          // This is also the condition to transition to the computing state.
          // These are actions to perform to "initialize" the start of the
          // computation

          v0_next <= XTEADelta;
          v1_next <= '0;
          sum <= '0;
        end
      end

      CALCULATING: begin
        // Apply one round of the XTEA algorithm here

        // Note: this is the complement of the condition to transition from
        // CALCULATING to READY
        if (iteration_count < HASH_ITERATIONS) begin

          v0_next <= v0_round_temp;
          v1_next <= v1_round_temp;
          sum <= sum_round_temp;

          iteration_count <= iteration_count + 1;

        end else begin
          iteration_count <= '0;
          hash_computations_count <= hash_computations_count + 1;
        end
      end

      READY: begin
        if (hash_number >= hash_computations_count) begin
          // This is also the condition to transition to the CALCULATING state
          // from the READY state. These are actions to perform to "initialize"
          // the start of the computation

          v0_next <= hash[31:0] ^ hash[63:32];
          v1_next <= hash_computations_count;
          sum <= '0;
        end
      end
    endcase
  end

endmodule

