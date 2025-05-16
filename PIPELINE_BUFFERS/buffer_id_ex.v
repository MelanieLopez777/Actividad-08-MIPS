//Equipo: Los Muñonez

`timescale 1ns/1ns

module buffer_id_ex (
	input clk,
	input [31:0] i_read_rb_1,
	input [31:0] i_read_rb_2,
	input [4:0]  i_rt,
	input [4:0]  i_rd,
	input [31:0] i_address_pc,
	input [31:0] i_ext_sign,
	input [31:0] i_jump_address,
	input i_branch,
	input i_memRead,
	input [2:0] i_aluOp,
	input i_memWrite,
	input i_aluSrc,
	input i_regWrite,
	input i_memToReg,
	input i_regDst,
	input i_jump,
	output reg [31:0] o_read_rb_1,
	output reg [31:0] o_read_rb_2,
	output reg [4:0]  o_rt,
	output reg [4:0]  o_rd,
	output reg [31:0] o_address_pc,
	output reg [31:0] o_ext_sign,
	output reg [31:0] o_jump_address,
	output reg o_branch,
	output reg o_memRead,
	output reg [2:0] o_aluOp,
	output reg o_memWrite,
	output reg o_aluSrc,
	output reg o_regWrite,
	output reg o_memToReg,
	output reg o_regDst,
	output reg o_jump
);
	
always @(posedge clk) begin
	o_read_rb_1 =  i_read_rb_1;  
	o_read_rb_2 = i_read_rb_2;
	o_rt = i_rt;
	o_rd = i_rd;
	o_address_pc = i_address_pc;
	o_ext_sign = i_ext_sign;
	o_branch = i_branch;
	o_memRead = i_memRead;
	o_aluOp = i_aluOp;
	o_memWrite = i_memWrite;
	o_aluSrc = i_aluSrc;
	o_regWrite = i_regWrite;
	o_memToReg = i_memToReg;
	o_regDst = i_regDst;
	o_jump = i_jump;
	o_jump_address = i_jump_address;
end

endmodule