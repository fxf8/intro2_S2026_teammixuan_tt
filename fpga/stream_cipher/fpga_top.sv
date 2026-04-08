`default_nettype none
// Empty top module (do not modify the ports)

module fpga_top (
    // I/O ports
    input logic hz100,
    reset,
    input logic [20:0] pb,
    output logic [7:0] left,
    right,
    ss7,
    ss6,
    ss5,
    ss4,
    ss3,
    ss2,
    ss1,
    ss0,
    output logic red,
    green,
    blue,

    // UART ports
    output logic [7:0] txdata,
    input logic [7:0] rxdata,
    output logic txclk,
    rxclk,
    input logic txready,
    rxready
);
  /*
* module top (
    input logic clk,
    nrst,  // clock and negative-edge reset
    //other signals here

    // General Data Pins
    input logic [7:0] input_byte,
    input logic is_key,
    input logic reset_hash,

    // 4-Phase-Handshake Interfacing pins in order of change
    input  logic input_request,
    output logic input_acknowledged,
    output logic output_byte_is_ready,
    input  logic output_acknowledge,

    // Output Byte
    output logic [7:0] output_byte
);

*/
  logic [7:0] input_byte;
  logic is_key;
  logic reset_hash;

  logic input_request;
  logic input_acknowledged;
  logic output_byte_is_ready;
  logic output_acknowledge;

  logic [7:0] output_byte;

  // Your code goes here...
  top #() top_inst (
      .clk (hz100),
      .nrst(!reset),

      // General Data Pins
      .*
  );

endmodule
