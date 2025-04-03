//Equipo: Los Muñonez 

`timescale 1ns / 1ns

module buffer_contador_de_programa(
	input wire clk,
	input wire reset,
    input wire [31:0] i_data,
	output reg [31:0] o_data
);

always @(posedge clk) begin
	
	if(reset == 1'b1)
		begin
			o_data = 32'b00000000000000000000000000000000;
		end
	else
		begin
		o_data = i_data;
		end
end

endmodule