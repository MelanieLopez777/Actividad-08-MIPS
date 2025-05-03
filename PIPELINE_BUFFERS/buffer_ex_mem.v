//Equipo: Los Muñonez

`timescale 1ns/1ns

module buffer_ex_mem (
	input clk,
	input i_zflag,
	input [31:0] i_alu_result,
	input [31:0] i_read_rb_2,
	input [31:0] i_address_pc,
	input [4:0] i_write_address,
	output reg o_zflag,
	output reg [31:0] o_alu_result,
	output reg [31:0] o_read_rb_2,
	output reg [31:0] o_address_pc,
	output reg [4:0] o_write_address
);

always @(posedge clk) begin
	o_address_pc = i_address_pc;
	o_zflag = i_zflag;
	o_alu_result = i_alu_result;
	o_read_rb_2 = i_read_rb_2;
	o_write_address = i_write_address;
end

endmodule