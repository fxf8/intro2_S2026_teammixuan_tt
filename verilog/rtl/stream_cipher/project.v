`default_nettype none

module stream_cipher (
`ifdef USE_POWER_PINS
    inout             VPWR,
    inout             VGND,
`endif
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.

  /*
  assign uo_out[7:1] = '0;
  assign uio_out = '0;
  assign uio_oe = '0;
  */

  assign uio_oe[7:0] = 8'b00000110;

  assign uio_out[0]  = 1'b0;
  assign uio_out[3]  = 1'b0;
  assign uio_out[4]  = 1'b0;
  assign uio_out[5]  = 1'b0;
  assign uio_out[6]  = 1'b0;
  assign uio_out[7]  = 1'b0;

  top #() top_inst (
      .clk (clk),
      .nrst(rst_n),

      // General Data Pins
      .input_byte(ui_in),
      .is_key(uio_in[4]),
      .reset_hash(uio_in[5]),

      // 4-Phase-Handshake Interfacing pins in order of change
      .input_request(uio_in[0]),
      .input_acknowledged(uio_out[1]),
      .output_byte_is_ready(uio_out[2]),
      .output_acknowledge(uio_in[3]),

      // Output Byte
      .output_byte(uo_out)
  );

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in[1], uio_in[2], uio_in[6], uio_in[7], 1'b0};

endmodule

