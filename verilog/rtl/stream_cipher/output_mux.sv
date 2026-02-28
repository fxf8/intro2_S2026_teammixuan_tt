module output_mux (
    // Inputs from output holder
    input logic [7:0] data_in,
    input output_holder_state_t output_holder_state,

    // Inputs from interface fsm
    input interface_state_t interface_state,

    // Outputs sent to the output of the chip
    output logic [7:0] data_out,
    output logic output_byte_is_ready,
    // Note: `output_bte_is_rady` stays high until the chip user specifies the output has been read (using the output_acknowledge pin)

    output logic input_acknowledged
);
  always_comb begin
    data_out = data_in;
    input_acknowledged = 1'b0;
    output_byte_is_ready = 1'b0;

    if (interface_state != interface_state_t::IDLE) begin
      input_acknowledged = 1'b1;
    end

    if (output_holder_state == output_holder_state_t::READY) begin
      output_byte_is_ready = 1'b1;
    end
  end

endmodule
