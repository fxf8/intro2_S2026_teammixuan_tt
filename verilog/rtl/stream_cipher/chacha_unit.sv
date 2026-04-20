// The module hash_unit is meant to perform the hash operation (multiple units could run in
// parallel)

/* Reference from libsodium
* https://github.com/jedisct1/libsodium/blob/master/src/libsodium/crypto_stream/chacha20/ref/chacha20_ref.c
*/


function automatic logic [31:0] rotate(logic [31:0] value, logic [4:0] amount);
  return value << amount | value >> (32 - amount);
endfunction

task automatic quarter_round(inout logic [31:0] a, inout logic [31:0] b, inout logic [31:0] c,
                             inout logic [31:0] d);
  begin
    a = a + b;
    d = rotate(d ^ a, 5'd16);
    c = c + d;
    b = rotate(b ^ c, 5'd12);
    a = a + b;
    d = rotate(d ^ a, 5'd8);
    c = c + d;
    b = rotate(b ^ c, 5'd7);
  end
endtask

/* C code
static void
chacha_keysetup(chacha_ctx *ctx, const uint8_t *k)
{
    ctx->input[0]  = U32C(0x61707865);
    ctx->input[1]  = U32C(0x3320646e);
    ctx->input[2]  = U32C(0x79622d32);
    ctx->input[3]  = U32C(0x6b206574);
    ctx->input[4]  = LOAD32_LE(k + 0);
    ctx->input[5]  = LOAD32_LE(k + 4);
    ctx->input[6]  = LOAD32_LE(k + 8);
    ctx->input[7]  = LOAD32_LE(k + 12);
    ctx->input[8]  = LOAD32_LE(k + 16);
    ctx->input[9]  = LOAD32_LE(k + 20);
    ctx->input[10] = LOAD32_LE(k + 24);
    ctx->input[11] = LOAD32_LE(k + 28);
}
*/

task automatic chacha_keysetup(output types_pkg::chacha_word_t [11:0] ctx,
                               input types_pkg::chacha_key_t k);
  begin
    ctx[0]  = 32'h61707865;
    ctx[1]  = 32'h3320646e;
    ctx[2]  = 32'h79622d32;
    ctx[3]  = 32'h6b206574;

    // Little-endian mapping
    ctx[4]  = {k[3], k[2], k[1], k[0]};
    ctx[5]  = {k[7], k[6], k[5], k[4]};
    ctx[6]  = {k[11], k[10], k[9], k[8]};
    ctx[7]  = {k[15], k[14], k[13], k[12]};
    ctx[8]  = {k[19], k[18], k[17], k[16]};
    ctx[9]  = {k[23], k[22], k[21], k[20]};
    ctx[10] = {k[27], k[26], k[25], k[24]};
    ctx[11] = {k[31], k[30], k[29], k[28]};
  end
endtask

/* C code
static void
chacha_ivsetup(chacha_ctx *ctx, const uint8_t *iv, const uint8_t *counter)
{
    ctx->input[12] = counter == NULL ? 0 : LOAD32_LE(counter + 0);
    ctx->input[13] = counter == NULL ? 0 : LOAD32_LE(counter + 4);
    ctx->input[14] = LOAD32_LE(iv + 0);
    ctx->input[15] = LOAD32_LE(iv + 4);
}
*/

task automatic chacha_djb_ivsetup(inout types_pkg::chacha_word_t [15:12] ctx,
                                  input types_pkg::chacha_byte_t [7:0] iv,
                                  input types_pkg::chacha_byte_t [7:0] counter);
  begin
    ctx[12] = {counter[3], counter[2], counter[1], counter[0]};
    ctx[13] = {counter[7], counter[6], counter[5], counter[4]};
    ctx[14] = {iv[3], iv[2], iv[1], iv[0]};
    ctx[15] = {iv[7], iv[6], iv[5], iv[4]};
  end
endtask

/* C code
static void
chacha_ietf_ivsetup(chacha_ctx *ctx, const uint8_t *iv, const uint8_t *counter)
{
    ctx->input[12] = counter == NULL ? 0 : LOAD32_LE(counter);
    ctx->input[13] = LOAD32_LE(iv + 0);
    ctx->input[14] = LOAD32_LE(iv + 4);
    ctx->input[15] = LOAD32_LE(iv + 8);
}
*/

task automatic chacha_itef_ivsetup(output types_pkg::chacha_word_t [15:12] ctx,
                                   input types_pkg::chacha_byte_t [11:0] iv,
                                   input types_pkg::chacha_byte_t [3:0] counter);
  begin
    ctx[12] = {counter[3], counter[2], counter[1], counter[0]};
    ctx[13] = {iv[3], iv[2], iv[1], iv[0]};
    ctx[14] = {iv[7], iv[6], iv[5], iv[4]};
    ctx[15] = {iv[11], iv[10], iv[9], iv[8]};
  end
endtask

/* C code
QUARTERROUND(x0, x4, x8, x12)
QUARTERROUND(x1, x5, x9, x13)
QUARTERROUND(x2, x6, x10, x14)
QUARTERROUND(x3, x7, x11, x15)
QUARTERROUND(x0, x5, x10, x15)
QUARTERROUND(x1, x6, x11, x12)
QUARTERROUND(x2, x7, x8, x13)
QUARTERROUND(x3, x4, x9, x14)

*/

task automatic mix_column_round(inout types_pkg::chacha_ctx_t state);
  begin
    quarter_round(state[0], state[4], state[8], state[12]);
    quarter_round(state[1], state[5], state[9], state[13]);
    quarter_round(state[2], state[6], state[10], state[14]);
    quarter_round(state[3], state[7], state[11], state[15]);
  end
endtask

task automatic mix_diagonal_round(inout types_pkg::chacha_ctx_t state);
  begin
    quarter_round(state[0], state[5], state[10], state[15]);
    quarter_round(state[1], state[6], state[11], state[12]);
    quarter_round(state[2], state[7], state[8], state[13]);
    quarter_round(state[3], state[4], state[9], state[14]);
  end
endtask

/* C code
x0  = PLUS(x0, j0);
x1  = PLUS(x1, j1);
x2  = PLUS(x2, j2);
x3  = PLUS(x3, j3);
x4  = PLUS(x4, j4);
x5  = PLUS(x5, j5);
x6  = PLUS(x6, j6);
x7  = PLUS(x7, j7);
x8  = PLUS(x8, j8);
x9  = PLUS(x9, j9);
x10 = PLUS(x10, j10);
x11 = PLUS(x11, j11);
x12 = PLUS(x12, j12);
x13 = PLUS(x13, j13);
x14 = PLUS(x14, j14);
x15 = PLUS(x15, j15);
*/

task automatic final_addition(input types_pkg::chacha_ctx_t ctx,
                              inout types_pkg::chacha_word_t [15:0] state);
  begin
    for (integer index = 0; index < 16; index = index + 1) begin
      state[index] = state[index] + ctx[index];
    end
  end
endtask


module chacha_unit (
    input logic clk,
    nrst,  //clock and negative-edge reset
    //other signals here

    input logic initiate_hash_pulse_in,

    input types_pkg::chacha_key_t key_in,
    input types_pkg::chacha_nonce_t nonce_in,
    input types_pkg::chacha_block_counter_t block_counter_in,

    input types_pkg::chacha_setup_standard_t setup_standard_in,
    input types_pkg::chacha_iterations_t iterations_in,

    output types_pkg::hash_unit_state_t hash_unit_state_out,
    output types_pkg::chacha_ctx_t chacha_state_out
);
  typedef types_pkg::chacha_ctx_t chacha_ctx_t;
  typedef types_pkg::chacha_iterations_t chacha_iterations_t;
  typedef types_pkg::hash_unit_state_t hash_unit_state_t;

  hash_unit_state_t hash_unit_state;
  assign hash_unit_state_out = hash_unit_state;
  hash_unit_state_t next_hash_unit_state;

  chacha_ctx_t chacha_ctx;

  chacha_ctx_t chacha_state;
  assign chacha_state_out = chacha_state;
  chacha_ctx_t chacha_next_state;

  chacha_iterations_t current_iterations;
  chacha_iterations_t next_current_iterations;

  // Context setup combinational block
  always_comb begin
    chacha_keysetup(chacha_ctx[11:0], key_in);

    if (setup_standard_in == types_pkg::S_DJB) begin
      chacha_djb_ivsetup(chacha_ctx[15:12], nonce_in[7:0], block_counter_in);

    end else begin
      chacha_itef_ivsetup(chacha_ctx[15:12], nonce_in, block_counter_in[31:0]);
    end
  end

  always_comb begin
    next_current_iterations = current_iterations;
    next_hash_unit_state = hash_unit_state;
    chacha_next_state = chacha_state;

    case (hash_unit_state)
      types_pkg::U_INITIAL: begin
        if (initiate_hash_pulse_in) begin
          next_hash_unit_state = types_pkg::U_CONTEXT_LOADING;
        end
      end

      types_pkg::U_CONTEXT_LOADING: begin
        next_current_iterations = 8'h00;
        chacha_next_state = chacha_ctx;
        next_hash_unit_state = types_pkg::U_COLUMN_ROUND;
      end

      types_pkg::U_COLUMN_ROUND: begin
        mix_column_round(chacha_next_state);
        next_hash_unit_state = types_pkg::U_DIAGONAL_ROUND;
      end

      types_pkg::U_DIAGONAL_ROUND: begin
        mix_diagonal_round(chacha_next_state);
        next_hash_unit_state = types_pkg::U_COLUMN_ROUND;

        next_current_iterations = current_iterations + 1;

        if (next_current_iterations == iterations_in) begin
          next_hash_unit_state = types_pkg::U_FINAL_ROUND;
        end else begin
          next_hash_unit_state = types_pkg::U_COLUMN_ROUND;
        end
      end

      types_pkg::U_FINAL_ROUND: begin
        final_addition(chacha_ctx, chacha_next_state);
        next_hash_unit_state = types_pkg::U_READY;
      end

      default: begin
        next_current_iterations = current_iterations;
        next_hash_unit_state = hash_unit_state;
        chacha_next_state = chacha_state;
      end
    endcase
  end

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      hash_unit_state <= types_pkg::U_INITIAL;
      current_iterations <= 8'h00;
      chacha_state <= chacha_ctx;
    end else begin
      hash_unit_state <= next_hash_unit_state;
      current_iterations <= next_current_iterations;
      chacha_state <= chacha_next_state;
    end
  end
endmodule
