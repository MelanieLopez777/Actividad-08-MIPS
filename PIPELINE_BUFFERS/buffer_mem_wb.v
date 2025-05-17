//Equipo: Los Muñonez

`timescale 1ns/1ns

module buffer_mem_wb (
	input clk,
	input [31:0] i_ram_data,
	input [31:0] i_alu_result,
	input [4:0] i_inst_mux_br_write_address,
	input i_regWrite,
	input i_memToReg,
	output reg [31:0] o_ram_data,
	output reg [31:0] o_alu_result,
	output reg [4:0]  o_inst_mux_br_write_address,
	output reg        o_regWrite,
	output reg        o_memToReg

);

always @(posedge clk) begin
	o_ram_data <= i_ram_data;
	o_alu_result <= i_alu_result;
	o_inst_mux_br_write_address <= i_inst_mux_br_write_address;
	o_regWrite <= i_regWrite;
	o_memToReg <= i_memToReg;
end

endmodule