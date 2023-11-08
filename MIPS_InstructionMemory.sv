module InstructionMemoryModule #(parameter MemSize = 4096)(

    input  [31 : 0] ReadAdress,
    output [31 : 0] Instruction
);

    reg [31 : 0] SimpleMemory[MemSize - 1 : 0];
    initial begin
      $readmemh ("dummymem.dat", SimpleMemory);
    end

  assign Instruction = SimpleMemory[ReadAdress[31:2]];

endmodule
