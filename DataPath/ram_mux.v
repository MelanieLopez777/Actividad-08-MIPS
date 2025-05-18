module ram_mux(
    input [1:0] selector,
    input [31:0] i_ram_data,
    input [31:0] i_lb_data,
    input [31:0] i_lbu_data,
    output reg [31:0] o_mux_ram_data
);

always @* begin
    case (selector)
        2'b00: o_mux_ram_data = i_ram_data; // RAM data
        2'b01: o_mux_ram_data = i_lb_data;  // Load Byte
        2'b10: o_mux_ram_data = i_lbu_data; // Load Byte Unsigned
        default: o_mux_ram_data = 32'b0;
    endcase
end

endmodule