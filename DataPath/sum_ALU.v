//Equipo: Los Muñonez 

`timescale 1ns/1ns

module sum_ALU(
    input [31:0] i_pc_address,                
    input [31:0] i_shifted_value, 
    output reg [31:0] o_branch_address 
);

always @(*) begin
    o_branch_address = i_pc_address + i_shifted_value; 
end

endmodule
