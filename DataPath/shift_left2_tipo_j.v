module shift_left2_tipo_j (
    input [25:0] i_shifted_value_jump,
    output reg [27:0] o_shifted_value_jump
);
    
always @* begin
    o_shifted_value_jump = {i_shifted_value_jump << 2, 2'b00};
end

endmodule