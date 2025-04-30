//Equipo: Los Muñonez

`timescale 1ns/1ns

module unidad_de_control(
    input [5:0] op_code,
    output reg mem_to_reg,
    output reg mem_write_enable,
    output reg mem_read_enable,
    output reg [2:0] alu_op_code,
    output reg reg_write
);

always @* begin
    case (op_code)
        6'b000000:
        begin
            mem_to_reg = 1'b0;
            mem_write_enable = 1'b0;
            mem_read_enable = 1'b0;
            alu_op_code = 3'b010;
            reg_write = 1'b1;
        end
        default: 
        begin
            mem_to_reg = 1'bx;
            mem_write_enable = 1'bx;
            mem_read_enable = 1'bx;
            alu_op_code = 3'bxxx;
            reg_write = 1'bx;
        end
    endcase
end

endmodule