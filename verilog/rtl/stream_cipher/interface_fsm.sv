typedef enum {
  IDLE,
  PROCESSING,
  DONE
} interface_state_t;

module interface_fsm #(
    // parameters here
) (
    input logic clk,
    nrst,  //clock and negative-edge reset

    // Handshake signals
    input logic input_request,  // Received by the chip input pins
    input logic output_acknowledge,  // Received by the chip input pins
    input logic output_is_ready,  // This is received by the output holder block

    output interface_state_t interface_state_out
);
  //module code here
  // assign a = clk && nrst;

  interface_state_t next_interface_state;
  interface_state_t current_interface_state;

  assign interface_state_out = current_interface_state;

  always_ff @(posedge clk or negedge nrst) begin
    if (!nrst) begin
      current_interface_state <= interface_state_t::IDLE;
    end else begin
      current_interface_state <= next_interface_state;
    end
  end

  always_comb begin
    // The default case
    next_interface_state = current_interface_state;

    unique case (current_interface_state)
      interface_state_t::IDLE: begin
        if (input_request) begin
          next_interface_state = interface_state_t::PROCESSING;
        end
      end

      interface_state_t::PROCESSING: begin
        if (output_is_ready) begin
          next_interface_state = interface_state_t::DONE;
        end
      end

      interface_state_t::DONE: begin
        if (output_acknowledge) begin
          next_interface_state = interface_state_t::IDLE;
        end
      end
    endcase
  end
endmodule
