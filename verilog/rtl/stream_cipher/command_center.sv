// Import the package for types and enums
import encryption_block_pkg::*;

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

    // encryption_block_if.command_center_port command_center_port, // Removed interface connection

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

  typedef types_pkg::chacha_nonce_addr_t chacha_nonce_addr_t;
  typedef types_pkg::chacha_key_addr_t chacha_key_addr_t;
  typedef types_pkg::chacha_block_counter_addr_t chacha_block_counter_addr_t;
  typedef types_pkg::chacha_setup_standard_t chacha_setup_standard_t;
  typedef types_pkg::chacha_iterations_t chacha_iterations_t;
  typedef types_pkg::chacha_hash_state_addr_t chacha_hash_state_addr_t;

  // Nonce Memory Connections
  assign read_nonce_byte_at_address_port.read_byte_at_address_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_NONCE_READ);
  assign write_nonce_byte_port.store_byte_in = input_byte_in;
  assign write_nonce_byte_port.store_byte_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_NONCE_BYTES_INPUT);
  assign read_nonce_address_port.read_address_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_NONCE_ADDR_READ);
  assign write_nonce_address_port.set_address_in = chacha_nonce_addr_t'(input_byte_in);
  assign write_nonce_address_port.set_address_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_NONCE_BYTES_ADDR_SETUP);
  assign reset_nonce_memory_port.reset_memory_pulse_in =
      (command_in && pulse_in && command_code == types_pkg::CMD_NONCE_RESET);

  // Key Memory Connections
  assign read_key_byte_at_address_port.read_byte_at_address_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_KEY_READ);
  assign write_key_byte_port.store_byte_in = input_byte_in;
  assign write_key_byte_port.store_byte_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_KEY_BYTES_INPUT);
  assign read_key_address_port.read_address_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_KEY_ADDR_READ);
  assign write_key_address_port.set_address_in = chacha_key_addr_t'(input_byte_in);
  assign write_key_address_port.set_address_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_KEY_BYTES_ADDR_SETUP);
  assign reset_key_memory_port.reset_memory_pulse_in =
      (command_in && pulse_in && command_code == types_pkg::CMD_KEY_RESET);

  // Block Counter Connections
  assign read_block_counter_byte_at_address_port.read_byte_at_address_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_BLOCK_CNT_READ);
  assign write_block_counter_port.store_byte_in = input_byte_in;
  assign write_block_counter_port.store_byte_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_BLOCK_COUNTER_INPUT);
  assign read_block_counter_address_port.read_address_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_BLOCK_CNT_ADDR_READ);
  assign write_block_counter_address_port.set_address_in =
      chacha_block_counter_addr_t'(input_byte_in);
  assign write_block_counter_address_port.set_address_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_BLOCK_COUNTER_ADDR_SETUP);
  assign reset_block_counter_port.reset_memory_pulse_in =
      (command_in && pulse_in && command_code == types_pkg::CMD_BLOCK_CNT_RESET);

  // Encryption Block Connections
  assign message_byte_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_ENCRYPT);
  assign message_byte_in = input_byte_in;
  assign write_iv_standard_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_IV_STANDARD_SETUP);
  assign write_iv_standard_in = chacha_setup_standard_t'(input_byte_in[0]);
  assign write_hash_iterations_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_HASH_ITERATIONS_SETUP);
  assign write_hash_iterations_in = chacha_iterations_t'(input_byte_in);
  assign write_hash_state_address_pulse_in =
      (!command_in && pulse_in && command_mode == types_pkg::MODE_HASH_STATE_ADDR_SETUP);
  assign write_hash_state_address_in = chacha_hash_state_addr_t'(input_byte_in);
  assign read_iv_standard_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_IV_STD_READ);
  assign read_hash_iterations_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_N_ITER_READ);
  assign read_hash_state_address_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_HASH_STATE_ADDR_READ);
  assign read_hash_state_at_address_pulse =
      (command_in && pulse_in && command_code == types_pkg::CMD_HASH_STATE_AT_ADDR_READ);
  assign reset_hash_pulse_in =
      (command_in && pulse_in && command_code == types_pkg::CMD_RESET_HASH);
endmodule
