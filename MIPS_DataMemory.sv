module DataMemoryModule #(parameter MemSize = 4096)(

    input               Clk,
    input               MemWrite,
    input               MemRead,
    input      [31 : 0] Adress,
    input      [31 : 0] WriteData,
    output reg [31 : 0] ReadData
);

    reg [31 : 0] SimpleMemory [MemSize - 1 : 0];

    reg [31 : 0] i;
    initial
      for (i = 0; i < MemSize; i = i + 1)
          SimpleMemory[i] = 0;

    initial
        ReadData = 0;

    always @(posedge Clk) begin
        if (MemWrite)
            SimpleMemory[Adress] <= WriteData;
        if (MemRead)
            ReadData <= SimpleMemory[Adress];
    end
    
endmodule 
