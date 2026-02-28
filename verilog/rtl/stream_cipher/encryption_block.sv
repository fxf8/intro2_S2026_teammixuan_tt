typedef types_pkg::encryption_block_state_t encryption_block_state_t;
typedef types_pkg::hash_generator_state_t hash_generator_state_t;

module encryption_block (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Inputs received from the data router
    input logic [7:0] byte_in,
    input logic byte_in_pulse,

    // Hash generator pins:

    // This pin allows us to know when this block can request a hashed byte
    input hash_generator_state_t hash_generator_state,

    output logic request_byte_pulse_out,

    input logic [7:0] hash_byte,
    input logic hash_byte_pulse,

    // Pulsed output sent to output holder
    output logic [7:0] encrypted_byte_out,
    output logic encrypted_byte_pulse_out,

    // General purpose output state
    output encryption_block_state_t encryption_block_state_out
);
  encryption_block_state_t state;
  encryption_block_state_t next_state;
  assign encryption_block_state_out = state;

  logic [7:0] saved_byte_in;
  logic [7:0] next_saved_byte_in;
  assign encrypted_byte_out = saved_byte_in ^ hash_byte;

  logic request_byte_pulse;
  logic next_request_byte_pulse;
  assign request_byte_pulse_out = request_byte_pulse;

  logic encrypted_byte_pulse;
  logic next_encrypted_byte_pulse;
  assign encrypted_byte_pulse_out = encrypted_byte_pulse;

  // 3 block FSM for the encryption block

  // State setter for the encryption block
  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      state <= '0; // encryption_block_state_t::E_READY;
      saved_byte_in <= '0;
      encrypted_byte_pulse <= '0;
      request_byte_pulse <= '0;

    end else begin
      state <= next_state;
      saved_byte_in <= next_saved_byte_in;
      encrypted_byte_pulse <= next_encrypted_byte_pulse;
      request_byte_pulse <= next_request_byte_pulse;
    end
  end

  // Logic
  always_comb begin
    next_state = state;
    next_saved_byte_in = saved_byte_in;
    next_encrypted_byte_pulse = 0;
    next_request_byte_pulse = 0;

    case (state)
      types_pkg::E_READY: begin
        if (byte_in_pulse) begin
          next_saved_byte_in = byte_in;
          next_state = types_pkg::E_QUERRIED;
        end
      end

      types_pkg::E_QUERRIED: begin
        // This condition checks if the hash generator is ready to have
        // bytes requested from it
        if (
            hash_generator_state == types_pkg::H_GROUND ||
            hash_generator_state == types_pkg::H_READY
        ) begin
          next_request_byte_pulse = 1;
          next_state = types_pkg::E_QUERRIED_AWAITING_HASH;
        end
      end

      types_pkg::E_QUERRIED_AWAITING_HASH: begin
        if (hash_byte_pulse) begin
          next_state = types_pkg::E_READY;
          next_encrypted_byte_pulse = 1;
        end
      end

      default: begin
      end
    endcase
  end

endmodule
