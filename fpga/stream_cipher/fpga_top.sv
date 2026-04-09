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

  // Inputs --------
  logic [7:0] input_byte;

  // Most significant bit to least significant bit
  assign input_byte = {
    left[7],  // C16 -> input_byte[7]
    ss7[4],  // D16 -> input_byte[6]
    ss7[6],  // E16 -> input_byte[5]
    ss7[0],  // F16 -> input_byte[4]
    ss7[2],  // G16 -> input_byte[3]
    left[5],  // H16 -> input_byte[2]
    ss6[4],  // J15 -> input_byte[1]
    ss6[6]  // G14 -> input_byte[0]
  };

  logic is_key;

  assign is_key = ss7[3];  // B16 -> is_key

  logic reset_hash;

  assign reset_hash = ss7[5];  // D14 -> reset_hash

  logic input_request;  // D15
  // set_io --warn-no-port left[6] D15
  assign input_request = left[6];

  logic output_acknowledge;  // E14
  // set_io --warn-no-port ss7[1] E14 # B
  assign output_acknowledge = ss7[1];

  // Outputs --------

  logic [7:0] output_byte;

  assign pb[5]  = output_byte[7];  // A2 (set_io --warn-no-port pb[5] A2)
  assign pb[6]  = output_byte[6];  // B4 (set_io --warn-no-port pb[6] B4)
  assign pb[7]  = output_byte[5];  // B5 (set_io --warn-no-port pb[7] B5)
  assign pb[8]  = output_byte[4];  // A5 (set_io --warn-no-port pb[8] A5)
  assign pb[9]  = output_byte[3];  // B6 (set_io --warn-no-port pb[9] B6)
  assign pb[11] = output_byte[2];  // A6 (set_io --warn-no-port pb[11] A6)
  assign pb[13] = output_byte[1];  // B7 (set_io --warn-no-port pb[13] B7)
  assign pb[15] = output_byte[0];  // B8 (set_io --warn-no-port pb[15] B8)

  logic input_acknowledged;  // A1
  // set_io --warn-no-port pb[4] A1
  assign pb[4] = input_acknowledged;

  logic output_byte_is_ready;  // B3
  // set_io --warn-no-port pb[1] B3
  assign pb[1] = output_byte_is_ready;


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
