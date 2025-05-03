//Equipo: Los Muñonez

`timescale 1ns/1ns

module buffer_id_ex (
	input clk,
	input [31:0] i_read_rb_1,
	input [31:0] i_read_rb_2,
	input [5:0] i_alu_control_func,
	input [31:0] i_address_pc,
	input [4:0] i_write_address,
	output reg [31:0] o_read_rb_1,
	output reg [31:0] o_read_rb_2,
	output reg [5:0] o_alu_control_func,
	output reg [31:0] o_address_pc,
	output reg [4:0] o_write_address
);
	
always @(posedge clk) begin
	o_address_pc = i_address_pc;
	o_read_rb_1 = i_read_rb_1;
	o_read_rb_2 = i_read_rb_2;
	o_alu_control_func = i_alu_control_func;
	o_write_address = i_write_address;
end

endmodule