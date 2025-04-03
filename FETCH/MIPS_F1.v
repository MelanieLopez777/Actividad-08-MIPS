module MIPS_F1(
	input wire clk,
	input wire reset,
	input wire read_enable,
	output [31:0] o_instruction
);

wire [31:0] wire_sum_pc_o_address_pc;
wire [31:0] wire_buffer_pc_o_data;

sum_pc sum_pc_inst(
	.i_address_pc(wire_buffer_pc_o_data),
	.o_address_pc(wire_sum_pc_o_address_pc)
);

buffer_contador_de_programa buffer_contador_de_programa_inst(
	.clk(clk),
	.reset(reset),
    .i_data(wire_sum_pc_o_address_pc),
	.o_data(wire_buffer_pc_o_data)
);

memoria_de_instrucciones memoria_de_instrucciones_inst(
    .read_enable(read_enable),
    .address(wire_buffer_pc_o_data),
    .o_data(o_instruction)
);

endmodule