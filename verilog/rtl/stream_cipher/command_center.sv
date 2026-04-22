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
//  11. Read Hash Byte in State at Address (code: 1'0011)
//  12. Start Hashing (code: 1'0100)
//  13. Reset Hash (code: 1'0101)
//  14. Read if Hash has Started (code: 1'0110)
//  15. Read Mode (code: 1'0111) (Read Mode literally means read what the
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


    // condition: command CMD_NONCE_READ
    memory_block_if.command_center_read_byte_at_address_port read_nonce_byte_at_address_port,
    // condition: non-command during mode MODE_NONCE_BYTES_INPUT
    memory_block_if.command_center_write_byte_port write_nonce_byte_port,
    // condition: command CMD_NONCE_ADDR_READ
    memory_block_if.command_center_read_address_port read_nonce_address_port,
    // condition: non-command during MODE_NONCE_BYTES_ADDR_SETUP
    memory_block_if.command_center_write_address_port write_nonce_address_port,
    // condition: command CMD_NONCE_RESET
    memory_block_if.command_center_reset_memory_port reset_nonce_memory_port,

    // condition: command CMD_KEY_READ
    memory_block_if.command_center_read_byte_at_address_port read_key_byte_at_address_port,
    // condition: non-command during mode = MODE_KEY_BYTES_INPUT
    memory_block_if.command_center_write_byte_port write_key_byte_port,
    // condition: command CMD_KEY_ADDR_READ
    memory_block_if.command_center_read_address_port read_key_address_port,
    // condition: non-command during MODE_KEY_BYTES_ADDR_SETUP
    memory_block_if.command_center_write_address_port write_key_address_port,
    // condition: command CMD_KEY_RESET
    memory_block_if.command_center_reset_memory_port reset_key_memory_port,


    // condition: command CMD_BLOCK_CNT_READ
    block_counter_if.command_center_read_byte_at_address_port
        read_block_counter_byte_at_address_port,
    // condition: non-command during mode = MODE_BLOCK_COUNTER_INPUT
    block_counter_if.command_center_write_byte_port write_block_counter_port,
    // condition: command CMD_BLOCK_CNT_ADDR_READ
    block_counter_if.command_center_read_address_port read_block_counter_address_port,
    // conditoin: non-command during mode = MODE_BLOCK_COUNTER_ADDR_SETUP
    block_counter_if.command_center_write_address_port write_block_counter_address_port,
    // condition: command CMD_BLOCK_CNT_RESET
    block_counter_if.command_center_reset_memory_port reset_block_counter_port,

    encryption_block_if.command_center_port command_center_port,

    // Sent to Output Mux (condition: command CMD_STATUS_READ)
    output logic read_mode_pulse_out,
    // Sent to Output Mux (condition: command CMD_STATUS_READ)
    output types_pkg::cmd_mode_t current_mode_out
);

  typedef types_pkg::cmd_t cmd_t;
  typedef types_pkg::cmd_mode_t cmd_mode_t;

  cmd_t command_code;
  assign command_code = cmd_t'(input_byte_in[4:0]);

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
