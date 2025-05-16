module multiplexor_tipo_j (
    input i_selector,
    input [31:0] i_jump_address,
    input [31:0] i_branch_address_pc,
    output reg [31:0] o_mux_pc_address
);

always @* begin
    if (i_selector == 1'b1) begin
        o_mux_pc_address = i_jump_address;
    end
    else begin
        o_mux_pc_address = i_branch_address_pc;
    end
end
    
endmodule