//Equipo: Los Muñonez

`timescale 1ns/1ns

module banco_de_registros (
    input write_enable,
    input [4:0] read_reg_1,
    input [4:0] read_reg_2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data_1,
    output [31:0] read_data_2
);
reg [31:0] mem [0:999];

assign read_data_1 = mem[read_reg_1];
assign read_data_2 = mem[read_reg_2];

always @* begin
    if (write_enable) begin
        mem[write_reg] <= write_data;
    end
end

endmodule
