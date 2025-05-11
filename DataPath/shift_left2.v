//Equipo: Los Muñonez 

`timescale 1ns/1ns

module shift_left2(
    input [31:0] i_inmediate_extended_value,
    output reg [31:0] o_shifted_value
);

always @(*) begin
    o_shifted_value = i_inmediate_extended_value << 2;
end

endmodule