module key_storage #(
    parameter int KEY_WIDTH_BYTES = 16  // 128 bits. Note: Modifying this might require adding a
    // key index rollover checker
) (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Inputs received from the data router
    input logic [7:0] key_byte,
    input logic key_byte_pulse,

    // Output sent to the hash generator
    output logic [KEY_WIDTH_BYTES * 8 - 1:0] key_memory_out,

    // Output sent to output holder
    output logic received_key_byte_pulse_out
);
  localparam int IndexWidthBytes = $clog2(KEY_WIDTH_BYTES);  // Ceiling log base 2 function

  logic [KEY_WIDTH_BYTES * 8 - 1:0] key_memory;
  assign key_memory_out = key_memory;

  // Used to set values to the key memory. This is the *byte* number and not
  // the *bit* number
  logic [IndexWidthBytes - 1:0] key_byte_index;  // Indexes the byte in the key memory
  logic received_key_byte_pulse;
  assign received_key_byte_pulse_out = received_key_byte_pulse;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      key_memory <= '0;
      key_byte_index <= '0;
      received_key_byte_pulse <= '0;

    end else begin
      // Default case
      received_key_byte_pulse <= '0;

      if (key_byte_pulse) begin
        received_key_byte_pulse <= '1;

        key_memory[(key_byte_index*8)+:8] <= key_byte;

        if (key_byte_index == (KEY_WIDTH_BYTES - 1)) begin
          key_byte_index <= '0;

        end else begin
          key_byte_index <= key_byte_index + 1;
        end
      end
    end
  end

endmodule
