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

  // set_io --warn-no-port ss0[7] B1 # DP
  assign ss0[7] = 1'b1;

  // Inputs --------
  logic [7:0] input_byte;

  // Most significant bit to least significant bit
  assign input_byte = {
    pb[5],  // set_io --warn-no-port pb[5] A2 -> input_byte[7]
    pb[6],  // set_io --warn-no-port pb[6] B4 -> input_byte[6]
    pb[7],  // set_io --warn-no-port pb[7] B5 -> input_byte[5]
    pb[8],  // set_io --warn-no-port pb[8] A5 -> input_byte[4]
    pb[9],  // set_io --warn-no-port pb[9] B6 -> input_byte[3]
    pb[11],  // set_io --warn-no-port pb[11] A6 -> input_byte[2]
    pb[13],  // set_io --warn-no-port pb[13] B7 -> input_byte[1]
    pb[15]  // set_io --warn-no-port pb[15] B8 -> input_byte[0]
  };

  logic is_key;
  assign is_key = pb[4];  // set_io --warn-no-port pb[4] A1

  logic reset_hash;
  assign reset_hash = pb[1];  // set_io --warn-no-port pb[1] B3

  logic input_request;
  assign input_request = pb[0];  // set_io --warn-no-port pb[0] C3

  logic output_acknowledge;
  assign output_acknowledge = pb[2];  // set_io --warn-no-port pb[2] C4

  // Outputs --------

  logic [7:0] output_byte;

  assign left[7] = output_byte[7];  // set_io --warn-no-port left[7] C16
  assign ss7[4]  = output_byte[6];  // set_io --warn-no-port ss7[4] D16
  assign ss7[6]  = output_byte[5];  // set_io --warn-no-port ss7[6] E16
  assign ss7[0]  = output_byte[4];  // set_io --warn-no-port ss7[0] F16
  assign ss7[2]  = output_byte[3];  // set_io --warn-no-port ss7[2] G16
  assign left[5] = output_byte[2];  // set_io --warn-no-port left[5] H16
  assign ss6[4]  = output_byte[1];  // set_io --warn-no-port ss6[4] J15
  assign ss6[6]  = output_byte[0];  // set_io --warn-no-port ss6[6] G14

  logic input_acknowledged;  // set_io --warn-no-port ss7[3] B16
  assign ss7[3] = input_acknowledged;

  logic output_byte_is_ready;  // set_io --warn-no-port ss7[5] D14
  assign ss7[5] = output_byte_is_ready;


  // Your code goes here...
  top #() top_inst (
      .clk (hz100),
      .nrst(!reset),

      // General Data Pins
      .*
  );

endmodule

/*
  logic [31:0] counter;
  logic [31:0] next_counter;
  assign ss0[0] = 1'b1;

  logic green_led;
  logic next_green_led;

  logic red_led;
  logic next_red_led;

  assign left[7] = green_led;
  assign ss7[6]  = red_led;

  always_comb begin
    next_counter   = counter + 1;

    next_green_led = green_led;
    next_red_led   = red_led;

    if (next_counter > 100) begin  // 1 second
      next_counter   = 0;

      if (next_green_led == 1'b1) begin
        next_green_led = 0;
        next_red_led   = 1;
      end else begin
        next_green_led = 1;
        next_red_led   = 0;
      end
    end
  end

  always_ff @(posedge hz100 or posedge reset) begin
    if (reset) begin
      counter   <= 0;
      green_led <= 0;
      red_led   <= 1;

    end else begin
      counter   <= next_counter;
      green_led <= next_green_led;
      red_led   <= next_red_led;
    end
  end
  */
