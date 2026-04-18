module interface_fsm (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Handshake signals
    input logic input_request_in, // Received from chip input
    input logic output_acknowledge_in, // Received from chip output
    // Received by the output holder block
    input types_pkg::output_holder_state_t output_holder_state_in,

    output types_pkg::interface_state_t interface_state_out
);
  typedef types_pkg::interface_state_t interface_state_t;

  interface_state_t next_interface_state;
  assign interface_state_out = interface_state;
  interface_state_t interface_state;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      interface_state <= types_pkg::I_IDLE;

    end else begin
      interface_state <= next_interface_state;
    end
  end

  always_comb begin
    // The default case
    next_interface_state = interface_state;

    unique case (interface_state)
      types_pkg::I_IDLE: begin
        if (input_request_in) begin
          next_interface_state = types_pkg::I_PROCESSING;
        end
      end

      types_pkg::I_PROCESSING: begin
        if (output_holder_state_in == types_pkg::O_READY) begin
          next_interface_state = types_pkg::I_DONE;
        end
      end

      types_pkg::I_DONE: begin
        if (output_acknowledge_in) begin
          next_interface_state = types_pkg::I_IDLE;
        end
      end
    endcase
  end
endmodule
