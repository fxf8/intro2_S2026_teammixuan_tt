module interface_reader_tb ();

  // Define local parameters used by the test bench
  localparam CLK_PERIOD = 10;

  // Declare DUT portmap signals
  logic tb_clk;
  logic tb_nrst;


  // Clock generation block
  always begin
    #(CLK_PERIOD / 2.0);
    tb_clk++;
  end

  // Signal dump
  initial begin
    $dumpfile("support/waves/stream_cipher/packed_structs.vcd");
    $dumpvars;
  end

  typedef struct packed {
    logic [7:0] byte_;
    logic pulse;
  } byte_pulse_t;

  logic [7:0] byte_;
  logic pulse;

  byte_pulse_t byte_pulse;

  assign byte_ = byte_pulse.byte_;
  assign pulse = byte_pulse.pulse;

  // Test bench main process
  initial begin
    // Initialize all of the test inputs here
    tb_clk  = 0;
    tb_nrst = 1;

    @(negedge tb_clk);

    byte_pulse.byte_ = 8'h00;
    byte_pulse.pulse = 1'b0;

    @(negedge tb_clk);

    byte_pulse.byte_ = 8'h01;
    byte_pulse.pulse = 1'b1;

    repeat (5) @(negedge tb_clk);

    byte_pulse.byte_ = 8'h02;
    byte_pulse.pulse = 1'b0;

    repeat (5) @(negedge tb_clk);

    $finish;

  end

endmodule
