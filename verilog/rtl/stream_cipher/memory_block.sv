module memory_block #(
    parameter int MEMORY_WIDTH_BYTES = 32,  // Number of bytes in the memory
    parameter logic AUTO_INCREMENT_ADDRESS = 1,
    localparam int AddressWidth = $clog2(
        MEMORY_WIDTH_BYTES
    ),  // Number of bits needed to address the full memory
    localparam logic MemoryWidthIsPowerOfTwo = (MEMORY_WIDTH_BYTES == 2 ** AddressWidth)
) (
    input logic clk,
    nrst,  //clock and negative-edge reset

    input logic [7:0] store_byte_in,
    input logic store_byte_pulse_in,

    input logic [AddressWidth - 1:0] set_address_in,
    input logic set_address_pulse_in,

    output logic [MEMORY_WIDTH_BYTES * 8 - 1:0] memory_out,
    output logic [7:0] memory_at_address_out,

    output logic received_byte_pulse_out,
    output logic received_address_pulse_out,

    output logic [AddressWidth - 1:0] address_out
);
  logic [MEMORY_WIDTH_BYTES * 8 - 1:0] memory;
  assign memory_out = memory;
  assign memory_at_address_out = memory[address*8+:8];

  // Used to set values to the key memory. This is the *byte* number and not
  // the *bit* number
  typedef logic [AddressWidth - 1:0] address_t;

  address_t address;  // Indexes the byte in the key memory
  assign address_out = address;
  address_t next_address;

  assign received_byte_pulse_out = store_byte_pulse_in;
  assign received_address_pulse_out = set_address_pulse_in;

  always_comb begin
    next_address = address;

    // Setting address takes precedence over storing bytes, though, neither
    // will happen at the same time
    if (set_address_pulse_in) begin
      next_address = set_address_in;
    end else if (store_byte_pulse_in) begin
      if (AUTO_INCREMENT_ADDRESS) begin
        next_address = address + 1;

        if (!MemoryWidthIsPowerOfTwo && int'(next_address) >= MEMORY_WIDTH_BYTES) begin
          next_address = 0;
        end
      end
    end
  end

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      address <= 0;
      memory  <= 0;

    end else begin
      if (store_byte_pulse_in) begin
        memory[address*8+:8] <= store_byte_in;
      end

      address <= next_address;
    end
  end
endmodule
