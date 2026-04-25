interface block_counter_if #(
    parameter int MEMORY_WIDTH_BYTES = 32,
    localparam int AddressWidth = $clog2(MEMORY_WIDTH_BYTES)
);
  // Memory Block Inputs
  logic [7:0] store_byte_in;
  logic store_byte_pulse_in;

  logic [AddressWidth - 1:0] set_address_in;
  logic set_address_pulse_in;

  logic reset_memory_pulse_in;

  logic increment_block_counter_pulse_in;

  // Memory Block Outputs
  logic [MEMORY_WIDTH_BYTES * 8 - 1:0] memory_out;
  logic [7:0] memory_at_address_out;

  logic received_byte_pulse_out;
  logic received_address_pulse_out;

  logic [AddressWidth - 1:0] address_out;

  logic read_address_pulse;
  logic read_byte_at_address_pulse;

  modport command_center_write_byte_port(output store_byte_in, output store_byte_pulse_in);
  modport command_center_write_address_port(output set_address_in, output set_address_pulse_in);
  modport command_center_reset_memory_port(output reset_memory_pulse_in);

  modport command_center_read_address_port(output read_address_pulse);
  modport command_center_read_byte_at_address_port(output read_byte_at_address_pulse);

  modport block_counter_port(
      input store_byte_in,
      input store_byte_pulse_in,

      input set_address_in,
      input set_address_pulse_in,

      input reset_memory_pulse_in,

      input increment_block_counter_pulse_in,

      output memory_out,

      output memory_at_address_out,

      output received_byte_pulse_out,
      output received_address_pulse_out,

      output address_out
  );

  modport memory_out_port(input memory_out);
  modport increment_counter_port(output increment_block_counter_pulse_in);

  modport output_holder_store_byte_port(input received_byte_pulse_out, input address_out);
  modport output_holder_set_address_port(input received_address_pulse_out, input address_out);
  modport output_holder_reset_memory_port(input reset_memory_pulse_in, input address_out);

  modport output_holder_read_address(input read_address_pulse, input address_out);
  modport output_holder_read_byte_at_address(
      input read_byte_at_address_pulse,
      input memory_at_address_out
  );
endinterface

`ifndef BLOCK_COUNTER_IF_TYPES_PKG
`define BLOCK_COUNTER_IF_TYPES_PKG

package block_counter_if_types_pkg;
endpackage

`endif
