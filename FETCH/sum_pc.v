module sum_pc(
	
	input [31:0] i_address_pc,
	output reg [31:0] o_address_pc

);

always @* begin
	
	o_address_pc = i_address_pc + 4;
	
end
endmodule

