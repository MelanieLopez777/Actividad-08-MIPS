//Equipo: Los Muñonez

`timescale 1ns/1ns

module datapath_tipo_r_tb();

wire zflag_tb;
reg [31:0] wire_instruction_TB;

datapath_tipo_r datapath_tipo_r_inst(
	.instruction(wire_instruction_TB),
	.Zflag(zflag_tb)
);

initial begin
    $readmemb("./datos_banco_de_registros.txt", datapath_tipo_r_inst.banco_de_registros_inst.mem);
end

initial begin
    wire_instruction_TB = 32'b00000000000000010010000000100000;
    #100;
    wire_instruction_TB = 32'b00000000001000100010100000100010;
    #100;
    wire_instruction_TB = 32'b00000000010000110011000000101010;
    #100;
    wire_instruction_TB = 32'b00000001010010110110100000100100;
    #100;
    wire_instruction_TB = 32'b00000001010010110111000000100101;
    #100;
	$stop;
end
endmodule
	
