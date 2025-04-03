//Equipo: Los Muñonez

module memoria_de_instrucciones(
    input wire read_enable,
    input wire [31:0] address,
    output reg [31:0] o_data
);

reg [7:0] mem [0:999];

always @* begin
    if (read_enable == 1'b1)
    begin
		o_data = {mem[address], mem[address+1], mem[address+2], mem[address+3]};
	end
    else
    begin
        o_data = 32'dz;
    end
end

endmodule