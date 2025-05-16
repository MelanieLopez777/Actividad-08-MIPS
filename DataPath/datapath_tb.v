//Equipo: Los Muñonez

`timescale 1ns/1ns

module datapath_tb();

reg clk;
reg reset;

datapath datapath_inst(
	.clk(clk),
	.reset(reset)
);

initial begin
	$readmemb("./datos_banco_de_registros.txt", datapath_inst.banco_de_registros_inst.mem);
end

initial begin
	clk = 0; 
	forever #10 clk = ~clk;
end

initial begin
	reset = 1'b1;
	#20;
	reset = 1'b0;
	#1500;
	$stop;
end
endmodule
	
