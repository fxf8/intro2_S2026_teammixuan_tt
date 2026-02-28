package types_pkg;
  typedef enum {
    IDLE,
    PROCESSING,
    DONE
  } interface_state_t;

  typedef enum {
    READY,
    QUERRIED,
    QUERRIED_AWAITING_HASH
  } encryption_block_state_t;

  typedef enum {
    GROUND,  // The initial ground state when no hash is computed

    // This is used for the first time a hashed byte is requested
    FIRST_QUERRY,

    READY,  // When the hash is computed and the marker is not at the end of the buffer
    QUERRIED,  // When a hashed byte has been requested
    PULSE_OUT,  // When an output is being pulsed
    EXHAUSTED  // When the marker has reached the end of the buffer
  } hash_generator_state_t;
  // Note about `hash_generator_state`:
  // Hashes can only be requested when the hash generator is in either the
  // `GROUND` or `READY` state

  typedef enum {
    EMPTY,
    READY
  } output_holder_state_t;
endpackage
