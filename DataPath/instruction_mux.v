//Equipo: Los Muñonez

`timescale 1ns/1ns

module instruction_mux(
    input regDst,
    input [4:0] i_rt,
    input [4:0] i_rd,
    output reg [4:0] o_br_write_address
);

always @* begin
    if(regDst == 1'b1) begin
        o_br_write_address = i_rd;
    end
    else begin
        o_br_write_address = i_rt;
    end
end

endmodule