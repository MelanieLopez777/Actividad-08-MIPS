// Equipo: Los Muñonez

`timescale 1ns/1ns

module byte_generator(
    input [31:0] i_memory_address,
    input [5:0] i_opcode,
    output reg [3:0] o_byte_enable
);

always @* begin
    case (i_opcode)
        // sb
        6'b101000: 
        begin
            case (i_memory_address[1:0])
                2'b00: o_byte_enable = 4'b0001;
                2'b01: o_byte_enable = 4'b0010;
                2'b10: o_byte_enable = 4'b0100;
                2'b11: o_byte_enable = 4'b1000;
            endcase
        end
        // sh
        6'b101001:
        begin
            o_byte_enable = (i_memory_address[1] == 0) ? 4'b0011 : 4'b1100;
        end
        // sw
        6'b101011:
        begin
            o_byte_enable = 4'b1111;
        end
        default: o_byte_enable = 4'b0000;
    endcase
end

endmodule