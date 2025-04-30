//Equipo: Los Muñonez

`timescale 1ns/1ns

module datapath_tipo_r (
	input [31:0] instruction,
	output Zflag
);

// Cables unidad de control
wire cu_mem_to_reg;
wire cu_mem_write_enable;
wire cu_mem_read_enable;
wire [2:0] cu_alu_op_code;
wire cu_reg_write;

// Cables banco de registros
wire [31:0] br_read_data_1;
wire [31:0] br_read_data_2;

// Cables alu
wire [31:0] alu_result_alu;
wire alu_ZF;

// Cables Unidad de control Alu
wire [3:0] cu_alu_alu_code;

// Cables Ram
wire [31:0] ram_dout;

// Cables multiplexor
wire [31:0] mux_out;

unidad_de_control unidad_de_control_inst(
	.op_code(instruction[31:26]),
    .mem_to_reg(cu_mem_to_reg),
    .mem_write_enable(cu_mem_write_enable),
	.mem_read_enable(cu_mem_read_enable),
    .alu_op_code(cu_alu_op_code),
    .reg_write(cu_reg_write)
);

banco_de_registros banco_de_registros_inst
(
    .write_enable(cu_reg_write),
    .read_reg_1(instruction[25:21]),
    .read_reg_2(instruction[20:16]),
    .write_reg(instruction[15:11]),
    .write_data(mux_out),
    .read_data_1(br_read_data_1),
    .read_data_2(br_read_data_2)
);

alu alu_inst(
	.op(cu_alu_alu_code),
 	.din1_alu(br_read_data_1),
 	.din2_alu(br_read_data_2),
 	.result_alu(alu_result_alu),
 	.ZF(Zflag)
);

unidad_de_control_alu unidad_de_control_alu_inst(
	.alu_op(cu_alu_op_code),
	.func_field(instruction[5:0]),
	.alu_code(cu_alu_alu_code)
);

ram ram_inst(
	.address(alu_result_alu),
	.din(br_read_data_2),
	.write_enable(cu_mem_write_enable),
    .read_enable(cu_mem_read_enable),
	.dout(ram_dout)
);

multiplexor multiplexor_inst(
	.selector(cu_mem_to_reg),
    .i_ram(ram_dout),
    .i_alu(alu_result_alu),
    .result(mux_out)
);
	
endmodule