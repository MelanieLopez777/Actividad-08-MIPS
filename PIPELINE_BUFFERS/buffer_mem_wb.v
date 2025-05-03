//Equipo: Los Muñonez

`timescale 1ns/1ns

module buffer_mem_wb (
	input clk,
	input [31:0] i_ram_data,
	input [31:0] i_alu_result,
	input [4:0] i_write_address,
	output reg [31:0] o_ram_data,
	output reg [31:0] o_alu_result,
	output reg [4:0] o_write_address

);

always @(posedge clk) begin
	o_ram_data = i_ram_data;
	o_alu_result = i_alu_result;
	o_write_address = i_write_address;
end

endmodule