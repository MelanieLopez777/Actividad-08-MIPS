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
wire [4:0]  wire_buffer_id_ex_o_rt;
wire [4:0]  wire_buffer_id_ex_o_rd;
wire [31:0] wire_buffer_id_ex_o_address_pc;
wire [31:0] wire_buffer_id_ex_o_ext_sign;
wire wire_buffer_id_ex_o_branch;
wire wire_buffer_id_ex_o_memRead;
wire [2:0] wire_buffer_id_ex_o_aluOp;
wire wire_buffer_id_ex_o_memWrite;
wire wire_buffer_id_ex_o_aluSrc;
wire wire_buffer_id_ex_o_regWrite;
wire wire_buffer_id_ex_o_memToReg;
wire wire_buffer_id_ex_o_regDst;


wire [31:0] wire_buffer_ex_mem_o_alu_result;
wire [31:0] wire_buffer_ex_mem_o_read_rb_2;
wire [31:0] wire_buffer_ex_mem_o_branch_address;
wire [4:0]  wire_buffer_ex_mem_o_inst_mux_br_write_address;
wire wire_buffer_ex_mem_o_zf;
wire wire_buffer_ex_mem_o_branch;
wire wire_buffer_ex_mem_o_memWrite;
wire wire_buffer_ex_mem_o_regWrite;
wire wire_buffer_ex_mem_o_memToReg;

wire [31:0] wire_buffer_mem_wb_o_ram_data;
wire [31:0] wire_buffer_mem_wb_o_alu_result;
wire [4:0]  wire_buffer_mem_wb_o_inst_mux_br_write_address;
wire wire_buffer_mem_wb_o_regWrite;
wire wire_buffer_mem_wb_o_memToReg;


// Cables Memoria de instrucciones
wire [31:0] wire_instruction;

// Cables unidad de control
wire wire_cu_o_branch;
wire [2:0] wire_cu_o_aluOp;
wire wire_cu_o_aluSrc;
wire wire_cu_o_memRead;
wire wire_cu_o_memWrite;
wire wire_cu_o_memToReg;
wire wire_cu_o_regWrite;
wire wire_cu_o_regDst;

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

// Cables contador alu
wire [31:0] wire_sum_alu_o_branch_address;

// Cables extensor de signo 
wire [31:0] wire_ext_sign_o_inmediate_extended_value;

// Cables shift left 2
wire [31:0] wire_shift_left_o_shifted_value;

// Cables instruction mux
wire [4:0] wire_inst_mux_o_br_write_address;

// Cables alu mux
wire [31:0] wire_alu_mux_o_alu_data_2;

// Cables and_branch
wire wire_and_branch_result;

// Cables pc mux
wire [31:0] wire_pc_mux_o_result_pc_address;


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
	.i_rt(wire_buffer_if_id_o_instruction[20:16]),
	.i_rd(wire_buffer_if_id_o_instruction[15:11]),
	.i_address_pc(wire_buffer_if_id_o_address_pc),
	.i_ext_sign(wire_ext_sign_o_inmediate_extended_value),
	.i_branch(wire_cu_o_branch),
	.i_memRead(wire_cu_o_memRead),
	.i_aluOp(wire_cu_o_aluOp),
	.i_memWrite(wire_cu_o_memWrite),
	.i_aluSrc(wire_cu_o_aluSrc),
	.i_regWrite(wire_cu_o_regWrite),
	.i_memToReg(wire_cu_o_memToReg),
	.i_regDst(wire_cu_o_regDst),
	.o_read_rb_1(wire_buffer_id_ex_o_read_rb_1),
	.o_read_rb_2(wire_buffer_id_ex_o_read_rb_2),
	.o_rt(wire_buffer_id_ex_o_rt),
	.o_rd(wire_buffer_id_ex_o_rd),
	.o_address_pc(wire_buffer_id_ex_o_address_pc),
	.o_ext_sign(wire_buffer_id_ex_o_ext_sign),
	.o_branch(wire_buffer_id_ex_o_branch),
	.o_memRead(wire_buffer_id_ex_o_memRead),
	.o_aluOp(wire_buffer_id_ex_o_aluOp),
	.o_memWrite(wire_buffer_id_ex_o_memWrite),
	.o_aluSrc(wire_buffer_id_ex_o_aluSrc),
	.o_regWrite(wire_buffer_id_ex_o_regWrite),
	.o_memToReg(wire_buffer_id_ex_o_memToReg),
	.o_regDst(wire_buffer_id_ex_o_regDst)
);

buffer_ex_mem buffer_ex_mem_inst(
	.clk(clk),
	.i_alu_result(wire_alu_result_alu),
	.i_read_rb_2(wire_buffer_id_ex_o_read_rb_2),
	.i_branch_address(wire_sum_alu_o_branch_address),
	.i_inst_mux_br_write_address(wire_inst_mux_o_br_write_address),
	.i_zf(wire_alu_zflag),
	.i_branch(wire_buffer_id_ex_o_branch),
	.i_memWrite(wire_buffer_id_ex_o_memWrite),
	.i_regWrite(wire_buffer_id_ex_o_regWrite),
	.i_memToReg(wire_buffer_id_ex_o_memToReg),
	.o_alu_result(wire_buffer_ex_mem_o_alu_result),
	.o_read_rb_2(wire_buffer_ex_mem_o_read_rb_2),
	.o_branch_address(wire_buffer_ex_mem_o_branch_address),
	.o_inst_mux_br_write_address(wire_buffer_ex_mem_o_inst_mux_br_write_address),
	.o_zf(wire_buffer_ex_mem_o_zf),
	.o_branch(wire_buffer_ex_mem_o_branch),
	.o_memWrite(wire_buffer_ex_mem_o_memWrite),
	.o_regWrite(wire_buffer_ex_mem_o_regWrite),
	.o_memToReg(wire_buffer_ex_mem_o_memToReg)
);

buffer_mem_wb buffer_mem_wb_inst(
	.clk(clk),
	.i_ram_data(wire_ram_dout),
	.i_alu_result(wire_buffer_ex_mem_o_alu_result),
	.i_inst_mux_br_write_address(wire_buffer_ex_mem_o_inst_mux_br_write_address),
	.i_regWrite(wire_buffer_ex_mem_o_regWrite),
	.i_memToReg(wire_buffer_ex_mem_o_memToReg),
	.o_ram_data(wire_buffer_mem_wb_o_ram_data),
	.o_alu_result(wire_buffer_mem_wb_o_alu_result),
	.o_inst_mux_br_write_address(wire_buffer_mem_wb_o_inst_mux_br_write_address),
	.o_regWrite(wire_buffer_mem_wb_o_regWrite),
	.o_memToReg(wire_buffer_mem_wb_o_memToReg)
);

sum_pc sum_pc_inst(
	.i_address_pc(wire_buffer_pc_o_data),
	.o_address_pc(wire_sum_pc_o_address_pc)
);

sum_ALU sum_ALU_inst(
	.i_pc_address(wire_buffer_id_ex_o_address_pc),               
    .i_shifted_value(wire_ext_sign_o_inmediate_extended_value),
    .o_branch_address(wire_sum_alu_o_branch_address)  
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
    .branch(wire_cu_o_branch),
    .memRead(wire_cu_o_memRead),
    .aluOp(wire_cu_o_aluOp),
    .memWrite(wire_cu_o_memWrite),
	.aluSrc(wire_cu_o_aluSrc),
    .regWrite(wire_cu_o_regWrite),
    .memToReg(wire_cu_o_memToReg),
	.regDst(wire_cu_o_regDst)
);

banco_de_registros banco_de_registros_inst
(
    .write_enable(wire_cu_reg_write),
    .read_reg_1(wire_buffer_if_id_o_instruction[25:21]),
    .read_reg_2(wire_buffer_if_id_o_instruction[20:16]),
    .write_reg(wire_buffer_mem_wb_o_inst_mux_br_write_address),
    .write_data(wire_mux_out),
    .read_data_1(wire_rb_read_data_1),
    .read_data_2(wire_rb_read_data_2)
);

alu alu_inst(
	.op(wire_cu_alu_alu_code),
 	.din1_alu(wire_buffer_id_ex_o_read_rb_1),
 	.din2_alu(wire_alu_mux_o_alu_data_2),
 	.result_alu(wire_alu_result_alu),
 	.ZF(wire_alu_zflag)
);

extensor_signo extensor_signo_inst(
   .i_inmediate_value(wire_buffer_if_id_o_instruction[15:0]),   
   .o_inmediate_extended_value(wire_ext_sign_o_inmediate_extended_value)
);

shift_left2 shift_left2_inst(
    .i_inmediate_extended_value(wire_buffer_id_ex_o_ext_sign),
    .o_shifted_value(wire_shift_left_o_shifted_value)
);

unidad_de_control_alu unidad_de_control_alu_inst(
	.alu_op(wire_buffer_id_ex_o_aluOp),
	.func_field(wire_buffer_id_ex_o_ext_sign[5:0]),
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

instruction_mux instruction_mux_inst(
	.regDst(wire_cu_o_regDst),
    .i_rt(wire_buffer_id_ex_o_rt),
    .i_rd(wire_buffer_id_ex_o_rd),
    .o_br_write_address(wire_inst_mux_o_br_write_address)
);

alu_mux alu_mux_inst(
	.aluSrc(wire_buffer_id_ex_o_aluSrc),
    .i_read_data_2(wire_rb_read_data_2),
    .i_immediate_extended_value(wire_buffer_id_ex_o_ext_sign),
    .result(wire_alu_mux_o_alu_data_2)
);

gate_and_branch gate_and_branch_inst(
	.branch(wire_cu_o_branch),
    .ZF(wire_alu_zflag),
    .result(wire_and_branch_result)
);

pc_mux pc_mux_inst(
	.selector(wire_and_branch_result),
	.i_pc_value(wire_buffer_ex_mem_o_branch_address),
	.i_sum_alu_result(wire_sum_alu_o_branch_address),
	.o_result_pc_address(wire_pc_mux_o_result_pc_address)
);
 
	
endmodule