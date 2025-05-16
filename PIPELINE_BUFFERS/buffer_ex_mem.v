//Equipo: Los Muñonez

`timescale 1ns/1ns

module buffer_ex_mem (
	input clk,
	input [31:0] i_alu_result,
	input [31:0] i_read_rb_2,
	input [31:0] i_branch_address,
	input [4:0]  i_inst_mux_br_write_address,
	input [31:0] i_jump_address,
	input i_zf,
	input i_branch,
	input i_memWrite,
	input i_memRead,
	input i_regWrite,
	input i_memToReg,
	input i_jump,
	output reg [31:0] o_alu_result,
	output reg [31:0] o_read_rb_2,
	output reg [31:0] o_branch_address,
	output reg [4:0]  o_inst_mux_br_write_address,
	output reg [31:0] o_jump_address,
	output reg o_zf,
	output reg o_branch,
	output reg o_memWrite,
	output reg o_memRead,
	output reg o_regWrite,
	output reg o_memToReg,
	output reg o_jump
);

always @(posedge clk) begin
	o_alu_result = i_alu_result;
	o_read_rb_2 = i_read_rb_2;
	o_branch_address = i_branch_address;
	o_inst_mux_br_write_address = i_inst_mux_br_write_address;
	o_zf = i_zf;
	o_branch = i_branch;
	o_memWrite = i_memWrite;
	o_memRead = i_memRead;
	o_regWrite = i_regWrite;
	o_memToReg = i_memToReg;
	o_jump = i_jump;
	o_jump_address = i_jump_address;
end

endmodule