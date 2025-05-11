//Equipo: Los Muñonez

`timescale 1ns/1ns

module gate_and_branch(
    input branch,
    input ZF,
    output result
);

assign result = branch && ZF;

endmodule