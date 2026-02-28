package types_pkg;
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

  typedef enum logic {
    O_EMPTY = 0,
    O_READY = 1
  } output_holder_state_t;
endpackage
