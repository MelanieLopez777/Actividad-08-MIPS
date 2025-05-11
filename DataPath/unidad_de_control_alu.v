//Equipo: Los Muñonez

`timescale 1ns/1ns

module unidad_de_control_alu(
	input [2:0] alu_op,
	input [5:0] func_field,
	output reg [3:0] alu_code
);

always @* begin
	case (alu_op)
		3'b000: alu_code = 4'b0010;
		3'b001: alu_code = 4'b0110;
		3'b100: alu_code = 4'b0111;
		3'b101: alu_code = 4'b0000;
		3'b011: alu_code = 4'b0001;
		3'b010:
		begin
			case (func_field)
				6'b100000: alu_code = 4'b0010; // ADD
				6'b100010: alu_code = 4'b0110; // SUB
				6'b100100: alu_code = 4'b0000; // AND
				6'b100101: alu_code = 4'b0001; // OR
				6'b100111: alu_code = 4'b1100; // NOR
				6'b101010: alu_code = 4'b0111; // SLT
				default:
					alu_code = 4'bxxxx;
			endcase
		end
		default: 
			alu_code = 4'bxxxx;
	endcase
end

endmodule