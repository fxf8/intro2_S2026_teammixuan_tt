package types_pkg;
  typedef enum {
    I_IDLE,
    I_PROCESSING,
    I_DONE
  } interface_state_t;

  typedef enum {
    E_READY,
    E_QUERRIED,
    E_QUERRIED_AWAITING_HASH
  } encryption_block_state_t;

  typedef enum {
    H_GROUND,  // The initial ground state when no hash is computed

    // This is used for the first time a hashed byte is requested
    H_FIRST_QUERRY,

    H_READY,  // When the hash is computed and the marker is not at the end of the buffer
    H_QUERRIED,  // When a hashed byte has been requested
    H_PULSE_OUT,  // When an output is being pulsed
    H_EXHAUSTED  // When the marker has reached the end of the buffer
  } hash_generator_state_t;
  // Note about `hash_generator_state`:
  // Hashes can only be requested when the hash generator is in either the
  // `GROUND` or `READY` state

  typedef enum {
    O_EMPTY,
    O_READY
  } output_holder_state_t;
endpackage
