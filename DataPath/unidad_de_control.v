//Equipo: Los Muñonez

`timescale 1ns/1ns

module unidad_de_control(
    input [5:0] op_code,
    output reg branch,
    output reg [1:0] memRead,
    output reg [2:0] aluOp,
    output reg memWrite,
    output reg aluSrc,
    output reg regWrite,
    output reg memToReg,
    output reg regDst,
    output reg jump
);

always @* begin
    case (op_code)
        6'b000000:
        begin
            memToReg = 1'b0;
            memWrite = 1'b0;
            memRead = 2'bxx;
            aluOp = 3'b010;
            regWrite = 1'b1;
            branch = 1'b0;
            aluSrc = 1'b0;
            regDst = 1'b1;
            jump = 1'b0;
        end
        //lw
        6'b100011:
        begin
            memToReg = 1'b1;
            memWrite = 2'bxx;
            memRead = 1'b1;
            aluOp = 3'b000;
            regWrite = 1'b1;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'b0;
            jump = 1'b0;
        end
        //sw
        6'b101011:
        begin
            memToReg = 1'bx;
            memWrite = 1'b1;
            memRead = 2'bxx;
            aluOp = 3'b000;
            regWrite = 1'b0;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'bx;
            jump = 1'b0;
        end
        // sb
        6'b101000:
        begin
            memToReg = 1'bx;
            memWrite = 1'b1;
            memRead = 2'bxx;
            aluOp = 3'b000;
            regWrite = 1'b0;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'bx;
            jump = 1'b0;
        end
        // sh
        6'b101001:
        begin
            memToReg = 1'bx;
            memWrite = 1'b1;
            memRead = 2'bxx;
            aluOp = 3'b000;
            regWrite = 1'b0;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'bx;
            jump = 1'b0;
        end
        // lb
        6'b100000:
        begin
            memToReg = 1'b1;
            memWrite = 1'b0;
            memRead = 2'b01;
            aluOp = 3'b000;
            regWrite = 1'b1;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'b0;
            jump = 1'b0;
        end
        // lbu
        6'b100100:
        begin
            memToReg = 1'b1;
            memWrite = 1'b0;
            memRead = 2'b10;
            aluOp = 3'b000;
            regWrite = 1'b1;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'b0;
            jump = 1'b0;
        end
        //beq
        6'b000100:
        begin
            memToReg = 1'bx;
            memWrite = 1'b0;
            memRead = 2'bxx;
            aluOp = 3'b001;
            regWrite = 1'b0;
            branch = 1'b1;
            aluSrc = 1'b0;
            regDst = 1'bx;
            jump = 1'b0;
        end
        //bne
        6'b000101:
        begin
            memToReg = 1'bx;
            memWrite = 1'b0;
            memRead = 2'bxx;
            aluOp = 3'b001;
            regWrite = 1'b0;
            branch = 1'b1;
            aluSrc = 1'b0;
            regDst = 1'bx;
            jump = 1'b0;
        end
        //bgtz
        6'b000111:
        begin
            memToReg = 1'bx;
            memWrite = 1'b0;
            memRead = 2'bxx;
            aluOp = 3'b001;
            regWrite = 1'b0;
            branch = 1'b1;
            aluSrc = 1'b0;
            regDst = 1'bx;
            jump = 1'b0;
        end
        //addi
        6'b001000:
        begin
            memToReg = 1'b0;
            memWrite = 1'b0;
            memRead = 2'bxx;
            aluOp = 3'b000;
            regWrite = 1'b1;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'b0;
            jump = 1'b0;
        end
        //andi
        6'b001100:
        begin
            memToReg = 1'b0;
            memWrite = 1'b0;
            memRead = 2'bxx;
            aluOp = 3'b101;
            regWrite = 1'b1;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'b0;
            jump = 1'b0;
        end
        //ori
        6'b001101:
        begin
            memToReg = 1'b0;
            memWrite = 1'b0;
            memRead = 2'bxx;
            aluOp = 3'b011;
            regWrite = 1'b1;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'b0;
            jump = 1'b0;
        end
        //slti
        6'b001010:
        begin
            memToReg = 1'b0;
            memWrite = 1'b0;
            memRead = 2'bxx;
            aluOp = 3'b100;
            regWrite = 1'b1;
            branch = 1'b0;
            aluSrc = 1'b1;
            regDst = 1'b0;
            jump = 1'b0;
        end
        // j
        6'b000010:
        begin
            memToReg = 1'bx;
            memWrite = 1'bx;
            memRead = 2'bxx;
            aluOp = 3'bxxx;
            regWrite = 1'b0;
            branch = 1'b0;
            aluSrc = 1'bx;
            regDst = 1'bx;
            jump = 1'b1;
        end
        default: 
        begin
            memToReg = 1'bx;
            memWrite = 1'bx;
            memRead = 2'bxx;
            aluOp = 3'bxxx;
            regWrite = 1'bx;
            branch = 1'bx;
            aluSrc = 1'bx;
            regDst = 1'bx;
            jump = 1'bx;
        end
    endcase
end

endmodule