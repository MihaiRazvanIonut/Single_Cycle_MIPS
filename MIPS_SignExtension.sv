
module SignExtensionModule (

    input [15 : 0] Instruction,
    output [31 : 0] ExtendedInstruction
);

    assign ExtendedInstruction = {{16{Instruction[15]}}, Instruction};

endmodule
