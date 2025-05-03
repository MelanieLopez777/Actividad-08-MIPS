//Equipo: Los Muñonez

`timescale 1ns/1ns

module buffer_if_id (
    input clk,
    input [31:0] i_instruction,
	input [31:0] i_address_pc,
	output reg [31:0] o_instruction,
	output reg [31:0] o_address_pc
);

always @(posedge clk) begin
	o_address_pc = i_address_pc;
	o_instruction = i_instruction;
end
    
endmodule