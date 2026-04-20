`ifndef TYPES_PKG
`define TYPES_PKG

package types_pkg;
  typedef enum logic [4:0] {
    CMD_SET_ENCRYPT_MODE = 5'b00000,  // Switch to MODE_ENCRYPT

    CMD_IV_STD_READ  = 5'b00001,
    CMD_IV_STD_WRITE = 5'b00010,  // Switch to MODE_IV_STANDARD_SETUP

    CMD_N_ITER_READ  = 5'b00011,
    CMD_N_ITER_WRITE = 5'b00100,  // Switch to MODE_HASH_ITERATIONS_SETUP

    CMD_NONCE_READ       = 5'b00101,
    CMD_NONCE_WRITE      = 5'b00110,  // Switch to MODE_NONCE_BYTES_INPUT
    CMD_NONCE_ADDR_READ  = 5'b00111,
    CMD_NONCE_ADDR_WRITE = 5'b01000,  // Switch to MODE_NONCE_BYTES_ADDR_SETUP

    CMD_KEY_READ       = 5'b01001,
    CMD_KEY_WRITE      = 5'b01010,  // Switch to MODE_KEY_BYTES_INPUT
    CMD_KEY_ADDR_READ  = 5'b01011,
    CMD_KEY_ADDR_WRITE = 5'b01100,  // Switch to MODE_KEY_BYTES_ADDR_SETUP

    CMD_BLOCK_CNT_READ       = 5'b01101,
    CMD_BLOCK_CNT_WRITE      = 5'b01110,  // Switch to MODE_BLOCK_COUNTER_INPUT
    CMD_BLOCK_CNT_ADDR_READ  = 5'b01111,
    CMD_BLOCK_CNT_ADDR_WRITE = 5'b10000,  // Switch to MODE_BLOCK_COUNTER_ADDR_SETUP

    CMD_HASH_STATE_ADDR_READ  = 5'b10001,
    CMD_HASH_STATE_ADDR_WRITE = 5'b10010,

    CMD_START_HASH  = 5'b10011,
    CMD_RESET_HASH  = 5'b10100,
    CMD_HASH_STATUS = 5'b10101,
    CMD_MODE_READ = 5'b10110
  } cmd_t;

  typedef enum logic [3:0] {
    MODE_ENCRYPT = 4'b0000,
    MODE_IV_STANDARD_SETUP = 4'b0001,
    MODE_HASH_ITERATIONS_SETUP = 4'b0010,
    MODE_NONCE_BYTES_INPUT = 4'b0011,
    MODE_NONCE_BYTES_ADDR_SETUP = 4'b0100,
    MODE_KEY_BYTES_INPUT = 4'b0101,
    MODE_KEY_BYTES_ADDR_SETUP = 4'b0110,
    MODE_BLOCK_COUNTER_INPUT = 4'b0111,
    MODE_BLOCK_COUNTER_ADDR_SETUP = 4'b1000,
    MODE_HASH_STATE_ADDR_SETUP = 4'b1001
  } cmd_mode_t;

  typedef enum logic [1:0] {
    I_IDLE = 2'b00,
    I_PROCESSING = 2'b01,
    I_DONE = 2'b10
  } interface_state_t;

  typedef enum logic [1:0] {
    E_READY = 2'b00,
    E_QUERRIED = 2'b01,
    E_QUERRIED_AWAITING_HASH = 2'b10
  } encryption_block_state_t;

  typedef enum logic [2:0] {
    H_GROUND = 3'b000,  // The initial ground state when no hash is computed

    // This is used for the first time a hashed byte is requested
    H_FIRST_QUERRY = 3'b001,

    H_READY = 3'b010,  // When the hash is computed and the marker is not at the end of the buffer
    H_QUERRIED = 3'b011,  // When a hashed byte has been requested
    H_PULSE_OUT = 3'b100,  // When an output is being pulsed
    H_EXHAUSTED = 3'b101  // When the marker has reached the end of the buffer
  } hash_generator_state_t;
  // Note about `hash_generator_state`:
  // Hashes can only be requested when the hash generator is in either the
  // `GROUND` or `READY` state

  typedef logic [7:0] chacha_byte_t;

  typedef chacha_byte_t [31:0] chacha_key_t;
  typedef logic [4:0] chacha_key_addr_t;

  typedef chacha_byte_t [11:0] chacha_nonce_t;
  typedef logic [3:0] chacha_nonce_addr_t;

  typedef logic [7:0] chacha_iterations_t;

  typedef logic [63:0] chacha_block_counter_t;
  typedef logic [2:0] chacha_block_counter_addr_t;

  typedef logic [5:0] chacha_hash_state_addr_t;

  typedef logic [31:0] chacha_word_t;
  typedef chacha_word_t [15:0] chacha_ctx_t;

  typedef enum logic {
    S_DJB  = 0,  // Nonce is 64 bits
    S_ITEF = 1   // Nonce is 96 bits
  } chacha_setup_standard_t;

  typedef enum logic [2:0] {
    U_INITIAL = 3'b000,
    U_CONTEXT_LOADING = 3'b001,
    U_COLUMN_ROUND = 3'b010,
    U_DIAGONAL_ROUND = 3'b011,
    U_FINAL_ROUND = 3'b100,
    U_READY = 3'b101
  } hash_unit_state_t;

  typedef enum logic {
    O_EMPTY = 0,
    O_READY = 1
  } output_holder_state_t;
endpackage

`endif
