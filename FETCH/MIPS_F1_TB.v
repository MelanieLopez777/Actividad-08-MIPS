//Equipo: Los Muñonez

`timescale 1ns/1ns

module MIPS_F1_TB();

reg clk_TB;
reg reset_TB;
reg read_enable_TB;

wire [31:0] wire_instruction_TB;

MIPS_F1 MIPS_F1_inst(
	.clk(clk_TB),
	.reset(reset_TB),
	.read_enable(read_enable_TB),
	.o_instruction(wire_instruction_TB)
);

initial begin
    clk_TB = 0; 
    forever #10 clk_TB = ~clk_TB;  
end

initial begin
     $readmemb("C:\Users\alems\Documents\Actividad-08-MIPS\FETCH\instrucciones.txt",MIPS_F1_inst.memoria_de_instrucciones_inst.mem);
 end

initial begin

	reset_TB = 1'b1;
	read_enable_TB = 1'b0;
	#100;
	reset_TB = 1'b0;
	read_enable_TB = 1'b1;
	#1000;
	$stop;
end
endmodule
	
