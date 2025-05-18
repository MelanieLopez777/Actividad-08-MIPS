module zero_extend_ram (
    input [1:0] i_byte_offset,
    input [31:0] i_selected_data,
    output reg [31:0] o_extended_data
);

always @* begin
    case (i_byte_offset)
        2'b00: o_extended_data = {{24'b0}, i_selected_data[7:0]};   // Byte 0
        2'b01: o_extended_data = {{24'b0}, i_selected_data[15:8]};  // Byte 1
        2'b10: o_extended_data = {{24'b0}, i_selected_data[23:16]}; // Byte 2
        2'b11: o_extended_data = {{24'b0}, i_selected_data[31:24]}; // Byte 3
        default: o_extended_data = 32'b0;
    endcase
end

endmodule