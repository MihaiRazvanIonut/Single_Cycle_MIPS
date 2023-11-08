module ControlModule (

    input   [5 : 0] OpCode,
    output  [1 : 0] RegDst,
    output          Jump,
    output          Branch,
    output          MemRead,
    output  [1 : 0] MemToReg,
    output          MemWrite,
    output          ALUSrc,
    output          RegWrite,
    output  [1 : 0] ALUOp
);

    reg [11 : 0] ControlCodes;

    assign {RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, ALUOp} = ControlCodes;

    always @(*) begin

        case (OpCode)
            6'b000000: ControlCodes = 12'b010000000110; // R-type
            6'b100011: ControlCodes = 12'b000010101100; // lw
            6'b101011: ControlCodes = 12'b000000011000; // sw
            6'b000100: ControlCodes = 12'b000100000001; // beq
            6'b001000: ControlCodes = 12'b000000001100; // addi
            6'b000010: ControlCodes = 12'b001000000000; // j
            6'b000011: ControlCodes = 12'b101001000100; // jal
            default:   ControlCodes = 12'bxxxxxxxxxxxx; // Not defined
        endcase
    end

endmodule
