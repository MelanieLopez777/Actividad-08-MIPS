//Equipo: Los Muñonez

`timescale 1ns/1ns

module memoria_de_instrucciones(
    input wire [31:0] address,
    output reg [31:0] o_data
);

reg [7:0] mem [0:999];

initial begin 
	$readmemb("instrucciones.txt", mem);
end

always @* begin
    o_data = {mem[address], mem[address+1], mem[address+2], mem[address+3]};
end

endmodule
