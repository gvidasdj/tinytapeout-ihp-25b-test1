/*
 * Copyright (c) 2025 Gvidas Sidlauskas
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_gvidasdj_daclogic (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
  
    output reg clk_div2,
    output reg clk_div4,
    output reg clk_div8,
    output reg clk_div16,
    output reg clk_div32,
    output reg clk_div64,
    output reg clk_div128,
    output reg clk_div256,
    output reg [7:0] counter,
    output cntr_div2,
    output cntr_div4,
    output cntr_div8,
    output cntr_div16,
    output cntr_div32,
    output cntr_div64,
    output cntr_div128,
    output cntr_div256
);
  // simple ripple clock divider
  
  always @(posedge clk)
    clk_div2 <= ~clk_div2;

  always @(posedge clk_div2)
    clk_div4 <= ~clk_div4;

  always @(posedge clk_div4)
    clk_div8 <= ~clk_div8;

  always @(posedge clk_div8)
    clk_div16 <= ~clk_div16;
  
  always @(posedge clk_div16)
    clk_div32 <= ~clk_div32;

  always @(posedge clk_div32)
    clk_div64 <= ~clk_div64;
  
  always @(posedge clk_div64)
    clk_div128 <= ~clk_div128;

  always @(posedge clk_div128)
    clk_div256 <= ~clk_div256;


  // use bits of (8-bit) counter to divide clocks
  
  always @(posedge clk or negedge rst_n)
  begin
    if (rst_n)
      counter <= 0;
    else
      counter <= counter + 1;
  end
    
  assign cntr_div2 = counter[0];
  assign cntr_div4 = counter[1];
  assign cntr_div8 = counter[2];
  assign cntr_div16 = counter[3];
  assign cntr_div32 = counter[4];
  assign cntr_div64 = counter[5];
  assign cntr_div128 = counter[6];
  assign cntr_div256 = counter[7];

    
  // All output pins must be assigned. If not used, assign to 0.
  // assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uo_out  =  counter;
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule
