// SINGLE CYCLE MIPS

// Smaller circuits needed

`include "MIPS_Adder.sv"
`include "MIPS_ALU.sv"
`include "MIPS_ALUControl.sv"
`include "MIPS_Control.sv"
`include "MIPS_DataMemory.sv"
`include "MIPS_InstructionMemory.sv"
`include "MIPS_MU2X1.sv"
`include "MIPS_ProgramCounter.sv"
`include "MIPS_Registers.sv"
`include "MIPS_Shift2Left.sv"
`include "MIPS_SignExtension.sv"
`include "MIPS_MUX3X1.sv"

// MIPS module
// Multiplexers are numbered from 1-6, starting from the left of the diagram and ending on the right
// The same goes for Shift Left 2 modules

module MIPSModule (

    input Clk,
    input Reset
    // Outputs to be determined
);
    //local parameters
    localparam MemSize = 4096;

    // MUX5

    wire [31 : 0] OutMux5;

    // MUX6

    wire [31 : 0] OutMux6;

    // Program counter
    wire [31 : 0] PC, PCnext;

    ProgramCounterModule PCM(Clk, Reset, OutMux6, PC);

    // Adder1
    wire [31 : 0] PCplus4;
    AdderModule AM1 (PC, 4, PCplus4);

    // Instruction Memory
    wire [31 : 0] Instruction;

    InstructionMemoryModule #(MemSize) IM(PC, Instruction);

    //Control
    wire [1 : 0] RegDst;
    wire [1 : 0] MemToReg;
    wire Jump, Branch, MemRead, MemWrite, ALUSrc, RegWrite;
    wire [1 : 0] ALUOp;

    ControlModule Control(Instruction[31:26], RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, ALUOp);

    //SignExtend
    wire [31 : 0] ExtendedInstruction;
    SignExtensionModule SE(Instruction[15:0], ExtendedInstruction);

    // ALUControl
    wire [3 : 0] OutALUOp;
    ALUControlModule ALUC(ALUOp, Instruction[5:0], OutALUOp);

    // MUX1
    wire [4 : 0] OutMux1;
    MUX3X1Module #(5) MUX1(Instruction[20:16], Instruction[15:11], 5'b11111, RegDst, OutMux1);

    // Registers
    wire [31:0] reg7;
    wire [31 : 0] RegValue1;
    wire [31 : 0] RegValue2;
  RegistersModule Regis(Clk, Reset, RegWrite, Instruction[25:21], Instruction[20:16], OutMux1, OutMux5, RegValue1, RegValue2, reg7);

    // MUX2

    wire [31 : 0] OutMux2;
    MUX2X1Module #(32) MUX2(RegValue2, ExtendedInstruction, ALUSrc, OutMux2);

    // ALU

    wire [31 : 0] ALUResult;
    wire          Zero;

    ALUModule ALUM(RegValue1, OutMux2, OutALUOp, ALUResult, Zero);

    // Data Memory

    wire [31 : 0] ReadData;
    DataMemoryModule #(MemSize) DMM (Clk, MemWrite, MemRead, ALUResult, RegValue2, ReadData);

    MUX3X1Module #(32) MUX5 (ALUResult, ReadData, PCplus4, MemToReg, OutMux5);

    // Shift2left1
    wire [31 : 0] JumpAdress;
    Shift2LeftModule S2LM1({2'b00, PCplus4[31:28],Instruction[25:0]}, JumpAdress);

    // Shift2left2
    wire [31 : 0] Shift2LeftExtendedInstr;

    Shift2LeftModule S2LM2(ExtendedInstruction, Shift2LeftExtendedInstr); 

    // Adder2
    wire [31 : 0] OutAM2;
    AdderModule AM2 (PCplus4, Shift2LeftExtendedInstr, OutAM2);  

    // And gate
    wire OutBranchAndZero;
    and AndGate(OutBranchAndZero, Branch, Zero);

    // Mux3
    wire [31 : 0] OutMux3;
    MUX2X1Module #(32) MUX3(PCplus4, OutAM2, OutBranchAndZero, OutMux3);

    // Mux4
    wire [31 : 0] OutMux4;
    MUX2X1Module #(32) MUX4(OutMux3, JumpAdress, Jump, PCnext);
  
    // MUX 6 (jr)
    MUX2X1Module #(32) MUX6(PCnext, RegValue1, OutALUOp[0], OutMux6);
endmodule