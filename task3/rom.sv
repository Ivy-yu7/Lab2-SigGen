module rom #(
    parameter   ADDR_WIDTH = 8,
                DATA_WIDTH = 8
)(
    input   logic                   clk,
    input   logic [ADDR_WIDTH-1:0]  addr,
    input   logic [ADDR_WIDTH-1:0]  offset,
    output  logic [DATA_WIDTH-1:0]  dout1,
    output  logic [DATA_WIDTH-1:0]  dout2
);

logic [DATA_WIDTH-1:0] rom_array[2**ADDR_WIDTH-1:0];

initial begin
        $display("Loading rom.");
        $readmemh("sinerom.mem", rom_array);
end;

always_ff @(posedge clk) begin
    dout1 <= rom_array[addr];
    dout2 <= rom_array[addr + offset];
end

endmodule
