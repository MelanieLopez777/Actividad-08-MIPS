//Equipo: Los Muñonez

`timescale 1ns/1ns

module ram (
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire [3:0] byte_enable,
    input wire write_enable,
    output reg [31:0] dout
);

reg [31:0] mem [0:1023];

// La dirección de la RAM es de 10 bits (2^10 = 1024 palabras) y se divide entre 4
wire [9:0] word_address = address[11:2]; 

always @* begin
    if (write_enable) begin
		// Escritura
        if (byte_enable[0]) mem[word_address][7:0]   = write_data[7:0];   // Byte 0
        if (byte_enable[1]) mem[word_address][15:8]  = write_data[15:8];  // Byte 1
        if (byte_enable[2]) mem[word_address][23:16] = write_data[23:16]; // Byte 2
        if (byte_enable[3]) mem[word_address][31:24] = write_data[31:24]; // Byte 3
    end
	// Lectura
    dout <= mem[word_address];
end

endmodule