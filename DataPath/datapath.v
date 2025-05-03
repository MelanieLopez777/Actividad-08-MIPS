//Equipo: Los Muñonez

`timescale 1ns/1ns

module datapath (
	input wire clk,
	input wire reset,
	output Zflag
);

// Cables Buffers
wire [31:0] wire_buffer_if_id_o_instruction;
wire [31:0] wire_buffer_if_id_o_address_pc;
wire [31:0] wire_buffer_id_ex_o_read_rb_1;
wire [31:0] wire_buffer_id_ex_o_read_rb_2;
wire [5:0] wire_buffer_id_ex_o_alu_control_func;
wire [31:0] wire_buffer_id_ex_o_address_pc;
wire [4:0] wire_buffer_id_ex_o_write_address;
wire [31:0] wire_buffer_ex_mem_o_alu_result;
wire [31:0] wire_buffer_ex_mem_o_read_rb_2;
wire [31:0] wire_buffer_ex_mem_o_address_pc;
wire [4:0] wire_buffer_ex_mem_o_write_address;
wire [31:0] wire_buffer_mem_wb_o_ram_data;
wire [31:0] wire_buffer_mem_wb_o_alu_result;
wire [4:0] wire_buffer_mem_wb_o_write_address;


// Cables Memoria de instrucciones
wire [31:0] wire_instruction;

// Cables unidad de control
wire wire_cu_mem_to_reg;
wire wire_cu_mem_write_enable;
wire wire_cu_mem_read_enable;
wire [2:0] wire_cu_alu_op_code;
wire wire_cu_reg_write;

// Cables banco de registros
wire [31:0] wire_rb_read_data_1;
wire [31:0] wire_rb_read_data_2;

// Cables alu
wire [31:0] wire_alu_result_alu;
wire wire_alu_zflag;

// Cables Unidad de control Alu
wire [3:0] wire_cu_alu_alu_code;

// Cables Ram
wire [31:0] wire_ram_dout;

// Cables multiplexor
wire [31:0] wire_mux_out;

// Cables contador
wire [31:0] wire_sum_pc_o_address_pc;
wire [31:0] wire_buffer_pc_o_data;

buffer_if_id buffer_if_id_inst(
	.clk(clk),
	.i_instruction(wire_instruction),
	.i_address_pc(wire_sum_pc_o_address_pc),
	.o_instruction(wire_buffer_if_id_o_instruction),
	.o_address_pc(wire_buffer_if_id_o_address_pc)
);

buffer_id_ex buffer_id_ex_inst(
	.clk(clk),
	.i_read_rb_1(wire_rb_read_data_1),
	.i_read_rb_2(wire_rb_read_data_2),
	.i_alu_control_func(wire_buffer_if_id_o_instruction[5:0]),
	.i_address_pc(wire_buffer_if_id_o_address_pc),
	.i_write_address(wire_buffer_if_id_o_instruction[15:11]),
	.o_read_rb_1(wire_buffer_id_ex_o_read_rb_1),
	.o_read_rb_2(wire_buffer_id_ex_o_read_rb_2),
	.o_alu_control_func(wire_buffer_id_ex_o_alu_control_func),
	.o_address_pc(wire_buffer_id_ex_o_address_pc),
	.o_write_address(wire_buffer_id_ex_o_write_address)
);

buffer_ex_mem buffer_ex_mem_inst(
	.clk(clk),
	.i_zflag(wire_alu_zflag),
	.i_alu_result(wire_alu_result_alu),
	.i_read_rb_2(wire_buffer_id_ex_o_read_rb_2),
	.i_address_pc(wire_buffer_id_ex_o_address_pc),
	.i_write_address(wire_buffer_id_ex_o_write_address),
	.o_zflag(Zflag),
	.o_alu_result(wire_buffer_ex_mem_o_alu_result),
	.o_read_rb_2(wire_buffer_ex_mem_o_read_rb_2),
	.o_address_pc(wire_buffer_ex_mem_o_address_pc),
	.o_write_address(wire_buffer_ex_mem_o_write_address)
);

buffer_mem_wb buffer_mem_wb_inst(
	.clk(clk),
	.i_ram_data(wire_ram_dout),
	.i_alu_result(wire_buffer_ex_mem_o_alu_result),
	.i_write_address(wire_buffer_ex_mem_o_write_address),
	.o_ram_data(wire_buffer_mem_wb_o_ram_data),
	.o_alu_result(wire_buffer_mem_wb_o_alu_result),
	.o_write_address(wire_buffer_mem_wb_o_write_address)
);

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
    .address(wire_buffer_pc_o_data),
    .o_data(wire_instruction)
);

unidad_de_control unidad_de_control_inst(
	.op_code(wire_buffer_if_id_o_instruction[31:26]),
    .mem_to_reg(wire_cu_mem_to_reg),
    .mem_write_enable(wire_cu_mem_write_enable),
	.mem_read_enable(wire_cu_mem_read_enable),
    .alu_op_code(wire_cu_alu_op_code),
    .reg_write(wire_cu_reg_write)
);

banco_de_registros banco_de_registros_inst
(
    .write_enable(wire_cu_reg_write),
    .read_reg_1(wire_buffer_if_id_o_instruction[25:21]),
    .read_reg_2(wire_buffer_if_id_o_instruction[20:16]),
    .write_reg(wire_buffer_mem_wb_o_write_address),
    .write_data(wire_mux_out),
    .read_data_1(wire_rb_read_data_1),
    .read_data_2(wire_rb_read_data_2)
);

alu alu_inst(
	.op(wire_cu_alu_alu_code),
 	.din1_alu(wire_buffer_id_ex_o_read_rb_1),
 	.din2_alu(wire_buffer_id_ex_o_read_rb_2),
 	.result_alu(wire_alu_result_alu),
 	.ZF(wire_alu_zflag)
);

unidad_de_control_alu unidad_de_control_alu_inst(
	.alu_op(wire_cu_alu_op_code),
	.func_field(wire_buffer_id_ex_o_alu_control_func),
	.alu_code(wire_cu_alu_alu_code)
);

ram ram_inst(
	.address(wire_buffer_ex_mem_o_alu_result),
	.din(wire_buffer_ex_mem_o_read_rb_2),
	.write_enable(wire_cu_mem_write_enable),
    .read_enable(wire_cu_mem_read_enable),
	.dout(wire_ram_dout)
);

multiplexor multiplexor_inst(
	.selector(wire_cu_mem_to_reg),
    .i_ram(wire_buffer_mem_wb_o_ram_data),
    .i_alu(wire_buffer_mem_wb_o_alu_result),
    .result(wire_mux_out)
);
	
endmodule