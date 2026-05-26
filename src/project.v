/*
 * Secure V2X Mini Demonstrator
 * LFSR-Based Data Masking
 */

`default_nettype none

module tt_um_push (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,

    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    reg [7:0] lfsr;

    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            lfsr <= 8'h01;
        else
            lfsr <= {lfsr[6:0],
                     lfsr[7]^lfsr[5]^lfsr[4]^lfsr[3]};
    end

    assign uo_out = ui_in ^ lfsr;

    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    wire _unused = &{ena, uio_in, 1'b0};

endmodule
