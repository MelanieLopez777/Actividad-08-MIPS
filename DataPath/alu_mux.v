//Equipo: Los Muñonez

`timescale 1ns/1ns

module alu_mux(
    input aluSrc,
    input [31:0] i_read_data_2,
    input [31:0] i_immediate_extended_value,
    output reg [31:0] result
);

always @* begin
    if(aluSrc == 1'b1) begin
        result = i_immediate_extended_value;
    end
    else begin
        result = i_read_data_2;
    end
end

endmodule