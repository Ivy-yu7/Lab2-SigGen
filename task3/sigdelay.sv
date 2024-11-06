module sigdelay #(
    parameter WIDTH = 8
)(
    input logic     clk,
    input logic     rst,
    input logic     en,
    input logic     wr,    
    input logic     rd,    
    input logic [WIDTH - 1:0]    offset,
    input logic [WIDTH - 1:0]    mic_signal,
    output logic [WIDTH - 1:0]   delayed_signal
);

    logic [WIDTH-1:0] count;
    
counter myCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .count (count)
);

ram2ports myRam (
    .clk (clk),
    .wr_en (wr),
    .rd_en (rd),
    .wr_addr (count + offset),
    .rd_addr (count),
    .din (mic_signal),
    .dout (delayed_signal)
);

endmodule



