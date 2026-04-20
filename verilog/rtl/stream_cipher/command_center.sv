// List of commands
//  1. Switch to Encrypt Byte Mode (code: 0) (each later byte input is encrypted)
//  2. IV Setup Standard (ivsetup, itef_ivsetup) (types_pkg::chacha_setup_standard_t)
//      a. Read (code: 1)
//      b. Write Mode (code: 10)
//  3. Hash Iterations (8 bits) (types_pkg::chacha_iterations_t)
//      a. Read (code: 11)
//      b. Write Mode (code: 100) (on next input)
//  4. Nonce Bytes (96 bits) (types_pkg::chacha_nonce_t)
//      a. Read at Address (code: 101)
//      b. Write at Address Mode (code: 110) (on next input). Successive byte inputs increment address
//  5. Nonce Bytes Address (types_pkg::chacha_nonce_addr_t)
//      a. Read (code: 111)
//      b. Write Mode (code: 1000) (on next input).
//  6. Key Bytes (256 bits) (types_pkg::chacha_key_t)
//      a. Read at Address (code: 1001)
//      b. Write at Address (code: 1010) (on next input). Successive byte inputs increment address
//  7. Key Bytes Address (5 bits) (types_pkg::chacha_key_addr_t)
//      a. Read (code: 1011)
//      b. Write Mode (code: 1100) (on next inputs)
//  8. Block Counter (64 bits)
//      a. Read (code: 1101)
//      b. Write at Address (code: 1110) (on next input) (Note: This writes
//      from LSB to MSB)
//  9. Block Counter Address (3 bits)
//      a. Read (code: 1111)
//      b. Write Mode (code: 1'0000) (on next input). Successive byte inputs increment address
//  10. Hash State Address (6 bits) (types_pkg::chacha_hash_state_address_t)
//      a. Read (code: 1'0001)
//      b. Write Mode (code: 1'0010) (on next input). Successive byte inputs increment address
//  11. Start Hashing (code: 1'0011)
//  12. Reset Hash (code: 1'0100)
//  13. Read if Hash has Started (code: 1'0101)
//  14. Read Mode (code: 1'0110) (Read Mode literally means read what the
//  current mode is)

// List of modes
// 1. Encrypt Mode (each non-command input is encrypted)
// 2. IV Standard Setup Mode (each non-command sets the IV setup standard. Either DJB or RFC 7539 (ITEF))
// 3. Hash Iterations Setup Mode
// 4. Nonce Bytes Input Mode
// 5. Nonce Bytes Address Setup Mode
// 6. Key Bytes Input Mode
// 7. Key Bytes Address Setup Mode
// 8. Block Counter Input Mode
// 9. Block Counter Address Setup Mode

module command_center (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Received from reader block
    input pulse_in,
    input logic command_in,
    input logic [7:0] input_byte_in,

    // Sent to Hash Generator (condition: non-command during MODE_ENCRYPT)
    output logic [7:0] message_byte_out,

    // Sent to Hash Generator (condition: command CMD_IV_STD_READ) (Note: This
    // might be sent to output holder under the same condition)
    output logic read_iv_standard_pulse_out,

    // Sent to Hash Generator (condition: non-command during MODE_IV_STANDARD_SETUP)
    output logic write_iv_standard_pulse_out,
    output types_pkg::chacha_setup_standard_t write_iv_standard_out,

    // Sent to Nonce Storage
    output logic read_nonce_bytes_pulse_out,

    // Sent to Hash Generator (condition: command CMD_N_ITER_READ)
    output logic read_hash_iterations_pulse_out,
    // Sent to Hash Generator (condition: non-command during MODE_HASH_ITERATIONS_SETUP)
    output logic write_hash_iterations_pulse_out,
    output types_pkg::chacha_iterations_t write_hash_iterations_out,

    // Sent to Nonce Storage (condition: non-command during MODE_NONCE_BYTES_INPUT)
    output logic write_nonce_byte_pulse_out,
    output types_pkg::chacha_byte_t write_nonce_byte_out,

    // Sent to Nonce Storage (condition: command CMD_NONCE_ADDR_READ)
    output logic read_nonce_address_pulse_out,
    // Sent to Nonce Storage (condition: non-command during MODE_NONCE_BYTES_ADDR_SETUP)
    output logic write_nonce_address_pulse_out,
    output types_pkg::chacha_nonce_addr_t write_nonce_address_out,

    // Sent to Key Storage (condition: command CMD_KEY_READ)
    output logic read_key_byte_pulse_out,
    // Sent to Key Storage (condition: non-command during MODE_KEY_BYTES_INPUT)
    output logic write_key_byte_pulse_out,
    output types_pkg::chacha_byte_t write_key_byte_out,

    // Sent to Key Storage (condition: command CMD_KEY_ADDR_READ)
    output logic read_key_address_pulse_out,
    // Sent to Key Storage (condition: non-command during MODE_KEY_BYTES_ADDR_SETUP)
    output logic write_key_address_pulse_out,
    output types_pkg::chacha_key_addr_t write_key_address_out,

    // Sent to Hash Generator (condition: command CMD_BLOCK_CNT_READ)
    output logic read_block_counter_pulse_out,
    // Sent to Hash Generator (condition: non-command during MODE_BLOCK_COUNTER_INPUT)
    output logic write_block_counter_pulse_out,
    output types_pkg::chacha_byte_t write_block_counter_out,

    // Sent to Block Counter (condition: command CMD_BLOCK_CNT_ADDR_READ)
    output logic read_block_counter_address_pulse_out,
    // Sent to Block Counter (condition: non-command during MODE_BLOCK_COUNTER_ADDR_SETUP)
    output logic write_block_counter_address_pulse_out,
    output types_pkg::chacha_block_counter_addr_t write_block_counter_address_out,

    // Sent to Hash Generator (condition: command CMD_HASH_STATE_ADDR_READ)
    output logic read_hash_state_address_pulse_out,

    output logic write_hash_state_address_pulse_out,
    output types_pkg::chacha_hash_state_addr_t write_hash_state_address_out,

    // Sent to Hash Generator (condition: command CMD_START_HASH)
    output logic start_hash_pulse_out,
    // Sent to Hash Generator (condition: command CMD_RESET_HASH)
    output logic reset_hash_pulse_out,
    // Sent to Hash Generator (condition: command CMD_HASH_STATUS)
    output logic read_hash_status_pulse_out,

    // Sent to Output Mux (condition: command CMD_STATUS_READ)
    output logic read_mode_pulse_out,
    // Sent to Output Mux (condition: command CMD_STATUS_READ)
    output types_pkg::cmd_mode_t current_mode_out
);

  typedef types_pkg::cmd_t cmd_t;
  typedef types_pkg::cmd_mode_t cmd_mode_t;

  cmd_t command_code;
  assign command_code = cmd_t'(input_byte_in[4:0]);

  // Assign statements for new outputs
  assign message_byte_out = input_byte_in;

  assign read_iv_standard_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_IV_STD_READ);
  assign write_iv_standard_pulse_out =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_IV_STANDARD_SETUP);
  assign write_iv_standard_out = types_pkg::chacha_setup_standard_t'(input_byte_in[0]);

  assign read_hash_iterations_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_N_ITER_READ);
  assign write_hash_iterations_pulse_out =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_HASH_ITERATIONS_SETUP);
  assign write_hash_iterations_out = types_pkg::chacha_iterations_t'(input_byte_in);

  assign read_nonce_bytes_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_NONCE_READ);
  assign write_nonce_byte_pulse_out =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_NONCE_BYTES_INPUT);
  assign write_nonce_byte_out = input_byte_in;

  assign read_nonce_address_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_NONCE_ADDR_READ);
  assign write_nonce_address_pulse_out =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_NONCE_BYTES_ADDR_SETUP);
  assign write_nonce_address_out = types_pkg::chacha_nonce_addr_t'(input_byte_in[3:0]);

  assign read_key_byte_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_KEY_READ);
  assign write_key_byte_pulse_out =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_KEY_BYTES_INPUT);
  assign write_key_byte_out = input_byte_in;

  assign read_key_address_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_KEY_ADDR_READ);
  assign write_key_address_pulse_out =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_KEY_BYTES_ADDR_SETUP);
  assign write_key_address_out = types_pkg::chacha_key_addr_t'(input_byte_in[4:0]);

  assign read_block_counter_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_BLOCK_CNT_READ);
  assign write_block_counter_pulse_out =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_BLOCK_COUNTER_INPUT);
  assign write_block_counter_out = input_byte_in;

  assign read_block_counter_address_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_BLOCK_CNT_ADDR_READ);
  assign write_block_counter_address_pulse_out =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_BLOCK_COUNTER_ADDR_SETUP);
  assign write_block_counter_address_out =
      types_pkg::chacha_block_counter_addr_t'(input_byte_in[2:0]);

  assign read_hash_state_address_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_HASH_STATE_ADDR_READ);

  assign write_hash_state_address_pulse_out =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_HASH_STATE_ADDR_SETUP);
  assign write_hash_state_address_out = types_pkg::chacha_hash_state_addr_t'(input_byte_in[5:0]);

  assign start_hash_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_START_HASH);
  assign reset_hash_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_RESET_HASH);
  assign read_hash_status_pulse_out =
      (command_in && pulse_in && command_code == types_pkg::CMD_HASH_STATUS);

  assign read_mode_pulse_out = (command_in && pulse_in && command_code == types_pkg::CMD_MODE_READ);
  assign current_mode_out = command_mode;

  cmd_mode_t command_mode;
  cmd_mode_t next_command_mode;

  // Mode Switching Combinational Block
  always_comb begin
    next_command_mode = command_mode;

    // Handle Mode Switching
    if (command_in && pulse_in) begin
      case (command_code)
        types_pkg::CMD_SET_ENCRYPT_MODE: begin
          next_command_mode = types_pkg::MODE_ENCRYPT;
        end

        types_pkg::CMD_IV_STD_WRITE: begin
          next_command_mode = types_pkg::MODE_IV_STANDARD_SETUP;
        end

        types_pkg::CMD_N_ITER_WRITE: begin
          next_command_mode = types_pkg::MODE_HASH_ITERATIONS_SETUP;
        end

        types_pkg::CMD_NONCE_WRITE: begin
          next_command_mode = types_pkg::MODE_NONCE_BYTES_INPUT;
        end

        types_pkg::CMD_NONCE_ADDR_WRITE: begin
          next_command_mode = types_pkg::MODE_NONCE_BYTES_ADDR_SETUP;
        end

        types_pkg::CMD_KEY_WRITE: begin
          next_command_mode = types_pkg::MODE_KEY_BYTES_INPUT;
        end

        types_pkg::CMD_KEY_ADDR_WRITE: begin
          next_command_mode = types_pkg::MODE_KEY_BYTES_ADDR_SETUP;
        end

        types_pkg::CMD_BLOCK_CNT_WRITE: begin
          next_command_mode = types_pkg::MODE_BLOCK_COUNTER_INPUT;
        end

        types_pkg::CMD_BLOCK_CNT_ADDR_WRITE: begin
          next_command_mode = types_pkg::MODE_BLOCK_COUNTER_ADDR_SETUP;
        end

        types_pkg::CMD_HASH_STATE_ADDR_WRITE: begin
          next_command_mode = types_pkg::MODE_HASH_STATE_ADDR_SETUP;
        end

        default: begin
          next_command_mode = command_mode;
        end
      endcase
    end
  end  // Mode Switching Comb Block

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      command_mode <= types_pkg::MODE_ENCRYPT;

    end else begin
      command_mode <= next_command_mode;
    end
  end  // Mode Switching FF
endmodule
