//Equipo: Los Muñonez

`timescale 1ns/1ns

module multiplexor(
    input selector,
    input [31:0] i_ram,
    input [31:0] i_alu,
    output reg [31:0] result
);

always @* begin
    if(selector == 1'b1) begin
        result = i_ram;
    end
    else begin
        result = i_alu;
    end
end

endmodule