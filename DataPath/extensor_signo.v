//Equipo: Los Muñonez 

`timescale 1ns/1ns

module extensor_signo(
    input [15:0] i_inmediate_value,   
    output reg [31:0] o_inmediate_extended_value
);

always @(*) begin
    
    o_inmediate_extended_value = {{16{i_inmediate_value[15]}},i_inmediate_value};
end

endmodule