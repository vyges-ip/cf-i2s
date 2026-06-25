// Vyges integration facade for the ChipFoundry CF_I2S (APB variant).
//
// Presents the uniform Vyges peripheral surface — clk_i / rst_ni + a clean APB4
// slave + the I2S pads (ws/sck/sdi) + IRQ — by wrapping CF_I2S_APB (which uses
// PCLK/PRESETn). Keeps the soc-generator wiring generic: the SoC's APB sub-bus
// connects per-signal, no ChipFoundry-specific clock/reset names at the boundary.
//
// Mirrors vyges_cf_uart_apb. (CF_I2S_APB instantiates cf_util_* from cf-ip-util.)
//
// SPDX-License-Identifier: Apache-2.0

module vyges_cf_i2s_apb (
  input  wire        clk_i,
  input  wire        rst_ni,
  // APB4 slave
  input  wire [31:0] PADDR,
  input  wire        PWRITE,
  input  wire [31:0] PWDATA,
  input  wire        PSEL,
  input  wire        PENABLE,
  output wire        PREADY,
  output wire [31:0] PRDATA,
  // I2S pads
  output wire        ws,
  output wire        sck,
  input  wire        sdi,
  // Interrupt
  output wire        IRQ
);

  CF_I2S_APB u_cf_i2s_apb (
    .PCLK    (clk_i),
    .PRESETn (rst_ni),
    .PADDR   (PADDR),
    .PWRITE  (PWRITE),
    .PWDATA  (PWDATA),
    .PSEL    (PSEL),
    .PENABLE (PENABLE),
    .PREADY  (PREADY),
    .PRDATA  (PRDATA),
    .IRQ     (IRQ),
    .ws      (ws),
    .sck     (sck),
    .sdi     (sdi)
  );

endmodule
