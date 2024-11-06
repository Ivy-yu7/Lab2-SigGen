module sinegen #(
    parameter WIDTH = 8
)(
    input logic     clk,
    input logic     rst,
    input logic     en,
    input logic  [WIDTH - 1:0]    offset,
    output logic [WIDTH - 1:0]    dout1,
    output logic [WIDTH - 1:0]    dout2
);

    logic [WIDTH-1:0] count;
    
counter myCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .count (count)
);

rom myRom (
    .addr (count),
    .clk (clk),
    .offset (offset),
    .dout1 (dout1),
    .dout2 (dout2)
);

endmodule



