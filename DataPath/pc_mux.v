//Equipo: Los Muñonez

`timescale 1ns/1ns

module pc_mux(
    input selector,
    input [31:0] i_pc_value,
    input [31:0] i_sum_alu_result,
    output reg [31:0] o_result_pc_address
);

always @* begin

    if(selector == 1'b1) begin
        o_result_pc_address = i_sum_alu_result;
    end
    else begin
        o_result_pc_address = i_pc_value;
    end
end

endmodule